#!/usr/bin/env bash
# Tentativa de reproduzir a reivindicação #1 do Selection Agent.
# 50 rodadas; 25 supernodes; k-agent / oort_selection / qwen3:0.6b.
# Uso: bash scripts/codespaces/run_kagent_50rounds.sh
# Necessita Codespaces existente, Ollama, venv e clone preparados.
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SOURCE="$ROOT/sbrc2026"
CFG="$SOURCE/selection-agent/pyproject.toml"
COMMIT="949f83c6db86d682240b7a61d1d2d406609413b6"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="$ROOT/evidencias/codespaces/kagent_50rodadas_$STAMP"
BUNDLE="$ROOT/evidencias_kagent_50rodadas_$STAMP.tar.gz"
PID=""
BACKUP=0
mkdir -p "$OUT"
finish() {
  status=$?
  trap - EXIT
  set +e
  echo "script_exit_code=$status" > "$OUT/runner_status.txt"
  if [ "$BACKUP" -eq 1 ]; then cp "$OUT/config_anterior.toml" "$CFG"; fi
  if [ -n "$PID" ]; then kill "$PID" 2>/dev/null; fi
  tar -czf "$BUNDLE" -C "$OUT" .
  echo ""
  echo "=== RESULTADOS - K-AGENT 50 RODADAS ==="
  echo "Status do script: $status"
  echo "Logs arquivados: $BUNDLE"
  echo "A conclusão da execução não comprova sozinha a redução de tráfego do artigo."
}
trap finish EXIT
exec > >(tee -a "$OUT/console.log") 2>&1

echo "=== NOVA EXECUCAO K-AGENT / 50 RODADAS ==="
date -Is | tee "$OUT/inicio.txt"
uname -a > "$OUT/ambiente.txt"
nproc >> "$OUT/ambiente.txt"
free -h >> "$OUT/ambiente.txt"
df -h "$ROOT" >> "$OUT/ambiente.txt"
if [ -f /sys/fs/cgroup/memory.max ]; then cat /sys/fs/cgroup/memory.max > "$OUT/limite_cgroup_memoria.txt"; fi

if [ ! -f "$CFG" ]; then
  echo "Código fonte não encontrado; execute primeiro os testes anteriores no mesmo Codespaces."
  exit 2
fi
if [ "$(git -C "$SOURCE" rev-parse HEAD)" != "$COMMIT" ]; then
  echo "Commit não é o fixado no estudo; interrompendo para não misturar versões."
  exit 3
fi
echo "$COMMIT" > "$OUT/commit.txt"
cp "$CFG" "$OUT/config_anterior.toml"
BACKUP=1
VENV="$HOME/.venvs/kagent-atividade7"
if [ ! -f "$VENV/bin/activate" ]; then
  echo "Ambiente virtual ausente; execute primeiro scripts/codespaces/run_tests.sh"
  exit 4
fi
source "$VENV/bin/activate"
python -V > "$OUT/python_version.txt"
python -m pip freeze > "$OUT/pip_freeze.txt"
flwr --version > "$OUT/flower_version.txt" 2>&1 || true

if ! command -v ollama >/dev/null 2>&1; then
  echo "Ollama ausente: instalando zstd (se necessário) e Ollama..."
  if ! command -v zstd >/dev/null 2>&1; then
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zstd
  fi
  curl -fsSL https://ollama.com/install.sh | sh
fi
if ! command -v ollama >/dev/null 2>&1; then
  echo "Ollama continua ausente após tentativa de instalação."
  exit 5
fi
ollama --version > "$OUT/ollama_version.txt" 2>&1 || true
if ! curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_inicial.json" 2>/dev/null; then
  echo "Iniciando Ollama..."
  ollama serve > "$OUT/ollama_servico.log" 2>&1 &
  PID=$!
  for i in $(seq 1 40); do
    if curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_inicial.json" 2>/dev/null; then break; fi
    sleep 2
  done
