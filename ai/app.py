import sys
#sys.path.append("C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\Lib\\site-packages")

from fastapi import FastAPI
from pydantic import BaseModel
from typing import List, Optional
from faster_whisper import WhisperModel
import requests
import tempfile
import os
from fastapi import HTTPException

import json
import re

from ollama import chat
from ollama import ChatResponse

import ctranslate2
print("CT2 version:", ctranslate2.__version__)
try:
    n = ctranslate2.get_cuda_device_count()
    print("CUDA devices:", n)
except AttributeError:
    n = 0
print("CUDA available:", n > 0)

class TranscribeReq(BaseModel):
    s3_url: Optional[str] = None
    local_path: Optional[str] = None
    language: Optional[str] = "en"

class TranscribeRes(BaseModel):
    text: str

class SummReq(BaseModel):
    existing: str
    transcript: str

class Category(BaseModel):
    label: str
    confidence: float

class SummRes(BaseModel):
    summary: str
    matches: List[Category]
    new_category: Optional[Category] 
    categories: List[Category] 

class TagReq(BaseModel):
    text: str
    max_tags: int = 3

class TagRes(BaseModel):
    tags: List[str]

def repair_json(raw, max_summary_len=250):
    if isinstance(raw, dict):
        data = raw
    else:
        text = str(raw)
        m = re.search(r"\{.*\}", text, flags=re.S)
        if not m:
            return {"summary": "", "matches_exist": [], "new_category": None, "categories": []}
        json_str = m.group(0)
        try:
            data = json.loads(json_str)
        except json.JSONDecodeError:
            json_str = re.sub(r",\s*([}\]])", r"\1", json_str) 
            data = json.loads(json_str)

    def norm_conf(x):
        try:
            v = float(x)
        except Exception:
            return None
        if not (0.0 <= v <= 1.0):
            return None
        return round(v, 2)

    def normalize_item(item):
        if not isinstance(item, dict):
            return None
        label = str(item.get("label", "")).strip()
        conf = norm_conf(item.get("confidence"))
        if not label or conf is None:
            return None
        return {"label": label, "confidence": conf}

    summary = str(data.get("summary", "")).strip()
    if len(summary) > max_summary_len:
        cut = summary[:max_summary_len]
        tail = cut[-50:]
        last_punct = max(tail.rfind("."), tail.rfind("!"), tail.rfind("?"))
        if last_punct != -1:
            cut = cut[:len(cut) - 50 + last_punct + 1]
        summary = cut

    cleaned_matches = []
    seen = {}
    raw_matches = data.get("matches_exist", [])
    if isinstance(raw_matches, list):
        for it in raw_matches:
            norm = normalize_item(it)
            if not norm:
                continue
            lab = norm["label"]
            if (lab not in seen) or (norm["confidence"] > seen[lab]["confidence"]):
                seen[lab] = norm
    cleaned_matches = list(seen.values())

    new_cat_items = []
    raw_new = data.get("new_category", None)
    if isinstance(raw_new, dict):
        norm = normalize_item(raw_new)
        if norm:
            new_cat_items.append(norm)
    elif isinstance(raw_new, list):
        for it in raw_new:
            norm = normalize_item(it)
            if norm:
                new_cat_items.append(norm)
    else:
        raw_new = None 

    new_cat_best = None
    if new_cat_items:
        new_cat_best = max(new_cat_items, key=lambda x: x["confidence"])

    normalized_new_category = new_cat_best

    by_label = {m["label"]: m for m in cleaned_matches}
    for it in new_cat_items:
        lab = it["label"]
        if (lab not in by_label) or (it["confidence"] > by_label[lab]["confidence"]):
            by_label[lab] = it

    categories = sorted(by_label.values(), key=lambda x: x["confidence"], reverse=True)[:5]

    cleaned_matches = sorted(cleaned_matches, key=lambda x: x["confidence"], reverse=True)[:5]

    return {
        "summary": summary,
        "matches": cleaned_matches,
        "new_category": normalized_new_category, 
        "categories": categories    
    }

def clamp_transcript_for_ctx(transcript: str, n_ctx: int, max_tokens: int, safety: int = 256) -> str:
    usable_tokens = max(n_ctx - max_tokens - safety, 256)
    approx_chars = int(usable_tokens * 3.5)
    if len(transcript) <= approx_chars:
        return transcript
    return transcript[:approx_chars]

app = FastAPI(title="AI Worker")

#os.add_dll_directory(r"C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v13.0\\bin")
#os.add_dll_directory(r"C:\\Program Files\\NVIDIA\\CUDNN\\v9.12\bin\\13.0")

whisper = WhisperModel("small", compute_type="float16", device="auto") 


