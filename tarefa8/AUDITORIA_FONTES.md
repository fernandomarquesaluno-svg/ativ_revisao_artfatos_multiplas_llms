# Auditoria independente de evidências — Tarefa 8

**Data:** 30/10/2026. **Artefato:** [rafaeloj/sbrc2026](https://github.com/rafaeloj/sbrc2026). **Commit consultado:** [`949f83c6db86d682240b7a61d1d2d406609413b6`](https://github.com/rafaeloj/sbrc2026/commit/949f83c6db86d682240b7a61d1d2d406609413b6).

Inspeção de arquivos públicos do GitHub e dos [critérios oficiais do SBRC 2026](https://doc-artefatos.github.io/sbrc2026/revinstrucoes.html). **Nenhum programa do artefato foi executado por esta auditoria.** Não há confirmação do commit usado originalmente na Tarefa 7.

## Evidências e verificações

| ID | Evidência alegada | Status e verificação | Fonte |
|---|---|---|---|
| A01 | README documenta instalação e teste mínimo | **Confirmada.** Contém instruções e exemplo de `flwr run . local-simulation` | [README](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/README.md) |
| A02 | Existe implementação Flower/LLM | **Confirmada documentalmente.** `server_app.py` inicializa treino; `k_agent.py` utiliza `ChatOllama` | [servidor](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/selection_agent/server_app.py), [agente](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/selection_agent/agent/k_agent.py) |
| A03 | Há versões de dependências | **Confirmada.** `requirements.txt` inclui `flwr[simulation]==1.23.0`, `torch==2.7.1`, `torchvision==0.22.1`, além de outras dependências com `>=` | [requirements](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/requirements.txt) |
| A04 | Configuração padrão equivale ao experimento principal | **Não.** `pyproject.toml`: `num-supernodes=5`, `sample-size=15`, `k-agent-selection-method='random_selection'`; README requer 25, -1, `oort_selection` | [configuração](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/pyproject.toml), [README](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/README.md) |
| A05 | Redução de tráfego de 44,4%–59% | **Confirmada apenas como reivindicação dos autores**, não reproduzida nestes logs | [README](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/README.md) |
| A06 | Scripts e notebooks publicados | **Confirmada.** `scripts/k_agent_prompt_type.sh` e notebooks das figuras/tabelas | [script](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/scripts/k_agent_prompt_type.sh), [notebooks](https://github.com/rafaeloj/sbrc2026/tree/949f83c6db86d682240b7a61d1d2d406609413b6/notebooks/sbrc2026) |
| A07 | Script de inicialização do Ollama ausente | **Não confirmada: arquivo existe** em `scripts/utils/k_start_ollama.sh` | [auxiliar](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/scripts/utils/k_start_ollama.sh) |
| A08 | Teste `random` valida a funcionalidade central K-Agent | **Não.** Caminho aleatório não exercita a inferência por LLM | [README](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/README.md), [agente](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/selection_agent/agent/k_agent.py) |
| A09 | Execução K-Agent concluiu 50 rodadas | **Não demonstrada nos logs fornecidos.** O teste interrompeu com conexão recusada | [logs T7](../LOGS_FORNECIDOS.md) |
| A10 | Selos F e R oficiais atribuídos | **Confirmada.** O CTA registra D/F/S/R para *Agente K-alibra* | [resultado do evento](https://doc-artefatos.github.io/sbrc2026/results.html) |

## Diagnóstico da falha

O registro `ConnectionRefusedError: [Errno 111] Connection refused` para `localhost:11434` é compatível com serviço Ollama não disponível ou inacessível no endereço esperado. **Não comprova defeito lógico no algoritmo.** Porém, os logs não mostram 50 rodadas concluídas, nem as métricas e os baselines necessários para validar a reivindicação de economia de tráfego.

## Regras oficiais e limitações

O SBRC 2026 requer para **F** dependências, versões, ambiente, instruções e exemplo mínimo **com prova de execução**; para **R**, reprodução das reivindicações experimentais e seus resultados. *Parcial* é categoria pedagógica, não selo oficial.

Os logs são transcrições do enunciado, sem terminal integral nem configuração efetiva comprovada. Os resultados desta auditoria **não substituem nem invalidam** a atribuição oficial do CTA.