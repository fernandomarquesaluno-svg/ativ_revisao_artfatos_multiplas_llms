# Apresentação final — Atividade 7 (9 slides)

**Tema:** Avaliação multimodelo de artefatos científicos: Selection Agent (K-Agent), SBRC 2026.  
**Autor:** Fernando Henrique de Souza Marques — UNIPAMPA.  
**Atualização:** 06/11/2026 — conversa original GPT-6 e padronização conferidas.  
**Duração sugerida:** até 5 minutos.  
**Formatos locais preparados:** PowerPoint editável e PDF. Esta versão em Markdown preserva o conteúdo corrigido no repositório; os arquivos binários PPTX/PDF foram entregues na conversa de preparação e não são anexados automaticamente pelo conector GitHub.

## Slide 1 — Capa

Avaliação multimodelo de artefatos científicos. Estudo de caso: Selection Agent (K-Agent), SBRC 2026. GPT-6 (OpenAI), Claude (Anthropic), Gemini (Google). Selos F e R.

## Slide 2 — Protocolo

Artefato e critérios oficiais → **mesmo Prompt 1 nas três LLMs** (avaliação documental) → testes históricos relatados → **mesmo Prompt 2 nas três LLMs** (reavaliação a partir de logs resumidos) → comparação com selos oficiais.

- F: observar funcionalidades e saídas durante execução.
- R: reproduzir as principais reivindicações do artigo.
- **Limite:** os dados recebidos pelas LLMs são trechos de execução *relatados*, não logs integrais autenticados nem execuções independentes por modelo.

## Slide 3 — GPT-6

| Fase | F | R |
|---|---|---|
| Documental | **Atribuído com ressalvas** | **Parcial** |
| Após os logs | **Parcial** | **Parcial mantido** |

A conversa **original do GPT-6** foi fornecida pelo aluno; ela emprega os mesmos dois prompts históricos das demais LLMs. A avaliação GPT-6 adicional de 05/11 não integra a amostra comparativa.

Fonte: [transcrição original GPT-6](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md).

## Slide 4 — Claude

| Fase | F | R |
|---|---|---|
| Documental | Parcial | Parcial |
| Após os logs | Parcial, mantido | Parcial, com risco de não atribuição |

Claude identificou problemas documentais: caminho do script de inicialização de Ollama, dois parâmetros `num-supernodes`, notebook com caminho absoluto. Essas observações foram checadas no commit de inspeção. O motivo efetivo da falha de Ollama, porém, permanece não comprovado. A variante exata do Claude não aparece na transcrição. **“Parcial” não é selo oficial.**

Fonte: [transcrição Claude](evidencias/CLAUDE_TRANSCRICAO_2026-11-05.md).

## Slide 5 — Gemini

| Fase | F | R |
|---|---|---|
| Documental | Atribuído | Atribuído |
| Após os logs | Mantido | Mantido com ressalva |

O Gemini **não retirou R** na transcrição original; considerou a falha do Ollama um bloqueio operacional potencialmente corrigível. Isso **não comprova reprodução** das 50 rodadas. Variante exata do Gemini não identificada na impressão.

Fonte: [registro da conversa Gemini](evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md).

## Slide 6 — Evidências de execução disponíveis

- **Random, 1 rodada:** mensagem de sucesso relatada `[SUCCESS] Simulation finished`. O arquivo de pesos citado não foi recuperado.
- **K-Agent, 50 rodadas previstas:** `ConnectionRefusedError` ao acessar a API Ollama em `localhost:11434`. A execução foi interrompida no relato.
- **Ausente:** acesso à máquina Ubuntu, logs completos, configurações efetivas e resultados quantitativos que sustentem redução de tráfego de 44,4%–59%.

Fonte: [registro de execuções relatadas](evidencias/REGISTRO_EXECUCOES_RELATADAS.md).

## Slide 7 — Tabela comparativa

| Modelo | F documental | R documental | F após logs | R após logs |
|---|---|---|---|---|
| GPT-6 | Atribuído | Parcial | Parcial | Parcial mantido |
| Claude | Parcial | Parcial | Parcial | Parcial, com risco |
| Gemini | Atribuído | Atribuído | Atribuído | Atribuído com ressalva |

**Referência SBRC 2026:** F e R **oficialmente atribuídos** ao trabalho. As recomendações das LLMs não revogam esses selos.

Fonte: [matriz CSV](comparacao_llms.csv) e [resultado oficial](https://doc-artefatos.github.io/sbrc2026/results.html).

## Slide 8 — Discussão crítica

**Concordância factual:** nos registros relatados, o experimento central K-Agent não chegou à conclusão.

**Divergência de decisão:** com os mesmos dois prompts e a mesma falha resumida, as LLMs recomendaram diferentemente R (GPT-6: parcial; Claude: parcial com risco; Gemini: atribuído com ressalva). Isso mostra diferença de critérios de evidência e limitações da avaliação automatizada.

**Limite:** a falha operacional não demonstra defeito do algoritmo e a ausência de execução completa não invalida os selos oficiais.

## Slide 9 — Conclusão

1. Foram documentadas três avaliações documentais e três reavaliações usando **os mesmos dois prompts**, com trechos de logs relatados.
2. Não há evidência experimental original suficiente para comprovar a reprodução das reivindicações quantitativas do K-Agent nesta tentativa.
3. Os selos F e R do SBRC 2026 permanecem oficialmente atribuídos, independentemente desta análise de evidência limitada.

## Rastreabilidade e ressalvas

- [Relatório revisado](RELATORIO_TAREFA_7_REVISADO.md).
- [Fluxo e limitações do protocolo](FLUXOGRAMA.md).
- [Prompts padronizados propostos para futuras replicações](PROMPTS_UTILIZADOS.md).

**Aviso de comparabilidade:** os prompts históricos foram **iguais** entre os três modelos. Não foi demonstrada identidade de snapshot do repositório, acesso aos mesmos documentos e condições de execução entre provedores. Comparar como **estudo de caso com prompts padronizados e limitações de evidência experimental**, sem atribuir rigor de reprodução não comprovado.
