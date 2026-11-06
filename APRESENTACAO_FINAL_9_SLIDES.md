# Apresentação final — Atividade 7 (9 slides)

**Tema:** Avaliação multimodelo de artefatos científicos: Selection Agent (K-Agent), SBRC 2026.  
**Autor:** Fernando Henrique de Souza Marques — UNIPAMPA.  
**Atualização:** 06/11/2026 — auditoria dos logs reais do Codespaces e seleção de K-Agent a partir da segunda rodada.  
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

## Slide 6 — Execuções novas e evidência verificável

- **Random, Codespaces, 1 rodada:** `exit_code=0`, cinco clientes, arquivo do modelo salvo e log integral.
- **Configuração `k-agent`, Codespaces, 1 rodada:** `exit_code=0` e modelo salvo; porém a função de seleção de clientes só é chamada a partir da **segunda rodada**. Logo, **a consulta à LLM e a seleção pelo agente não foram demonstradas**.
- **Ollama:** `qwen3:0.6b` instalado, API de estado acessível. Sem chamadas de inferência nos logs disponíveis.
- **Histórico analisado pelas três LLMs:** tentativa anterior de 50 rodadas interrompida por `ConnectionRefusedError`; os logs antigos completos continuam indisponíveis.

Fonte: [Auditoria dos três pacotes Codespaces](evidencias/AUDITORIA_CODESPACES_2026-11-06.md).

## Slide 7 — Tabela comparativa

| Modelo | F documental | R documental | F após logs | R após logs |
|---|---|---|---|---|
| GPT-6 | Atribuído | Parcial | Parcial | Parcial mantido |
| Claude | Parcial | Parcial | Parcial | Parcial, com risco |
| Gemini | Atribuído | Atribuído | Atribuído | Atribuído com ressalva |

**Referência SBRC 2026:** F e R **oficialmente atribuídos** ao trabalho. As recomendações das LLMs não revogam esses selos.

Fonte: [matriz CSV](comparacao_llms.csv) e [resultado oficial](https://doc-artefatos.github.io/sbrc2026/results.html).

## Slide 8 — Discussão crítica

**Concordância factual:** nos registros antigos relatados, o experimento central K-Agent não chegou à conclusão. Os novos logs comprovam execução básica, mas **não exercitam a seleção pelo agente** na rodada 1.

**Divergência de decisão:** com os mesmos dois prompts e a mesma falha resumida, as LLMs recomendaram diferentemente R (GPT-6: parcial; Claude: parcial com risco; Gemini: atribuído com ressalva). Isso mostra diferença de critérios de evidência e limitações da avaliação automatizada.

**Limite:** a falha antiga não demonstra defeito do algoritmo. Os novos logs não comprovam inferência LLM nem a reprodução de 50 rodadas, e não invalidam os selos oficiais.

## Slide 9 — Conclusão

1. Foram documentadas três avaliações documentais e três reavaliações usando **os mesmos dois prompts**, com trechos de logs relatados.
2. Agora há logs reais de Random e uma rodada nominal de K-Agent. Contudo, o agente só é acionado na rodada 2: falta demonstrar a integração com a LLM e reproduzir as reivindicações quantitativas.
3. Os selos F e R do SBRC 2026 permanecem oficialmente atribuídos, independentemente desta análise de evidência limitada.

## Rastreabilidade e ressalvas

- [Relatório revisado](RELATORIO_TAREFA_7_REVISADO.md).
- [Fluxo e limitações do protocolo](FLUXOGRAMA.md).
- [Prompts padronizados propostos para futuras replicações](PROMPTS_UTILIZADOS.md).

**Observação temporal:** os logs novos de 06/11/2026 foram coletados após as conversas originais dos três modelos e não alteram seus pareceres. Próximo teste: [K-Agent em duas rodadas](scripts/codespaces/run_kagent_2rounds.sh).

**Aviso de comparabilidade:** os prompts históricos foram **iguais** entre os três modelos. Não foi demonstrada identidade de snapshot do repositório, acesso aos mesmos documentos e condições de execução entre provedores. Comparar como **estudo de caso com prompts padronizados e limitações de evidência experimental**, sem atribuir rigor de reprodução não comprovado.
