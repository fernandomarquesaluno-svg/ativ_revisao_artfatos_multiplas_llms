# Auditoria dos logs originais do GitHub Codespaces — 06/11/2026

## Escopo e origem

Três pacotes `.tar.gz` **gerados no Codespaces e enviados pelo aluno** em 06/11/2026. A auditoria leu entradas internas, registros de versões, configurações TOML, logs, códigos de saída e nomes/tamanhos dos artefatos de modelo. Os arquivos originais foram preservados pelo aluno; este texto é um **índice auditável** e não substitui os pacotes binários.

Todos os pacotes apontam para o mesmo commit inspecionado do artefato `rafaeloj/sbrc2026`:

`949f83c6db86d682240b7a61d1d2d406609413b6`.

Ambiente reportado: GitHub Codespaces (container baseado em Ubuntu 22.04, kernel Linux Azure), **Python 3.10.12, Flower 1.23.0, 4 vCPUs, memória disponível no host ~15 GiB, recursos de GPU desativados**. O tamanho de memória observado pelo comando `free` não deve ser confundido com recursos garantidos do plano Codespaces.

## Pacotes recebidos e integridade

| Pacote | SHA-256 | Conteúdo confirmado |
|---|---|---|
| `evidencias_codespaces_20261106T102421Z.tar.gz` | `10f22e0a254e1348f4b540a7a4c665f054073306503a1766b55d9790b1c9a2a8` | Random concluído; script abortado depois, na etapa de instalar Ollama |
| `evidencias_codespaces_20261106T103707Z.tar.gz` | `d7968fe9181f66e2c087cc196545b50de0df967d9066cb5848d5c4383bec3205` | Random concluído; script abortado na instalação do Ollama por ausência de `zstd` |
| `evidencias_codespaces_20261106T104101Z.tar.gz` | `846ad34e55a6dfc2118ba9b128c941c789817fd1031fbf8b48edafd80f01e0ff` | Random concluído; instalação do Ollama e `qwen3:0.6b` concluída; simulação com configuração `k-agent`, uma rodada, código de saída zero |

Os códigos de saída foram lidos de **arquivos de status gerados pelos scripts**, não inferidos apenas de capturas de tela. Os três arquivos tar não contêm caminhos absolutos, entradas `../` nem links simbólicos potencialmente inseguros.

## Matriz de execução verificada

| Tentativa (UTC) | Random (1 rodada) | Ollama | `k-agent` (1 rodada) | Status do script |
|---|---|---|---|---|
| 10:24:21 | `exit_code=0`, modelo salvo | etapa não concluída | não iniciado | `script_exit_code=1` |
| 10:37:07 | `exit_code=0`, modelo salvo | instalação falhou por `zstd` ausente | não iniciado | `script_exit_code=1` |
| 10:41:01 | `exit_code=0`, modelo salvo | instalação e pull concluídos; API `/api/tags` respondeu HTTP 200 | `exit_code=0`, modelo salvo | `script_exit_code=0` |

### Configurações capturadas da última tentativa

| Parâmetro | Random | `k-agent` |
|---|---|---|
| `selection-method` | `random` | `k-agent` |
| `num-server-rounds` | 1 | 1 |
| `num-supernodes` | 5 | 5 |
| `options.num-supernodes` | 5 | 5 |
| `sample-size` | 5 | -1 |
| `k-agent-selection-method` | `oort_selection` | `oort_selection` |
| `llm-model-name` | `qwen3:0.6b` (campo de configuração, não utilizado no teste Random) | `qwen3:0.6b` |
| GPUs | 0 | 0 |

### Resultados operacionais da última tentativa

