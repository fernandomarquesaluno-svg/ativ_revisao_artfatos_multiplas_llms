#!/usr/bin/env bash
# Atividade 7 — novas execuções com logs rastreáveis (não recria logs antigos).
# Uso no Codespaces: bash scripts/codespaces/run_tests.sh
set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
LOGS="$ROOT/evidencias/codespaces/$STAMP"
SOURCE="$ROOT/sbrc2026"
COMMIT="949f83c6db86d682240b7a61d1d2d406609413b6"
OLLAMA_PID=""
mkdir -p "$LOGS"

finish() {
  status=$?
  trap - EXIT
  set +e
  if [ -n "$OLLAMA_PID" ]; then
    kill "$OLLAMA_PID" 2>/dev/null
  fi
  printf 'script_exit_code=%s\n' "$status" > "$LOGS/runner_status.txt"
  tar -czf "$ROOT/evidencias_codespaces_$STAMP.tar.gz" -C "$LOGS" .
  echo ""
  echo "=== RESULTADOS ==="
  echo "Diretório: $LOGS"
  echo "Arquivo para baixar: $ROOT/evidencias_codespaces_$STAMP.tar.gz"
  echo "Código final do script: $status"
}
trap finish EXIT
exec > >(tee -a "$LOGS/console.log") 2>&1

echo "=== Atividade 7: execução NOVA em GitHub Codespaces ==="
echo "UTC: $(date -Is)"
echo "Essa execução NÃO recupera logs da máquina Ubuntu anterior."
date -Is > "$LOGS/ambiente.txt"
uname -a >> "$LOGS/ambiente.txt"
echo "CPUs disponíveis: $(nproc)" >> "$LOGS/ambiente.txt"
free -h >> "$LOGS/ambiente.txt" || true
df -h "$ROOT" >> "$LOGS/ambiente.txt"

echo "=== Instalando pré-requisitos do Ubuntu 22.04 ==="
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3.10 python3.10-venv python3-pip git curl ca-certificates zstd
python3.10 --version | tee -a "$LOGS/ambiente.txt"

echo "=== Obtendo código dos autores e fixando commit ==="
if [ ! -d "$SOURCE/.git" ]; then
  git clone https://github.com/rafaeloj/sbrc2026.git "$SOURCE"
fi
git -C "$SOURCE" fetch origin "$COMMIT"
git -C "$SOURCE" checkout --detach "$COMMIT"
git -C "$SOURCE" rev-parse HEAD > "$LOGS/commit.txt"
git -C "$SOURCE" status --short > "$LOGS/git_status.txt"
cp "$SOURCE/selection-agent/pyproject.toml" "$LOGS/pyproject_original.toml"

echo "=== Criando ambiente Python isolado ==="
VENV="$HOME/.venvs/kagent-atividade7"
mkdir -p "$(dirname "$VENV")"
python3.10 -m venv "$VENV"
source "$VENV/bin/activate"
export PIP_NO_CACHE_DIR=1
export PIP_PROGRESS_BAR=off
python -m pip install --upgrade pip
python -m pip install -r "$SOURCE/requirements.txt"
python -m pip install -e "$SOURCE/selection-agent"
python -m pip freeze > "$LOGS/pip_freeze.txt"
flwr --version > "$LOGS/flwr_version.txt" 2>&1 || true

echo "=== TESTE A: Random, 1 rodada, 5 clientes, sem GPU ==="
cp "$LOGS/pyproject_original.toml" "$SOURCE/selection-agent/pyproject.toml"
python3 "$ROOT/scripts/codespaces/prepare_config.py" "$SOURCE/selection-agent/pyproject.toml" random
cp "$SOURCE/selection-agent/pyproject.toml" "$LOGS/pyproject_random.toml"
set +e
(
  cd "$SOURCE/selection-agent"
  timeout --signal=TERM --kill-after=30s 1800 flwr run . local-simulation
) 2>&1 | tee "$LOGS/random.log"
RANDOM_EXIT=$?
set -e
printf 'exit_code=%s\n' "$RANDOM_EXIT" > "$LOGS/random_exit_status.txt"
find "$SOURCE/selection-agent/models" -maxdepth 1 -type f -printf '%p %s bytes\n' > "$LOGS/modelos_random.txt" 2>/dev/null || true
mkdir -p "$LOGS/modelos_random"
find "$SOURCE/selection-agent/models" -maxdepth 1 -type f -name "*.pt" -size -100M -exec cp -n {} "$LOGS/modelos_random/" \; 2>/dev/null || true
echo "Resultado Random, código de saída: $RANDOM_EXIT"