fi
if ! curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_inicial.json" 2>/dev/null; then
  echo "Serviço Ollama não respondeu. 50 rodadas não iniciadas."
  exit 6
fi
ollama list > "$OUT/ollama_modelos.txt" 2>&1
if ! grep -q 'qwen3:0.6b' "$OUT/ollama_modelos.txt"; then
  echo "Baixando qwen3:0.6b..."
  ollama pull qwen3:0.6b 2>&1 | tee "$OUT/ollama_pull.log"
fi

# Recomeça a partir da configuração canônica do commit, sem herdar parâmetros do teste reduzido.
git -C "$SOURCE" show "$COMMIT:selection-agent/pyproject.toml" > "$CFG"
python3 - "$CFG" <<'PY'
import os, pathlib, re, sys
path = pathlib.Path(sys.argv[1])
content = path.read_text(encoding="utf-8")
cpus = max(2, min(os.cpu_count() or 2, 4))
fields = {
    "num-supernodes": "25",
    "options.num-supernodes": "25",
    "num-server-rounds": "50",
    "sample-size": "-1",
    "selection-method": '"k-agent"',
    "k-agent-selection-method": '"oort_selection"',
    "prompt-type": '"chain-of-thought"',
    "llm-model-name": '"qwen3:0.6b"',
    "options.backend.client-resources.num-gpus": "0",
    "options.backend.init_args.num_gpus": "0",
    "options.backend.init_args.num_cpus": str(cpus),
}
for name, value in fields.items():
    pattern = r"(?m)^(\s*" + re.escape(name) + r"\s*=\s*)[^\n]*$"
    content, count = re.subn(pattern, lambda m, val=value: m.group(1) + val, content)
    if count != 1:
        raise SystemExit(f"Configuração inconsistente: {name}, ocorrências: {count}")
path.write_text(content, encoding="utf-8")
print(f"Configuração: k-agent / oort_selection / 50 rodadas / 25 clientes / CPU {cpus}")
PY
cp "$CFG" "$OUT/config_kagent_50rodadas.toml"

# Guarda o início preciso para copiar apenas novos outputs.
date -Is > "$OUT/inicio_experimento.txt"
echo "=== Início das 50 rodadas em $(date -Is) ==="
echo "Execução limitada a 5h. O Codespaces deve permanecer ativo. Cotas/custos podem ser aplicados."
set +e
(
  cd "$SOURCE/selection-agent"
  timeout --signal=TERM --kill-after=45s 18000 flwr run . local-simulation
) 2>&1 | tee "$OUT/kagent_50rodadas.log"
RUN_EXIT=$?
set -e
echo "exit_code=$RUN_EXIT" > "$OUT/kagent_exit_status.txt"
echo "=== Fim da tentativa em $(date -Is), código $RUN_EXIT ==="

grep -E 'ROUND|Selection tries|Agente selecionou|Strategy execution finished|Selection Agent Error|configure_train: Initialize selection' "$OUT/kagent_50rodadas.log" > "$OUT/marcadores_rodadas.txt" || true
tail -70 "$OUT/marcadores_rodadas.txt" || true
ollama ps > "$OUT/ollama_ps_final.txt" 2>&1 || true
curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_final.json" 2>/dev/null || true

mkdir -p "$OUT/outputs" "$OUT/models"
find "$SOURCE/selection-agent/outputs" -maxdepth 1 -type f -name '*.json' -newer "$OUT/inicio_experimento.txt" -exec cp {} "$OUT/outputs/" \; 2>/dev/null || true
find "$SOURCE/selection-agent/models" -maxdepth 1 -type f -name '*.pt' -newer "$OUT/inicio_experimento.txt" -exec cp {} "$OUT/models/" \; 2>/dev/null || true
echo "Arquivos novos de resultados:"
find "$OUT/outputs" "$OUT/models" -type f -printf '%p (%s bytes)\n' 2>/dev/null || true
echo "Atenção: para aferir redução de 44,4%–59%, é necessário comparador/baseline e análise quantitativa."
exit "$RUN_EXIT"
