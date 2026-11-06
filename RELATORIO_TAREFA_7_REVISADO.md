# Atividade 7 — Avaliação de artefatos com três LLMs

Fernando Henrique de Souza Marques · Revisão de 05/11/2026 — consolidada após transcrição Claude

**Estado: três avaliações documentadas (transcrição original GPT-6, transcrição Claude e transcrição Gemini), porém execução experimental completa e logs integrais ainda pendentes.** A fase prática consiste em análise dos logs resumidos informados; não equivale a três execuções independentes.

## Artefato, regras e referência oficial

- Artefato: [Selection Agent / K-Agent](https://github.com/rafaeloj/sbrc2026).
- Trabalho no resultado oficial: **Agente K-alibra: Estratégia para Seleção de K-Clientes em Aprendizado Federado autônoma**.
- Edição: SBRC 2026. [Instruções de revisão](https://doc-artefatos.github.io/sbrc2026/revinstrucoes.html).
- [Resultados oficiais](https://doc-artefatos.github.io/sbrc2026/results.html): D, F, S e R presentes na mesma linha que aponta para rafaeloj/sbrc2026. Verificado no HTML oficial em 05/11/2026.
- Versão inspecionada nesta revisão: `949f83c6db86d682240b7a61d1d2d406609413b6`. Isso não identifica automaticamente a versão avaliada pelo CTA ou usada nos registros históricos.

## Correção dos critérios

**F — Funcional:** as regras exigem executar e observar algumas funcionalidades, com prova de execução. O teste mínimo documentado pelos autores usa seleção aleatória. A falha posterior do K-Agent não nega automaticamente F se esse teste mínimo tiver sido efetivamente executado e comprovado.

**R — Experimentos Reprodutíveis:** exige executar os experimentos e alcançar as principais reivindicações do artigo, com resultados verificáveis. Ler instruções ou recalcular gráficos a partir de dados prontos não comprova a execução integral.

“Parcial” não é selo oficial. Nesta revisão usamos “evidência insuficiente” para descrever nossa limitação, sem modificar os selos do evento. A etapa analítica pode formular uma recomendação, mas deve explicitar que a prova prática ainda não ocorreu.

## Evidências verificadas diretamente

| ID | Evidência no commit inspecionado | Implicação |
|---|---|---|
| E1 | README: instalação, dependências, teste mínimo random e experimentos | Há orientação documental para avaliar F e R |
| E2 | `selection-agent/pyproject.toml`: app com 5 clientes, sample-size=15, random_selection | Padrões diferem da configuração da reivindicação principal |
| E3 | README: principal experimento com 25 clientes, sample-size=-1, oort_selection, 50 rodadas | É preciso preservar configuração efetiva e saídas |
| E4 | TOML: federação tem outro num-supernodes=5; recursos declaram 30 CPUs e 1 GPU | Ajustar ambos os locais; CPU-only requer configuração explícita |
| E5 | `server_app.py`: nome do modelo contém horário/dia/mês, método, clientes e amostra | O nome abreviado citado no relatório anterior não comprova origem nesta versão |
| E6 | `agent/k_agent.py`: tentativas e captura de exceções | O trecho narrativo de erro não basta para reconstruir toda a falha |
| E7 | Diretório `notebooks/sbrc2026` presente | Existência de notebooks é evidência estrutural; não é reprodução realizada |

Fontes: [README](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/README.md), [TOML](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/pyproject.toml), [servidor](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/selection_agent/server_app.py) e [agente](https://github.com/rafaeloj/sbrc2026/blob/949f83c6db86d682240b7a61d1d2d406609413b6/selection-agent/selection_agent/agent/k_agent.py).

O README estima cerca de três horas para 50 rodadas da primeira reivindicação e duas horas para a segunda. São estimativas dos autores, não medições desta revisão. Ausência de ambiente adequado limita a avaliação, não constitui defeito demonstrado no artefato.

## Proveniência dos registros anteriores

Os materiais anteriores contêm um relato de êxito do random e uma falha de conexão com Ollama. Parte da documentação os chamou de “logs fornecidos no enunciado”, mas o enunciado apresentado nesta revisão não fornece esses logs. A origem, o commit e os arquivos completos precisam ser confirmados. Mantemos os trechos como **registros históricos relatados**, sem classificá-los como novas execuções.

Em 05/11/2026 o aluno apresentou uma impressão em PDF da conversa original com Gemini, contendo os dois prompts e as duas respostas. **O Gemini manteve F e R, sendo R com ressalva, após receber trechos de logs resumidos.** Isso contradiz documentos secundários anteriores que afirmavam retirada de R. A transcrição original do Claude também foi apresentada em 05/11/2026; a nova avaliação GPT-6 está documentada separadamente. Nenhuma resposta foi simulada nesta revisão.

## Matriz de comparação atual

| Avaliador / provedor | Analítica F / R | Execução F / R | Oficial F / R | Evidência |
|---|---|---|---|---|
| **GPT-6 — OpenAI, conversa original fornecida em 06/11/2026** | F: atribuído com ressalvas; R: parcial | F: parcial; R: parcial mantido | Sim / Sim | [Transcrição integral](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md); reavaliação de logs resumidos, sem execução própria |
| Claude — Anthropic, variante não indicada no texto | F: parcial; R: parcial | F: parcial mantido; R: parcial mantido com risco de não atribuição | Sim / Sim | [Transcrição integral recebida](evidencias/CLAUDE_TRANSCRICAO_2026-11-05.md); avaliação dos logs relatados, sem execução própria |
| Gemini — Google, modelo exato não indicado no PDF | F: atribuído; R: atribuído (parecer documental) | F: mantido; R: mantido com ressalva; análise dos trechos de logs fornecidos, sem execução própria | Sim / Sim | `evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md` (transcrição PDF da conversa) |

A avaliação histórica atribuída a GPT-4o foi substituída na comparação corrente pela **conversa original fornecida pelo aluno para GPT-6**. A análise GPT-6 adicional elaborada anteriormente nesta revisão está preservada como documento histórico separado e **não deve ser usada na tabela principal**. A tabela registra **três avaliações documentais e três reavaliações de logs fornecidos**; não representa três execuções práticas independentes. As interpretações diferem, especialmente quanto a R.

## Parecer efetivamente registrado na conversa GPT-6

**Documental:** F atribuído com ressalvas; R parcial. **Após receber os fragmentos de logs:** F parcial; R parcial mantido. A justificativa é que Random concluiu uma rodada conforme relato, enquanto o K-Agent não concluiu o experimento porque a conexão com Ollama foi recusada. [Transcrição textual integral](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md).

A pré-checagem técnica de 05/11/2026, realizada em outro ambiente de revisão, não tinha Flower/Ollama instalados e não constitui execução da sessão histórica.

**Conclusão atualizada:** há divergência verificável entre os pareceres textuais: GPT-6 mantém R como **Parcial**; Claude mantém R como **Parcial** com risco de não atribuição; Gemini mantém **Atribuído** com ressalva. Nenhuma dessas avaliações demonstra a reprodução da reivindicação principal. A falha relatada não invalida os selos oficiais e não demonstra erro do algoritmo. A avaliação permanece limitada pela ausência de logs integrais e execuções independentes.

## Estado da entrega e pendências

**Concluído como estudo de caso documental:** foram reunidos os pareceres originais Claude e Gemini, a nova avaliação GPT-6, a tabela comparativa, o relato de duas tentativas históricas de execução, o fluxograma, a apresentação corrigida de nove slides e o registro de limitações.

**Permanece pendente para demonstrar um experimento de execução plenamente auditável:** recuperar/reexecutar no Ubuntu um ambiente com configurações, logs completos, outputs, métricas e resultados das reivindicações; confirmar variantes dos modelos Claude/Gemini; realizar, se exigido, uma repetição controlada com prompts e snapshots idênticos. Sem isso, não afirmar conclusão de três execuções práticas ou reprodução do K-Agent.

**Padronização dos prompts históricos:** o Prompt 1 e o Prompt 2 são **literalmente idênticos** nas transcrições fornecidas de Claude e GPT-6; a impressão PDF do Gemini contém os mesmos enunciados com mudanças de diagramação. A identidade dos prompts não comprova, por si só, que os três modelos consultaram o mesmo snapshot do repositório ou acessaram exatamente os mesmos materiais. Os prompts de [replicação prospectiva](PROMPTS_UTILIZADOS.md) são versões mais exigentes e distintas dos prompts históricos.

Os [prompts](PROMPTS_UTILIZADOS.md), o [fluxograma](FLUXOGRAMA.md), o [protocolo](PROTOCOLO_EXECUCAO.md) e a [planilha CSV](comparacao_llms.csv) estão preparados. Pendências não equivalem a resultados negativos.


## Correção fundamentada — resposta original do Gemini (05/11/2026)

A impressão PDF da conversa mostra dois prompts e duas respostas da LLM. **F: atribuído → atribuído. R: atribuído → atribuído com ressalva de execução.** O Gemini considerou que o problema Ollama/porta 11434 poderia ser solucionado ativando `ollama serve` e obtendo `qwen3:0.6b`; a documentação indicava essa etapa. O modelo manteve a recomendação de R, **embora o experimento de 50 rodadas não tenha sido reproduzido nessa tentativa**. Isso é o julgamento do Gemini, não um resultado experimental demonstrado. Consulte [registro da resposta](evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md). Até nova evidência, a identidade exata da variante do Gemini não é comprovada pelo texto impresso; o PDF exibe a interface Gemini, mas não seu seletor de modelo.


## Avaliação GPT-6 da conversa original — 06/11/2026

A [transcrição integral](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md) contém os dois prompts históricos e as duas respostas. **F: Atribuído → Parcial. R: Parcial → Parcial, mantido**. O arquivo [AVALIACAO_GPT6_2026-11-05.md](AVALIACAO_GPT6_2026-11-05.md) permanece como **uma avaliação adicional posterior, fora da amostra comparativa**; seu parecer não deve substituir a resposta da conversa original.

## Avaliação original Claude — 05/11/2026

O aluno forneceu a [transcrição completa dos dois prompts e duas respostas](evidencias/CLAUDE_TRANSCRICAO_2026-11-05.md). **Documento: F=Parcial e R=Parcial; após os logs resumidos: F=Parcial mantido e R=Parcial mantido, com risco de rebaixamento.** Portanto, é falso que Claude tenha “negado R definitivamente” nos registros originais apresentados. “Parcial” é terminologia do parecer, não selo oficial. A versão exata do modelo Claude não aparece na transcrição. A inspeção do commit referenciado confirma três observações do Claude: caminho do script Ollama diferente do indicado no README, duas entradas `num-supernodes` no TOML e notebook com caminho absoluto para pasta do autor. As hipóteses causais do Claude sobre a conexão Ollama não constituem comprovação da causa efetiva do erro.


## Situação da execução sem acesso ao Ubuntu — 05/11/2026

O aluno confirmou não ter mais acesso à máquina Ubuntu em que relatou as duas tentativas. Assim, não foi possível recuperar os logs integrais, o histórico dos comandos, os parâmetros efetivos ou o modelo salvo. **Não há uma nova execução nesta revisão.** Os resultados Random (sucesso mínimo relatado) e K-Agent (interrupção relatada por falha de conexão Ollama) foram reunidos como **evidência histórica secundária** no [registro de execuções relatadas](evidencias/REGISTRO_EXECUCOES_RELATADAS.md). Esse registro é insuficiente para demonstrar a reprodução da reivindicação experimental principal. Os slides e o relatório devem explicitar a limitação sem afirmar falha permanente do artefato ou invalidade dos selos oficiais.


## Apresentação final revisada

[Conteúdo auditável dos nove slides, com referências](APRESENTACAO_FINAL_9_SLIDES.md). A apresentação editável PowerPoint e a versão PDF foram geradas e revisadas visualmente na conversa de 05/11/2026. Por limitação do conector de GitHub para arquivos binários neste fluxo, o repositório contém **o conteúdo textual completo** da apresentação, não os arquivos PPTX/PDF.


## Conferência final dos prompts históricos — 06/11/2026

Confrontados os textos da transcrição GPT-6, da transcrição Claude e da impressão PDF Gemini: **os dois prompts utilizados apresentam o mesmo conteúdo**. O confronto byte a byte das mensagens exportadas de GPT-6 e Claude, removida apenas a indicação da interface, foi **idêntico nos dois prompts**. O PDF Gemini altera a diagramação, sem mudar o enunciado. Portanto, **não se deve mais alegar ausência de padronização dos prompts**. A comparabilidade continua limitada por variantes exatas dos modelos, possíveis snapshots/materiais acessados e falta de logs integrais. [Apresentação corrigida](APRESENTACAO_FINAL_9_SLIDES.md).