echo "=== TESTE B: preparar Ollama + qwen3:0.6b ==="
if ! command -v ollama >/dev/null 2>&1; then
  echo "Instalando Ollama por script oficial..."
  curl -fsSL https://ollama.com/install.sh | sh
fi
ollama --version > "$LOGS/ollama_versao.txt" 2>&1 || true
if ! curl -fsS http://127.0.0.1:11434/api/tags > "$LOGS/ollama_tags.json" 2>/dev/null; then
  echo "Iniciando Ollama local em segundo plano..."
  ollama serve > "$LOGS/ollama_servico.log" 2>&1 &
  OLLAMA_PID=$!
fi

OLLAMA_OK=0
for i in $(seq 1 35); do
  if curl -fsS http://127.0.0.1:11434/api/tags > "$LOGS/ollama_tags.json" 2>/dev/null; then
    OLLAMA_OK=1
    break
  fi
  sleep 2
done
if [ "$OLLAMA_OK" -ne 1 ]; then
  echo "Ollama indisponível em http://localhost:11434 — K-Agent não será iniciado."
  echo "nao_iniciado_ollama_indisponivel" > "$LOGS/kagent_exit_status.txt"
  exit 0
fi

set +e
ollama pull qwen3:0.6b 2>&1 | tee "$LOGS/ollama_pull.log"
PULL_EXIT=$?
set -e
printf 'exit_code=%s\n' "$PULL_EXIT" > "$LOGS/ollama_pull_exit_status.txt"
ollama list > "$LOGS/ollama_list.txt" 2>&1 || true
if [ "$PULL_EXIT" -ne 0 ]; then
  echo "Download do modelo falhou. K-Agent não iniciado."
  echo "nao_iniciado_modelo_indisponivel" > "$LOGS/kagent_exit_status.txt"
  exit 0
fi

echo "=== TESTE B: K-Agent reduzido, 1 rodada, 5 clientes, sem GPU ==="
cp "$LOGS/pyproject_original.toml" "$SOURCE/selection-agent/pyproject.toml"
python3 "$ROOT/scripts/codespaces/prepare_config.py" "$SOURCE/selection-agent/pyproject.toml" kagent
cp "$SOURCE/selection-agent/pyproject.toml" "$LOGS/pyproject_kagent_1rodada.toml"
set +e
(
  cd "$SOURCE/selection-agent"
  timeout --signal=TERM --kill-after=30s 1200 flwr run . local-simulation
) 2>&1 | tee "$LOGS/kagent_1rodada.log"
KAGENT_EXIT=$?
set -e
printf 'exit_code=%s\n' "$KAGENT_EXIT" > "$LOGS/kagent_exit_status.txt"
find "$SOURCE/selection-agent/models" -maxdepth 1 -type f -printf '%p %s bytes\n' > "$LOGS/modelos_kagent.txt" 2>/dev/null || true
mkdir -p "$LOGS/modelos_kagent"
find "$SOURCE/selection-agent/models" -maxdepth 1 -type f -name "*.pt" -size -100M -exec cp -n {} "$LOGS/modelos_kagent/" \; 2>/dev/null || true

echo "=== CONCLUSÃO DA NOVA TENTATIVA ==="
echo "Random: exit_code=$RANDOM_EXIT"
echo "K-Agent: exit_code=$KAGENT_EXIT"
echo "O teste de 1 rodada NÃO reproduz o experimento científico principal de 50 rodadas."
echo "Não atribuir selos F/R automaticamente: interpretar logs e métricas após a execução."