- `random.log`: `[ROUND 1/1]`, `aggregate_train: Received 5 results and 0 failures`, `Strategy execution finished in 107.91s`, `Saving final model to disk...`; `random_exit_status.txt: exit_code=0`.
- `kagent_1rodada.log`: `[ROUND 1/1]`, `aggregate_train: Received 5 results and 0 failures`, `Strategy execution finished in 112.86s`, `Saving final model to disk...`; `kagent_exit_status.txt: exit_code=0`.
- `ollama_pull_exit_status.txt: exit_code=0`; `ollama_list.txt` identifica `qwen3:0.6b`, ID abreviado `7df6b6e09427`, tamanho 522 MB.
- Os arquivos de modelos `10_43_06_11_random_5_5_final_model_.pt` (1.690.517 bytes) e `10_46_06_11_k-agent_5_-1_final_model_.pt` (1.690.545 bytes) estão preservados no pacote final, dentro de `modelos_random/` e `modelos_kagent/`. Os diretórios podem também conter modelos de tentativas anteriores copiados automaticamente; não atribuir todos à última execução.
- O pacote não contém os JSON gerados em `selection-agent/outputs/`; contém os logs, configurações, status e modelos.
- `ollama_servico.log` registra HTTP 200 em `GET /api/tags` e `POST /api/pull`, **sem chamadas HTTP de inferência visíveis** durante o teste reduzido.

## Limitação crítica detectada na auditoria do código

O arquivo [`selection-agent/selection_agent/agent/selection_agent_strategy.py` no commit fixado](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/selection_agent/agent/selection_agent_strategy.py) executa a seleção por algoritmo/agente no método `configure_train` **somente quando `server_round > 1`**:

```python
if server_round > 1:
    ...
    result = self.selection_method.sample_clients(...)
```

Em `server_round = 1`, a implementação usa os clientes presentes sem invocar `sample_clients` do K-Agent. Portanto, **a configuração `selection-method="k-agent"` com uma única rodada não exercitou a seleção de clientes pelo agente, nem demonstrou inferência da LLM**. Isso é coerente com a ausência de chamadas `POST /api/chat` ou `POST /api/generate` nos logs de Ollama desta tentativa. Um arquivo de modelo com `k-agent` no nome ou código de saída zero **não prova que o agente tomou uma decisão**.

**Veredito correto para a nova execução:** a infraestrutura Flower/PyTorch realizou o teste Random e terminou uma rodada com a configuração nominal `k-agent`; o funcionamento da integração seletiva K-Agent/LLM continua **não comprovado**. Para testá-la, executar **pelo menos duas rodadas**, preservar os logs completos e verificar tanto `Selection tries (K-Agent)`/`Agente selecionou com sucesso.` quanto a comunicação Ollama e os resultados selecionados.

Essa descoberta não invalida os selos oficiais do SBRC nem modifica retroativamente os pareceres originais GPT-6, Claude e Gemini, que analisaram um **registro histórico diferente**.

## O que está efetivamente demonstrado

1. **Funcionalidade básica Flower/PyTorch executada** no Codespaces: sim, com configurações, logs, códigos de saída e arquivo(s) de modelo disponíveis.
2. **Disponibilidade do Ollama e download do `qwen3:0.6b`** na última tentativa: sim, verificados por log/API.
3. **Seleção dinâmica de clientes pelo K-Agent usando uma LLM:** **não demonstrada**, porque o script testou uma rodada e o código só invoca a seleção depois da primeira.
4. **Reprodutibilidade científica das 50 rodadas e redução de tráfego de 44,4% a 59%:** **não demonstrada**. Não há comparação reproduzida da principal reivindicação.

## Continuação segura

O próximo teste é **K-Agent em 2 rodadas**, no mesmo Codespaces e commit, com limite de duração, logs de Flower e Ollama, configuração capturada e retorno da ferramenta de seleção. Não iniciar as 50 rodadas sem verificar essa integração e a adequação dos recursos.

**Proveniência:** não misturar os novos logs de 06/11/2026 com os fragmentos de execução reportados anteriormente às três LLMs. A fase comparativa histórica permanece inalterada; a nova validação é uma etapa experimental adicional posterior.
