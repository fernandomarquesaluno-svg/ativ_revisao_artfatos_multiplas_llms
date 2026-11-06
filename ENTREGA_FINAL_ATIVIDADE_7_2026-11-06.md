# Atividade 7 — Encerramento e instruções de entrega (06/11/2026)

**Situação:** relatório, comparação multimodelo, evidências de execução e apresentação **prontos para entrega acadêmica com ressalva experimental**.

## 1. Checklist de conformidade

| Exigência / elemento | Evidência | Estado |
|---|---|---|
| Artefato científico SBRC 2026 | [Selection Agent/K-Agent dos autores](https://github.com/rafaeloj/sbrc2026) | Atendido |
| Três LLMs, três provedores | OpenAI/GPT-6; Anthropic/Claude; Google/Gemini | Atendido |
| Avaliação documental (F e R) por modelo | [GPT-6](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md), [Claude](evidencias/CLAUDE_TRANSCRICAO_2026-11-05.md), [Gemini](evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md) | Atendido |
| Reavaliação por logs para as três LLMs | Segundo prompt histórico e respostas nas mesmas transcrições | Atendido (análise de logs relatados, não três execuções independentes) |
| Comparação dos pareceres com selos oficiais | [Matriz](comparacao_llms.csv) e [resultados SBRC 2026](https://doc-artefatos.github.io/sbrc2026/results.html) | Atendido |
| Teste funcional Random | [Auditoria de três pacotes](evidencias/AUDITORIA_CODESPACES_2026-11-06.md) | Concluído |
| Teste funcional K-Agent/Ollama | [Auditoria de duas rodadas](evidencias/AUDITORIA_KAGENT_2_RODADAS_2026-11-06.md) | **Concluído**, seleção por LLM comprovada |
| Reprodução das reivindicações de 50 rodadas e tráfego | [Script opcional preparado](scripts/codespaces/run_kagent_50rounds.sh) | **Não demonstrada**, não alegar conclusão |
| Apresentação oral e PDF | Arquivos finais entregues na conversa (binários não depositados por este conector) | Preparados |
| Envio ao professor/à plataforma da disciplina | Sem confirmação externa | **Ação final do aluno** |

## 2. Pareceres históricos, sem reescrever os modelos

| Modelo | F documental | R documental | F após logs históricos | R após logs históricos |
|---|---|---|---|---|
| GPT-6 (OpenAI) | Atribuído com ressalvas | Parcial | Parcial | Parcial, mantido |
| Claude (Anthropic, variante não comprovada) | Parcial | Parcial | Parcial, mantido | Parcial, com risco de não atribuição |
| Gemini (Google, variante não comprovada) | Atribuído | Atribuído | Atribuído, mantido | Atribuído, com ressalva |

Os **dois prompts históricos foram iguais** entre os três provedores, conforme transcrições. Não afirmar igualdade de snapshot do repositório ou de materiais efetivamente acessíveis a cada modelo. Os prompts aperfeiçoados de [PROMPTS_UTILIZADOS.md](PROMPTS_UTILIZADOS.md) são **proposta posterior**, não os prompts literais do experimento histórico. “Parcial” é opinião analítica, não um selo oficial.

## 3. Resultados experimentais efetivos

Três pacotes recebidos do Codespaces validam o método Random, a preparação do Ollama e o funcionamento nominal do Flower. Uma rodada configurada como `k-agent` ainda **não aciona a seleção do agente**, pois o código só a executa depois da rodada inicial.

O quarto pacote, `evidencias_kagent_2rodadas_20261106T111254Z.tar.gz`, confirma, na **segunda rodada**:

- Duas chamadas `POST /api/chat` ao Ollama, respostas HTTP 200.
- Inferência do modelo `qwen3:0.6b`.
- Chamada `oort_selection(k=1)`, com sucesso; um cliente selecionado.
- Cinco resultados de treino na rodada 1 e um na rodada 2, sem falhas.
- Treinamento encerrado, modelo salvo e `exit_code=0`.
- SHA-256 do pacote original: `d5667dd68c7c596f25d12e7810a3f43c336ab97dce0274857c62a4eeceee5e41`.

**Conclusão para F:** funcionalidade central demonstrada neste cenário reduzido. **Conclusão para R:** redução de tráfego de 44,4%–59% **não foi reproduzida**; seria necessário executar os experimentos de maior escala, baselines e apurar métricas. Isso não demonstra irreprodutibilidade definitiva.

## 4. Referências e limites

- [Resultados oficiais SBRC 2026](https://doc-artefatos.github.io/sbrc2026/results.html): o trabalho **Agente K-alibra** possui **F e R atribuídos**; esta análise não retira os selos.
- [Repositório original dos autores](https://github.com/rafaeloj/sbrc2026).
- Commit controlado nos testes: `949f83c6db86d682240b7a61d1d2d406609413b6`. Não atribuir esse commit retroativamente a todos os modelos.
- As reavaliações das LLMs consideraram **logs históricos informados** (teste Random e falha de conexão antiga com Ollama), **não os novos resultados** do Codespaces.
- Os registros históricos completos da máquina Ubuntu anterior não foram recuperados; os novos arquivos `.tar.gz` são evidências de testes posteriores.
- O pacote de entrega final contendo PDF/PPTX/CSV e os quatro arquivos originais de evidências está disponível como anexo nesta conversa; os binários não foram enviados a este repositório.

**Veredito final:** **Atividade 7 encerrada para fins de entrega e apresentação, com ressalva metodológica explícita quanto ao selo R.** A submissão oficial deve ser confirmada pelo aluno.
