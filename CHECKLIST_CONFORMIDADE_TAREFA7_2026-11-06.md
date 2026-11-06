# Auditoria final dos 14 itens — Tarefa 7 (06/11/2026)

**Escopo:** exigências da disciplina; não substituir critérios do professor pelos testes científicos completos do artigo.

| Item | Evidência verificável | Situação |
|---|---|---|
| 1. Artefato SBSeg/SBRC | [Repositório Selection Agent](https://github.com/rafaeloj/sbrc2026) | Atendido |
| 2. Selos oficiais | [SBRC 2026](https://doc-artefatos.github.io/sbrc2026/results.html): F e R atribuídos | Atendido |
| 3. Instruções da edição | [Cópia preservada](evidencias/INSTRUCOES_SBRC2026.txt); prompts citam URL oficial | Atendido como referência; leitura integral por cada LLM não verificável |
| 4. Três provedores | GPT-6 / OpenAI, Claude / Anthropic e Gemini / Google | Atendido |
| 5. Duas avaliações por LLM | Dois prompts e duas respostas em cada transcrição | Atendido como parecer documental + análise de logs relatados, sem execução autônoma de cada LLM |
| 6. Prompts iguais/equivalentes | [Transcrições GPT-6](evidencias/GPT6_TRANSCRICAO_ORIGINAL_2026-11-06.md), [Claude](evidencias/CLAUDE_TRANSCRICAO_2026-11-05.md) e [Gemini](evidencias/GEMINI_AVALIACAO_ORIGINAL_2026-11-05.md) | Equivalência de texto confirmada; acesso idêntico às fontes não comprovado |
| 7. Prompts e resultados | Transcrições + [comparacao_llms.csv](comparacao_llms.csv) | Atendido |
| 8. Evidências apresentadas pelas LLMs | Justificativas em cada transcrição | Atendido |
| 9. Verificação direta | [Auditoria de código](README.md), [teste K-Agent](evidencias/AUDITORIA_KAGENT_2_RODADAS_2026-11-06.md) | Parcial: evidências-chave checadas; nem toda afirmação foi inspecionada |
| 10. Tabela comparativa | [comparacao_llms.csv](comparacao_llms.csv) e relatórios | Atendido |
| 11. Concordâncias/divergências | [Entrega final](ENTREGA_FINAL_ATIVIDADE_7_2026-11-06.md) | Atendido |
| 12. Confronto analítica/execução | Random + K-Agent com inferência Qwen3 real na rodada 2 | Atendido no cenário reduzido, com limite para R |
| 13. Fluxograma | [FLUXOGRAMA.md](FLUXOGRAMA.md) | Atendido |
| 14. Conclusão da consistência | [Entrega final](ENTREGA_FINAL_ATIVIDADE_7_2026-11-06.md) | Atendido com ressalvas |

## Resultado acadêmico

A Tarefa 7 tem o núcleo **multimodelo, documental, comparativo e funcional** demonstrado. A execução de 50 rodadas **não é requisito literal do enunciado**, mas consta da reivindicação do artigo para um teste rigoroso do **selo R**. Portanto, não afirmar que as principais reivindicações quantitativas foram reproduzidas.

## Encerramento factual

- **F:** seleção K-Agent/Qwen3/Oort observada em duas rodadas, com evidência primária no Codespaces.
- **R:** resultado científico completo não demonstrado nesta avaliação; não equiparar isso a reprovação definitiva.
- **Evento:** selos oficiais F e R permanecem atribuídos.
- **Comparabilidade:** três LLMs usaram enunciados equivalentes, mas versões exatas de Claude/Gemini, snapshots e fontes acessadas não estão inteiramente comprovados.
- **Execução das LLMs:** os modelos analisaram trechos de logs; o aluno executou o artefato posteriormente.
- **Envio:** cabe ao aluno anexar o relatório e slides no ambiente da disciplina. Não há confirmação de submissão.
