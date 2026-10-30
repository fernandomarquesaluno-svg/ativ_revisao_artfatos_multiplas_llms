# Logs fornecidos para a avaliação

> Estes registros foram transcritos do enunciado e **não foram gerados por execução independente** do modelo avaliador.

## Ambiente informado

- Ubuntu 22.04 LTS
- Python 3.10
- PyTorch 2.7.1
- 8 vCPUs e 16 GB RAM

## Evidência 1 — Seleção aleatória

```bash
cd selection-agent && flwr run . local-simulation --options selection-method='random' num-server-rounds=1
```

```text
[SUCCESS] Simulation finished.
Modelo salvo em models/20260315_random_final_model_.pt
```

## Evidência 2 — K-Agent, 50 rodadas

```bash
cd selection-agent && flwr run . local-simulation --options selection-method='k-agent' num-server-rounds=50
```

```text
Attempting connection to Ollama model qwen3:0.6b at http://localhost:11434...
ConnectionRefusedError: [Errno 111] Connection refused
[ERROR] K-Agent selection failed. Execution aborted.
```

**Limitação:** não foram fornecidos logs completos, hash do commit avaliado, dados de saída ou as configurações efetivas de toda a simulação.