#!/usr/bin/env python3
"""Narração gratuita por modelo neural Kokoro-82M, pt-BR masculino Alex."""
from pathlib import Path
import json
import re
import os
import numpy as np
import soundfile as sf
import torch
from kokoro import KPipeline

os.environ["HF_HUB_DISABLE_PROGRESS_BARS"] = "1"
torch.set_num_threads(4)

ROOT=Path(__file__).resolve().parent
DEST=ROOT/"audio_natural"
DEST.mkdir(parents=True, exist_ok=True)
scenes=json.loads((ROOT/"cenas.json").read_text(encoding="utf-8"))
pipeline=KPipeline(lang_code="p",device="cpu")
SAMPLE_RATE=24000

for n, scene in enumerate(scenes[:1], 1):
    print(f"Narrando slide {n:02}/{len(scenes)} com voz neural brasileira Alex", flush=True)
    sentences=[x.strip() for x in re.split(r'(?<=[.!?])\s+', scene) if x.strip()]
    samples=[]
    for sentence in sentences:
        generator=pipeline(sentence, voice="pm_alex", speed=0.97)
        for graphemes,phonemes,audio in generator:
            if audio is None or len(audio)<1000:
                raise RuntimeError(f"Falha na síntese: {sentence[:60]}")
            audio=audio.detach().cpu().numpy() if hasattr(audio,"detach") else np.asarray(audio)
            samples.append(audio.astype(np.float32))
            # 130ms entre períodos para melhorar ritmo
            samples.append(np.zeros(int(SAMPLE_RATE * 0.13),dtype=np.float32))
    if not samples:
        raise RuntimeError(f"Slide {n} não produziu áudio")
    out=np.concatenate(samples)
    assert len(out)>SAMPLE_RATE*8
    sf.write(DEST/f"slide_{n:02}.wav",out,SAMPLE_RATE,subtype="PCM_16")
    print("Duração:",round(len(out)/SAMPLE_RATE,2),"s",flush=True)
print("Slide de abertura atualizado em PT-BR",flush=True)
