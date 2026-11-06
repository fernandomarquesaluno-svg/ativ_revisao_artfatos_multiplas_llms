# Auditoria original — execução K-Agent com duas rodadas (06/11/2026)

**Situação: teste de funcionalidade central concluído com sucesso.** O pacote foi enviado pelo aluno a esta conversa e lido diretamente em 06/11/2026. **O experimento científico de 50 rodadas não foi reproduzido.**

## Identificação e integridade

- **Pacote original:** `evidencias_kagent_2rodadas_20261106T111254Z.tar.gz` (1.577.930 bytes).
- **SHA-256 do arquivo:** `d5667dd68c7c596f25d12e7810a3f43c336ab97dce0274857c62a4eeceee5e41`.
- **Início UTC registrado:** `2026-11-06T11:12:54+00:00`.
- **Commit do artefato:** `949f83c6db86d682240b7a61d1d2d406609413b6`.
- **Ambiente:** GitHub Codespaces, Python 3.10.12, Flower 1.23.0, cinco clientes, CPU (sem GPU), modelo Ollama `qwen3:0.6b`.
- **Arquivos de status no pacote:** `kagent_exit_status.txt` contém `exit_code=0`; `runner_status.txt` contém `script_exit_code=0`.
- **Configuração verificável:** `config_2rodadas.toml` registra `num-server-rounds=2`, `selection-method="k-agent"`, `num-supernodes=5`, `options.num-supernodes=5`, `sample-size=-1`, `k-agent-selection-method="oort_selection"` e `llm-model-name="qwen3:0.6b"`.

## Evidências verificadas diretamente

| Item | Evidência no pacote | Conclusão |
|---|---|---|
| Treinamento na rodada 1 | `kagent_2rodadas.log`: `[ROUND 1/2]`; cinco resultados de treino recebidos, nenhuma falha | Execução inicial do Flower confirmada |
| Invocação da seleção | `[ROUND 2/2]`, `configure_train: Initialize selection with agent`, `Selection tries (K-Agent): 1` | Chamou a lógica do K-Agent |
| Resposta do modelo | `outputs/...federation_data_3.json`: mensagem do modelo `qwen3:0.6b` com `tool_calls[0].name="oort_selection"`, argumentos `{"k":1}` | A LLM escolheu `k=1` e solicitou a ferramenta |
| Execução da ferramenta | JSON: mensagem `type="tool"`, `name="oort_selection"`, `status="success"` | Ferramenta concluiu com êxito |
| Cliente selecionado | JSON rodada 2: `selected_clients=["15709269447559507464"]`, `selection_algorithm="oort"` | Um dos cinco clientes foi selecionado |
| Comunicação com Ollama | `ollama_servico.log`: duas chamadas `POST /api/chat` com código HTTP **200** (11:15:35 UTC e 11:16:38 UTC) | Houve inferência real via Ollama |
| Treinamento na rodada 2 | `aggregate_train: Received 1 results and 0 failures` | A rodada com o cliente selecionado prosseguiu |
| Finalização | `Strategy execution finished in 284.79s`; `Saving final model to disk...`; saída `0` | Simulação de duas rodadas finalizada com sucesso |

O arquivo `ollama_ps.txt` ainda indica `qwen3:0.6b` em execução sobre CPU após o teste. O pacote preserva o arquivo de modelo `models/11_17_06_11_k-agent_5_-1_final_model_.pt` e o JSON de resultados `outputs/timestamp_11_17_06_11_method_k-agent_sample_size_-1_model_name_qwen3:0.6b_federation_data_3.json`.

**Ressalva fina:** a segunda resposta textual da LLM no JSON apresenta `done_reason="length"` (limite de geração), **mas a chamada de ferramenta anterior teve status de sucesso, o agente registrou seleção e o treinamento continuou sem falhas**. O limite de geração dessa resposta não invalida a evidência da seleção na rodada 2.

## Interpretação de F e R

**Funcionalidade (F):** diferentemente do teste anterior de uma rodada, agora existem **evidências primárias de execução da função distintiva do K-Agent com LLM**: inferência Ollama, seleção de `k=1`, execução de `oort_selection`, seleção efetiva de um cliente, treinamento e salvamento do modelo. Isso fornece evidência técnica forte de funcionalidade **no cenário reduzido e configurado**, sem inferir ausência de defeitos em outros cenários.

**Reprodutibilidade científica (R):** **não demonstrada** por este pacote. Duas rodadas com cinco clientes são diferentes das reivindicações do artigo, que exigem experimentos de maior escala (por exemplo, 50 rodadas, 25 clientes, comparadores). Não há reprodução verificada da faixa de redução de tráfego de 44,4% a 59%.

**Pareceres das três LLMs:** as respostas originais de GPT-6, Claude e Gemini se referiam aos **trechos históricos anteriores** de Random e falha por Ollama. O teste atual é posterior e **não altera seus vereditos históricos** sem uma nova rodada de avaliação.

## Resultado e destinação

- **Validação funcional reduzida do K-Agent/LLM:** **concluída**.
- **Reprodução quantitativa do artigo:** **pendente**, não ocultar.
- **Estado da entrega da Atividade 7:** com análise das LLMs, comparativo, registros dos prompts iguais, documentação e **novos logs de funcionalidade**, a atividade está **pronta para entrega com a limitação explícita de R**; isso não equivale a ter realizado toda a etapa científica requerida se o professor exigir a reprodução integral.

**Arquivo original:** entregue como anexo nesta conversa (não enviado em binário ao GitHub). O presente documento preserva identificação por SHA-256 e resumo rastreável sem adulterar as evidências.
