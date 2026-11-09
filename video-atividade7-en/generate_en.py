#!/usr/bin/env python3
"""Generate English narration locally using the free Kokoro neural voice."""
from pathlib import Path
import json, re, os
import numpy as np
import soundfile as sf
import torch
from kokoro import KPipeline

os.environ["HF_HUB_DISABLE_PROGRESS_BARS"]="1"
torch.set_num_threads(4)
ROOT=Path(__file__).resolve().parent
DEST=ROOT/"audio_en"
DEST.mkdir(parents=True,exist_ok=True)
scenes=json.loads((ROOT/"scenes_en.json").read_text(encoding="utf-8"))
pipe=KPipeline(lang_code="a",device="cpu")
RATE=24000
for n,scene in enumerate(scenes,1):
    print(f"English narration scene {n}/{len(scenes)}",flush=True)
    sentences=[p.strip() for p in re.split(r"(?<=[.!?])\\s+",scene) if p.strip()]
    samples=[]
    for sentence in sentences:
        for graphemes,phonemes,audio in pipe(sentence,voice="am_michael",speed=0.98):
            if audio is None or len(audio)<1000:
                raise ValueError(f"No audio for {sentence[:80]}")
            data=audio.detach().cpu().numpy() if hasattr(audio,"detach") else np.asarray(audio)
            samples.append(data.astype(np.float32))
            samples.append(np.zeros(int(RATE*0.16),dtype=np.float32))
    if not samples: raise ValueError(f"No audio for scene {n}")
    output=np.concatenate(samples)
    sf.write(DEST/f"scene_{n:02}.wav",output,RATE,subtype="PCM_16")
    print(f"Scene {n} duration: {len(output)/RATE:.2f}s",flush=True)
print("All English scenes completed.",flush=True)
