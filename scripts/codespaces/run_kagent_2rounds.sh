#!/usr/bin/env bash
# Testa a seleção real K-Agent (acionada a partir da rodada 2).
set -Eeuo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SRC="$ROOT/sbrc2026"
CFG="$SRC/selection-agent/pyproject.toml"
COMMIT="949f83c6db86d682240b7a61d1d2d406609413b6"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="$ROOT/evidencias/codespaces/kagent_2rodadas_$STAMP"
PID=""
BACKUP=0
mkdir -p "$OUT"
finish() {
  code=$?
  trap - EXIT
  set +e
  echo "script_exit_code=$code" > "$OUT/runner_status.txt"
  if [ "$BACKUP" = 1 ]; then cp "$OUT/config_anterior.toml" "$CFG"; fi
  if [ -n "$PID" ]; then kill "$PID" 2>/dev/null; fi
  tar -czf "$ROOT/evidencias_kagent_2rodadas_$STAMP.tar.gz" -C "$OUT" .
  echo "=== RESULTADOS: TESTE 2 RODADAS ==="
  echo "Status script: $code"
  echo "Baixe o arquivo: $ROOT/evidencias_kagent_2rodadas_$STAMP.tar.gz"
}
trap finish EXIT
exec > >(tee -a "$OUT/console.log") 2>&1
date -Is > "$OUT/inicio.txt"
uname -a > "$OUT/ambiente.txt"
if [ ! -f "$CFG" ]; then echo "Execute antes scripts/codespaces/run_tests.sh"; exit 2; fi
if [ "$(git -C "$SRC" rev-parse HEAD)" != "$COMMIT" ]; then echo "Commit divergente; abortando."; exit 3; fi
echo "$COMMIT" > "$OUT/commit.txt"
cp "$CFG" "$OUT/config_anterior.toml"
BACKUP=1
VENV="$HOME/.venvs/kagent-atividade7"
if [ ! -f "$VENV/bin/activate" ]; then echo "venv não encontrado."; exit 4; fi
source "$VENV/bin/activate"
python -V > "$OUT/python_version.txt"
python -m pip freeze > "$OUT/pip_freeze.txt"
flwr --version > "$OUT/flower_version.txt" 2>&1 || true
if ! command -v ollama >/dev/null; then echo "Ollama não instalado."; exit 5; fi
if ! curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_antes.json" 2>/dev/null; then
  ollama serve > "$OUT/ollama_servico.log" 2>&1 &
  PID=$!
  for i in $(seq 1 40); do
    if curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_antes.json" 2>/dev/null; then break; fi
    sleep 2
  done
fi
if ! curl -fsS http://127.0.0.1:11434/api/tags > "$OUT/ollama_tags_antes.json"; then echo "Ollama indisponível"; exit 6; fi
ollama list > "$OUT/ollama_modelos.txt"
if ! grep -q 'qwen3:0.6b' "$OUT/ollama_modelos.txt"; then ollama pull qwen3:0.6b | tee "$OUT/ollama_pull.log"; fi
git -C "$SRC" show "$COMMIT:selection-agent/pyproject.toml" > "$CFG"
python3 "$ROOT/scripts/codespaces/prepare_config.py" "$CFG" kagent
python3 - "$CFG" <<'PY'
import pathlib,re,sys
p=pathlib.Path(sys.argv[1])
s=p.read_text()
s,n=re.subn(r'(?m)^(num-server-rounds\s*=\s*)1\s*$',r'\g<1>2',s)
if n != 1: raise SystemExit("num-server-rounds ausente ou duplicado")
p.write_text(s)
PY
cp "$CFG" "$OUT/config_2rodadas.toml"
echo "=== Iniciando teste K-Agent: 2 rodadas, 5 clientes, CPU ==="
set +e
(cd "$SRC/selection-agent"; timeout --signal=TERM --kill-after=30s 1500 flwr run . local-simulation) 2>&1 | tee "$OUT/kagent_2rodadas.log"
RESULT=$?
set -e
echo "exit_code=$RESULT" > "$OUT/kagent_exit_status.txt"
grep -E 'ROUND|Selection tries|Agente selecionou|Initialize selection with agent|Selection Agent Error|SELECIONANDO' "$OUT/kagent_2rodadas.log" > "$OUT/indicadores_selecao.txt" || true
cat "$OUT/indicadores_selecao.txt"
ollama ps > "$OUT/ollama_ps.txt" 2>&1 || true
mkdir -p "$OUT/models" "$OUT/outputs"
find "$SRC/selection-agent/models" -maxdepth 1 -name '*.pt' -newer "$OUT/inicio.txt" -exec cp {} "$OUT/models/" \; 2>/dev/null || true
find "$SRC/selection-agent/outputs" -maxdepth 1 -name '*.json' -newer "$OUT/inicio.txt" -exec cp {} "$OUT/outputs/" \; 2>/dev/null || true
echo "K-Agent 2 rodadas: exit_code=$RESULT. Verifique logs e chamadas LLM; exit 0 isolado é insuficiente."
