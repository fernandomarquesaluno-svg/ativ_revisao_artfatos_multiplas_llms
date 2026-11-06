#!/usr/bin/env python3
"""Adapta somente os parâmetros necessários para testes CPU do K-Agent.

Uso: python3 scripts/codespaces/prepare_config.py CAMINHO random|kagent
Não reproduz parâmetros de hardware do experimento original.
"""
import argparse
import os
import re
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument("path", type=Path)
p.add_argument("mode", choices=["random", "kagent"])
args = p.parse_args()

s = args.path.read_text(encoding="utf-8")
cpus = max(2, min(os.cpu_count() or 2, 4))

def replace_field(key: str, value: str) -> None:
    global s
    # Campos são exclusivos no TOML inspecionado; atualizamos o valor e preservamos o arquivo-base.
    pattern = r"(?m)^(\s*" + re.escape(key) + r"\s*=\s*)[^\n]*$"
    s, n = re.subn(pattern, lambda m: m.group(1) + value, s)
    if n != 1:
        raise RuntimeError(f"Esperada 1 ocorrência de {key!r}, encontradas {n}")

replace_field("num-supernodes", "5")
replace_field("options.num-supernodes", "5")
replace_field("num-server-rounds", "1")
replace_field("sample-size", "5" if args.mode == "random" else "-1")
replace_field("selection-method", '"random"' if args.mode == "random" else '"k-agent"')
replace_field("k-agent-selection-method", '"oort_selection"')
replace_field("llm-model-name", '"qwen3:0.6b"')
replace_field("options.backend.client-resources.num-gpus", "0")
replace_field("options.backend.init_args.num_gpus", "0")
replace_field("options.backend.init_args.num_cpus", str(cpus))

args.path.write_text(s, encoding="utf-8")
print(f"Configuração {args.mode} preparada: 5 clientes, 1 rodada, {cpus} CPUs, sem GPU")
