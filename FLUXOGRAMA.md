# Fluxo efetivamente documentado — Atividade 7

**Não confundir com um experimento de execução repetido em três ambientes.** O aluno compartilhou textos de duas avaliações em Claude e Gemini; uma avaliação nova com GPT-6 foi criada em 05/11/2026. A nova revisão GPT-6 não reproduz necessariamente o prompt literal aplicado nos modelos anteriores.

```mermaid
flowchart TD
 A["Selection Agent / SBRC 2026"] --> B["Consulta a documentação e critérios F/R"]
 B --> C["Três sessões: GPT-6, Claude e Gemini"]
 C --> D["Parecer documental por modelo"]
 D --> E["Trechos históricos relatados: Random e K-Agent"]
 E --> F["Reavaliação de F/R por modelo"]
 F --> G["Comparação entre recomendações e selos oficiais"]
 G --> H["Limitações: logs integrais indisponíveis / sem reprodução completa"]
```

**Limitações metodológicas essenciais:** não está demonstrado que todos receberam prompts idênticos ou o mesmo snapshot de documentação; as respostas de Claude e Gemini são históricas; GPT-6 é avaliação nova. A fase prática se limitou ao exame de trechos de execução informados pelo aluno, sem execução independente por modelo. Sem acesso à máquina Ubuntu, não há como autenticar logs originais nem refazer a comparação das métricas do artigo.

**Protocolo prospectivo mais rigoroso:** para repetir um estudo controlado, usar o mesmo [prompt padronizado proposto](PROMPTS_UTILIZADOS.md), mesmos materiais/versionamento, e sessões práticas distintas com stdout/stderr e ambiente preservados.