@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/transcribe", response_model=TranscribeRes)
def transcribe(req: TranscribeReq):

    audio_path = req.local_path
    tmp_path = None

    if audio_path.startswith("http://") or audio_path.startswith("https://"):
        try:
            resp = requests.get(audio_path, stream=True)
            resp.raise_for_status()
            with tempfile.NamedTemporaryFile(delete=False, suffix=".mp3") as tmp:
                for chunk in resp.iter_content(chunk_size=8192):
                    if chunk:
                        tmp.write(chunk)
                audio_path = tmp.name
                tmp_path = audio_path
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Error downloading file: {e}")
        
    segments, info = whisper.transcribe(
    audio = audio_path,
    task="transcribe", 
    language="en",
    )

    try:
        segments, info = whisper.transcribe(
            audio=audio_path,
            task="transcribe",
            language="en",
        )
        text = " ".join([seg.text for seg in segments])
        return TranscribeRes(text=text.strip())
    finally:
        if tmp_path and os.path.exists(tmp_path):
            os.remove(tmp_path)

@app.post("/summarize", response_model=SummRes)
def summarize(req: SummReq):

    clamp_transcript = clamp_transcript_for_ctx(req.transcript, n_ctx=8192, max_tokens=1000)

    sum_prompt = f"""
You must return ONE valid JSON object only.
No extra text. No code fences. No explanations.

You are an expert annotator. Analyze the TRANSCRIPT and generate a summary.

Hard constraints

"summary" length must be between 320 and 330 characters inclusive.

Writing style: engaging, spoiler-free, no intro phrases (e.g., “This is about...”).

Do not exceed 330 characters. Do not go below 320 characters.

Return JSON exactly in this schema:
{{
  "summary": "300-350 characters",
}}

TRANSCRIPT:{clamp_transcript}"
    """

    cat_prompt = f"""
You must return ONE valid JSON object only.
No extra text. No code fences. No explanations.

You are an expert annotator. Read the TRANSCRIPT and assign categories.

Hard constraints

- Each category label must be a single word (no spaces, hyphens, or emojis) and ≤ 13 characters.
- Prioritize Existing categories first when they are semantically relevant.
- Confidence values are floats in [0,1] with 3 decimals (e.g., 0.842).
- No duplicate labels across any list (case-insensitive).
- Sort items in each list by confidence descending.
- Combined total across matches_exist and new_category must include ≥ 3 unique labels.
- Do NOT use generic or meaningless labels such as: news, general, other, misc, random, uncategorized, or any equivalent.
- Skip them if they appear in Existing categories or if the model would generate them.
- Selected categories must be distinct and not semantically redundant. If multiple labels are very similar in meaning (e.g., Novel, Fiction, Story), pick only the most widely recognized one.
- Prefer standard bookstore-style categories (e.g., Fiction, Nonfiction, Biography, History, Science, Philosophy, Children, Romance, Fantasy, Mystery, Poetry, Religion, Politics, Business, Health, Travel). Avoid hyper-specific or obscure terms.

Decision rules

1. matches_exist (up to 5 items)
1.1 Consider only labels from Existing categories.
1.2 Add a label if it closely matches the main topics in TRANSCRIPT (semantic similarity / keyword overlap / intent match).
2. new_category (up to 3 items)
2.1 Use only when Existing categories do not adequately cover the content.
2.2 If you have fewer than 3 high-confidence (≥ 0.800) matches in matches_exist, propose new labels to cover uncovered topics.
2.3 New labels must be concise, generic, and reusable (avoid names, IDs, or overly specific phrases).
2.4 Ensure that the combined total of matches_exist and new_category provides at least 3 unique labels.
2.5 If any Existing label violates the “single-word ≤13 chars” rule, skip it.

Return JSON exactly in this schema:
{{
  "matches_exist": [{{"label":"<from existing>","confidence":0.xxx}} ... up to 5 or empty],
  "new_category":[{{"label":"<new>","confidence":0.xxx}} ... up to 3 or empty]
}}

Inputs

Existing categories (string; may be empty): {req.existing}

TRANSCRIPT: {clamp_transcript}

Process (do not output these steps)

Extract the 1–3 dominant topics from TRANSCRIPT.

Map them to the closest valid Existing labels; assign calibrated confidences.

If fewer than 3 items in matches_exist have confidence ≥ 0.800, add up to 3 new_category items to ensure ≥ 3 unique total labels.

Ensure all labels are single-word and ≤13 chars; otherwise adjust (for new_category only).
    """
    #print(req.existing)
    #print(clamp_transcript)

    sum_out: ChatResponse = chat(
        model='llama3.1:8b',
        messages=[{'role':'user','content': sum_prompt}],
        options={
            'num_ctx': 8192,   
            'num_thread': 12, 
            # 'num_gpu': 1, 
            'temperature': 0.2, 'top_p': 0.9,
        }
    )

    sum_raw = repair_json(sum_out['message']['content'], 550)

    #print(sum_raw)
    sum_data = SummRes(**sum_raw)

    cat_out: ChatResponse = chat(
        model='llama3.1:8b',
        messages=[{'role':'user','content': cat_prompt}],
        options={
            'num_ctx': 8192,   
            'num_thread': 12, 
            # 'num_gpu': 1, 
            'temperature': 0.2, 'top_p': 0.9,
        }
    )

    cat_raw = repair_json(cat_out['message']['content'], 550)

    #print(cat_raw)

    cat_data = SummRes(**cat_raw)

    sum_data.categories = cat_data.categories

    return sum_data