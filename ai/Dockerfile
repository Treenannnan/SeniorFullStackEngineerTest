FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv ffmpeg curl ca-certificates wget \
 && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN python3 -m pip install --upgrade pip

RUN pip install "ctranslate2==4.4.0" \
      -f https://opennmt-models.s3.amazonaws.com/ctranslate2/wheels/cu124.html \
 && pip install faster-whisper fastapi "uvicorn[standard]" requests ollama pydantic

WORKDIR /app
COPY . /app

EXPOSE 8000
CMD ["python3","-m","uvicorn","app:app","--host","0.0.0.0","--port","8000","--reload"]
