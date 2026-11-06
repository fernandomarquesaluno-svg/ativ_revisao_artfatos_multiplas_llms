# Apresentação final auditada — Atividade 7 (9 slides)

**Data:** 06/11/2026 · **Duração:** 3–5 minutos · **Artefato:** Selection Agent / K-Agent (SBRC 2026).  
**Princípio central:** o enunciado da Tarefa 7 não exige explicitamente executar 50 rodadas. Essa contagem pertence às reivindicações do artigo, relevantes para demonstrar R cientificamente. A seleção por LLM foi observada em duas rodadas.

## Slide 1 — Avaliação multimodelo do K-Agent
GPT-6 · Claude · Gemini. Comparação de pareceres F/R e evidência real de execução.

## Slide 2 — Duas etapas para cada LLM
**Analítica:** repositório + diretrizes oficiais, pareceres F/R.  
**Após logs:** os modelos reavaliaram os **mesmos trechos históricos relatados** (Random OK; K-Agent com conexão Ollama recusada).  
**Nota:** o teste real posterior no Codespaces **não** integrou as avaliações históricas das LLMs.

## Slide 3 — F é diferente de R
**F:** observar funcionalidades e outputs. **R:** reproduzir principais reivindicações e resultados do artigo.  
**Evento:** F e R oficialmente concedidos, conforme [resultado SBRC 2026](https://doc-artefatos.github.io/sbrc2026/results.html). Não são alterados pelos pareceres deste estudo.

## Slide 4 — GPT-6
Documental: F atribuído com ressalvas; R parcial. Após logs: F parcial; R parcial mantido. [Transcrição original](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md).

## Slide 5 — Claude
Documental: F parcial; R parcial. Após logs: F parcial; R parcial com risco de não atribuição. Destacou problemas técnicos e documentais. [Transcrição original](evidencias/CLAUDE_TRANSCRICAO_2026-11-05.md).

## Slide 6 — Gemini
Documental: F atribuído; R atribuído. Após logs: F mantido; R mantido **com ressalva**, sem reprodução quantitativa comprovada. [Conversa original](evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md).

## Slide 7 — Execução real, posterior
- **Random:** 1 rodada, `exit_code=0`.
- **K-Agent:** 2 rodadas, 5 clientes, `exit_code=0`.
- **Ollama + Qwen3:** 2 chamadas HTTP 200, `oort_selection(k=1)`, 1 cliente selecionado e treinado.
- **R:** nem 50 rodadas nem redução de tráfego da pesquisa foram reproduzidas nesta avaliação.
Fonte: [Auditoria do teste real](evidencias/AUDITORIA_KAGENT_2_RODADAS_2026-11-06.md).

## Slide 8 — Comparação histórica após os logs

| Modelo | F | R |
|---|---|---|
| GPT-6 | Parcial | Parcial |
| Claude | Parcial | Parcial, com risco |
| Gemini | Atribuído | Atribuído, com ressalva |

“Parcial” é qualificação usada pelas LLMs, não selo oficial. Não inferir igualdade dos snapshots/fontes consultados.

## Slide 9 — Conclusão
As três LLMs divergiram especialmente sobre R. O K-Agent/Qwen3 realmente selecionou cliente e treinou num cenário reduzido: há evidência forte de **funcionalidade**. Não houve confirmação independente da **reprodução científica integral**. Selos oficiais F/R permanecem atribuídos.

## Fontes e rastreabilidade
- [Critérios oficiais preservados](evidencias/INSTRUCOES_SBRC2026.txt) — os prompts históricos citavam as diretrizes, mas não foi demonstrado acesso integral idêntico por todos os modelos.
- [Comparação CSV](comparacao_llms.csv) e [fluxograma auditado](FLUXOGRAMA.md).
- [Checklist das 14 exigências](CHECKLIST_CONFORMIDADE_TAREFA7_2026-11-06.md).

**Arquivos binários:** a versão PPTX editável, o PDF de slides, o novo relatório e a cola oral estão anexados à conversa. O repositório guarda esta versão textual consolidada; esses PDFs/PPTX não foram publicados aqui pelo conector.
