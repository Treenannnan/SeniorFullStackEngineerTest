from huggingface_hub import hf_hub_download
from llama_cpp import Llama
from pathlib import Path
import os

def ensure_gguf_model(repo_id: str, filename: str, local_dir: str = "./models") -> str:
    Path(local_dir).mkdir(parents=True, exist_ok=True)
    local_path = Path(local_dir) / filename
    if local_path.exists():
        return str(local_path)

    model_path = hf_hub_download(
        repo_id=repo_id,
        filename=filename,
        local_dir=local_dir,
        local_dir_use_symlinks=False,
        resume_download=True
    )
    return model_path

def load_llama_from_hf(
    repo_id="bartowski/Meta-Llama-3-8B-Instruct-GGUF",
    filename="Meta-Llama-3-8B-Instruct-Q4_K_M.gguf",
    local_dir="./models",
    n_ctx=4096,
    n_threads=8,
    n_gpu_layers=-1,
    verbose=True
):
    model_path = ensure_gguf_model(repo_id, filename, local_dir)
    llm = Llama(
        model_path=model_path,
        n_ctx=n_ctx,
        n_threads=n_threads,
        n_gpu_layers=n_gpu_layers,
        verbose=verbose
    )
    return llm
