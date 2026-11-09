#!/usr/bin/env python3
"""Produz nove segmentos de áudio em português brasileiro, sem assinatura."""
import asyncio, json
from pathlib import Path
import edge_tts

ROOT = Path(__file__).resolve().parent
DEST = ROOT / "audio_natural"
DEST.mkdir(parents=True, exist_ok=True)
scenes = json.loads((ROOT / "cenas.json").read_text(encoding="utf-8"))

async def main():
    for n, text in enumerate(scenes, start=1):
        path = DEST / f"slide_{n:02}.mp3"
        print(f"Gerando voz neural, slide {n:02}/{len(scenes)}", flush=True)
        for attempt in range(1, 4):
            try:
                if path.exists():
                    path.unlink()
                speech = edge_tts.Communicate(
                    text=text,
                    voice="pt-BR-AntonioNeural",
                    rate="-5%",
                    pitch="-2Hz",
                    volume="+0%",
                )
                await speech.save(str(path))
                if path.stat().st_size < 2000:
                    raise RuntimeError("Áudio vazio")
                break
            except Exception as exc:
                print(f"Falha na tentativa {attempt}: {exc}", flush=True)
                if attempt == 3:
                    raise
                await asyncio.sleep(5 * attempt)
    print("Narração integral gerada:", len(scenes), "segmentos", flush=True)

if __name__ == "__main__":
    asyncio.run(main())
