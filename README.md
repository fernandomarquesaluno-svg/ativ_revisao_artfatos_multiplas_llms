# Atividade 7 — Avaliação de artefatos com três LLMs

Fernando Henrique de Souza Marques · Revisão de 05/11/2026

**Estado: avaliação Gemini documentada; avaliações originais das demais LLMs e experimento completo ainda pendentes.** Não apresentar a comparação como totalmente concluída.

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

Em 05/11/2026 o aluno apresentou uma impressão em PDF da conversa original com Gemini, contendo os dois prompts e as duas respostas. **O Gemini manteve F e R, sendo R com ressalva, após receber trechos de logs resumidos.** Isso contradiz documentos secundários anteriores que afirmavam retirada de R. As avaliações originais de GPT e Claude ainda não foram apresentadas integralmente. Nenhuma resposta foi simulada nesta revisão.

## Matriz de comparação atual

| Avaliador / provedor | Analítica F / R | Execução F / R | Oficial F / R | Evidência |
|---|---|---|---|---|
| **GPT-6 — OpenAI, nova avaliação de 05/11/2026** | F: candidato documental; R: evidência insuficiente sem execução | F: inconclusivo para K-Agent; R: não recomendado na tentativa relatada | Sim / Sim | [Avaliação nova com ressalvas](AVALIACAO_GPT6_2026-11-05.md); análise de trechos históricos, não execução própria |
| Claude — Anthropic, versão a confirmar | Pendente de resposta original | Pendente de execução ou uso documentado | Sim / Sim | Conversas e logs não localizados |
| Gemini — Google, modelo exato não indicado no PDF | F: atribuído; R: atribuído (parecer documental) | F: mantido; R: mantido com ressalva; análise dos trechos de logs fornecidos, sem execução própria | Sim / Sim | `evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md` (transcrição PDF da conversa) |

A avaliação OpenAI anterior, atribuída a GPT-4o em materiais históricos, foi substituída **na comparação corrente** por uma nova avaliação identificada como GPT-6; não se atribuem respostas antigas ao modelo novo. A tabela expressa o estado da evidência; não representa seis avaliações práticas concluídas. Não se calcula taxa de concordância com células pendentes.

## Parecer atual da OpenAI

Na inspeção documental, F é plausível porque há um teste mínimo especificado. R tem roteiro, mas depende de configurar e executar as reivindicações. Os trechos históricos, se confirmados, sustentariam a execução de uma funcionalidade básica e a interrupção do experimento principal. Sua autenticidade e completude ainda não foram verificadas.

A pré-checagem de 05/11/2026 encontrou ausência de Flower, PyTorch e executável Ollama no ambiente de revisão. A tentativa de iniciar `flwr` falhou por executável ausente, antes de carregar o artefato. Nenhum treinamento nem reprodução científica foi realizado aqui. O ambiente não corresponde ao ambiente informado nos materiais históricos.

**Conclusão:** não há base para afirmar consistência ou divergência entre três LLMs. A falha relatada não invalida os selos oficiais e não demonstra erro do algoritmo. A tarefa permanece incompleta até reunir as duas etapas por provedor e verificar suas evidências.

## O que falta para concluir

1. Fixar o mesmo commit, artigo, instruções e configurações para as três LLMs. Guardar hash das regras e identificar a versão oficial, quando disponível.
2. Executar o Prompt 1 em três provedores e salvar respostas integrais, modelo exato, data, configurações e limitações de acesso.
3. Preparar ambiente compatível; salvar `pip freeze`, configuração efetiva e estado de Ollama/modelo. Usar o procedimento do README para editar o TOML e executar `flwr run . local-simulation`.
4. Realizar ou conduzir execução/uso com cada LLM, preservando comandos, stdout, stderr, código de saída, tempo e arquivos gerados. Se a interface não executa, registrar quem operou os comandos sob orientação da LLM. Apenas apresentar os mesmos logs às três LLMs é análise de logs, não três execuções independentes.
5. Executar o Prompt 2 com evidências reais; verificar citações e arquivos diretamente.
6. Comparar F/R analítico, F/R após execução e F/R oficial por LLM; explicar mudanças e limitações.
7. Validar se o protocolo de execução compartilhada, caso escolhido, atende ao entendimento do professor. O caminho mais direto ao enunciado é uma sessão prática documentada por provedor.

Os [prompts](PROMPTS_UTILIZADOS.md), o [fluxograma](FLUXOGRAMA.md), o [protocolo](PROTOCOLO_EXECUCAO.md) e a [planilha CSV](comparacao_llms.csv) estão preparados. Pendências não equivalem a resultados negativos.


## Correção fundamentada — resposta original do Gemini (05/11/2026)

A impressão PDF da conversa mostra dois prompts e duas respostas da LLM. **F: atribuído → atribuído. R: atribuído → atribuído com ressalva de execução.** O Gemini considerou que o problema Ollama/porta 11434 poderia ser solucionado ativando `ollama serve` e obtendo `qwen3:0.6b`; a documentação indicava essa etapa. O modelo manteve a recomendação de R, **embora o experimento de 50 rodadas não tenha sido reproduzido nessa tentativa**. Isso é o julgamento do Gemini, não um resultado experimental demonstrado. Consulte [registro da resposta](evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md). Até nova evidência, a identidade exata da variante do Gemini não é comprovada pelo texto impresso; o PDF exibe a interface Gemini, mas não seu seletor de modelo.


## Nova avaliação OpenAI com GPT-6 — 05/11/2026

[Registro completo, com análise documental, reavaliação de logs históricos e limites](AVALIACAO_GPT6_2026-11-05.md). Esta avaliação **substitui o GPT-4o apenas na comparação atual**. Parecer documental: F candidato condicionado à prova prática; R documentalmente insuficiente sem reprodução. Após os registros históricos relatados: F inconclusivo para o núcleo K-Agent, apesar do teste random; R não recomendado **nessa tentativa** porque o experimento foi abortado. Nenhuma execução independente do K-Agent ocorreu nesta avaliação GPT-6. Os materiais antigos com GPT-4o permanecem como histórico.
