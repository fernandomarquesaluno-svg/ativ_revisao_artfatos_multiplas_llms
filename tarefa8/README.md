# Tarefa 8 — Robustez e sensibilidade da avaliação de artefatos com LLMs

**Disciplina:** Avaliação de Artefatos de Software  
**Status:** protocolo preparado e auditoria documental independente concluída; parecer piloto disponível; **testes E01–E08 ainda não executados de modo controlado**  
**Data de preparação:** 30/10/2026

## 1. Objetivo

Investigar o impacto de duas variáveis independentes — **versão do modelo de linguagem** e **nível de esforço de raciocínio** — nos pareceres sobre os selos Funcional (F) e Experimentos Reprodutíveis (R) de um mesmo artefato. As instruções do evento, o repositório, os prompts e os logs são preservados para permitir comparação controlada com a Tarefa 7.

## 2. Material mantido da Tarefa 7

- Artefato: [Selection Agent / K-Agent](https://github.com/rafaeloj/sbrc2026).
- Edição: **SBRC 2026**.
- Instruções oficiais: [Portal do CTA do SBRC 2026](https://doc-artefatos.github.io/sbrc2026/), sem substituição por critérios de outro evento.
- Avaliação: primeiro exame documental; depois auditoria dos **mesmos logs fornecidos** na Tarefa 7.
- Critérios analisados: Selo F (Funcional) e Selo R (Experimentos Reprodutíveis).
- Prompts: literalmente reproduzidos em [`PROMPTS_T7.md`](PROMPTS_T7.md).
- Logs anteriores: disponíveis em [`LOGS_FORNECIDOS.md` da Tarefa 7](https://github.com/fernandomarquesaluno-svg/ativ_revisao_artfatos_multiplas_llms/blob/main/LOGS_FORNECIDOS.md).
- Relatório T7: [repositório próprio da Tarefa 7](https://github.com/fernandomarquesaluno-svg/ativ_revisao_artfatos_multiplas_llms).

**Controle adicional:** registrar o SHA do commit do artefato consultado em cada rodada e, idealmente, fornecer cópias idênticas da documentação aos avaliadores. A comparação só é estritamente controlada se as fontes também permanecerem equivalentes.

## 3. Linha de base real da Tarefa 7

| Avaliador | Versão registrada | Esforço registrado | Documental F | Documental R | Após logs F | Após logs R |
|---|---|---|---|---|---|---|
| GPT-6 | GPT-6 | **Não informado** | Atribuído preliminarmente | Parcial | Parcial | Não Atribuído |

Os resultados de GPT-4o, Claude 3.5 Sonnet e Gemini 1.5 Pro presentes na Tarefa 7 foram **valores de referência do enunciado**. Não há, no relatório publicado, registros independentes dos prompts/respostas/configurações dessas três LLMs. Portanto, **não os tratar como medições próprias** da Tarefa 7. Se existirem transcrições antigas, anexá-las e registrá-las antes da comparação.

O termo **Parcial** foi utilizado como categoria didática; **não é um selo formal do CTA**.

## 4. Desenho experimental com os três provedores (8 condições)

A Tarefa 7 incluiu resultados de referência para **GPT-4o (OpenAI), Claude 3.5 Sonnet (Anthropic) e Gemini 1.5 Pro (Google)**, além da avaliação registrada com GPT-6. Portanto, manter apenas modelos OpenAI seria insuficiente para o objetivo comparativo. A Tarefa 8 incorpora os **três provedores originais**, usando versões disponíveis em 2026.

| ID | Provedor | Modelo proposto | Esforço alvo | Estado |
|---|---|---|---|---|
| E01 | OpenAI | GPT-6 | Médio | Pendente |
| E02 | OpenAI | GPT-6 | Alto | Pendente |
| E03 | OpenAI | GPT-5.6 | Médio | Pendente |
| E04 | OpenAI | GPT-5.6 | Alto | Pendente |
| E05 | Anthropic | Claude Sonnet 5 | Médio/equivalente disponível | Pendente |
| E06 | Anthropic | Claude Sonnet 5 | Alto/máximo disponível | Pendente |
| E07 | Google | Gemini 3.1 Pro | Médio/equivalente disponível | Pendente |
| E08 | Google | Gemini 3.1 Pro | Alto/máximo disponível | Pendente |

**Importante:** trata-se de um **plano**, não de resultados. Só declarar o modelo e o esforço efetivamente selecionados. Se não houver seleção de esforço na interface utilizada, registrar 'não configurável' e não afirmar que as condições médio/alto foram executadas. Se a versão proposta não estiver disponível, substituir por uma disponível do mesmo provedor, documentando nome, data e justificativa; não renomear a versão executada.

As comparações de esforço devem ser **intramodelo** (E01 × E02; E03 × E04; E05 × E06; E07 × E08). A comparação de versão com esforço fixo é E01 × E03 e E02 × E04. Níveis chamados 'Alto' em provedores diferentes **não são necessariamente equivalentes**, e versões novas não isolam o efeito do esforço.

### Continuidade e limitações da linha de base

- **GPT-6 da T7:** avaliação própria registrada, porém com esforço desconhecido; comparação histórica descritiva, não causal.
- **GPT-4o, Claude 3.5 Sonnet e Gemini 1.5 Pro da T7:** resultados transcritos do **gabarito de referência**, sem transcrição integral das execuções. Registrar como 'referência fornecida' e nunca como experimentos próprios.
- **Claude Sonnet 3.5:** retirado da API em 2025, segundo a Anthropic; não é razoável exigir uma nova execução nessa versão em 2026.
- **Gemini 1.5 Pro:** encerrado em 29/09/2025, segundo o Google.
- O mesmo artefato, SHA, diretrizes oficiais, prompts, logs e condições de acesso à documentação devem ser mantidos. O efeito do provedor deve ser analisado separadamente do efeito de versão/esforço.

Consulte [`MODELOS_PROVEDORES.md`](MODELOS_PROVEDORES.md) para disponibilidade, plataformas, instruções e limitações. Se o esforço máximo for denominado 'Extra Alto' ou outro nome na interface, registrar esse nome literal e, para contraste, documentar a condição de menor esforço.

## 5. Procedimento em cada execução

1. Abrir **uma conversa nova** para a configuração. Selecionar o modelo e o esforço **antes** do envio.
2. Registrar data, hora, provedor, modelo, esforço e disponibilidade de navegação/acesso a repositórios.
3. Garantir acesso ao mesmo README, arquivos de configuração e diretrizes do SBRC 2026.
4. Enviar **Prompt 1** sem alterações. Salvar a resposta completa e extrair F/R, justificativas e evidências.
5. Na **mesma conversa**, enviar **Prompt 2** sem alterações, com os mesmos logs. Salvar a resposta completa e extrair os vereditos revisados.
6. Verificar manualmente cada evidência documental alegada, com URL, caminho e trecho. Marcar `confirmada`, `não localizada` ou `inconclusiva`.
7. Preencher uma ficha de [`REGISTRO_EXECUCOES.md`](REGISTRO_EXECUCOES.md) e a [`TABELA_COMPARATIVA.md`](TABELA_COMPARATIVA.md).
8. Repetir a mesma configuração, idealmente pelo menos **duas vezes**, em conversas independentes, identificadas como replicações (E01-R1, E01-R2 etc.). Não trocar prompt, versão nem esforço entre replicações.

**Importante:** reutilizar logs da Tarefa 7 testa a **revisão do parecer diante da evidência de execução**, e não equivale a rodar novamente o programa. Se ocorrer execução do software, documentar separadamente comandos, SHA, ambiente e saídas reais; não misturar essas evidências com logs apenas transcritos do enunciado.

## 6. Critérios de análise

- **Estabilidade dos selos:** os vereditos variam quando mudamos apenas a versão ou o esforço?
- **Qualidade das evidências:** qual proporção das afirmações concretas tem correspondência verificável no repositório e nas instruções?
- **Identificação da causa:** o avaliador interpreta `ConnectionRefusedError` como falha de disponibilidade/configuração do Ollama, sem confundir com defeito comprovado do algoritmo?
- **Consistência experimental:** compreende que o teste `random` não valida o K-Agent e que os 50 ciclos não foram concluídos?
- **Equivalência da configuração:** percebe que o comando K-Agent informado não garante, por si só, a configuração descrita no README?
- **Concordância com a avaliação oficial:** verificar o acordo/desacordo com os selos oficiais, **sem** tratar um único log com falha ambiental como refutação da avaliação oficial.

**Indicadores recomendados:** (a) alterações de F/R; (b) quantidade de evidências confirmadas, não localizadas e inconclusivas; (c) menções corretas aos limites da execução; (d) replicações concordantes por configuração. Com quatro configurações e poucas replicações, evitar generalizações estatísticas amplas.

## 7. Resultado oficial do SBRC 2026

O trabalho *Agente K-alibra: Estratégia para Seleção de K-Clientes em Aprendizado Federado autônoma* consta nos [resultados oficiais](https://doc-artefatos.github.io/sbrc2026/results.html) com **D, F, S e R**. Isso serve como **referência institucional**, não como prova de que a execução local e os logs apresentados deveriam necessariamente produzir o mesmo parecer.

## 8. Conclusão parcial (a completar após executar E01–E08)

A auditoria das fontes e um parecer piloto desta sessão foram realizados. As oito condições mult provedores foram planejadas, mas não executadas nesta sessão. Entretanto, **ainda não é possível concluir** se elevar o esforço ou trocar a versão aumenta a consistência. A inferência dependerá das respostas integrais efetivamente obtidas, da auditoria das evidências e da comparação controlada. A Tarefa 7 oferece um ponto de partida, mas o seu nível de esforço desconhecido limita inferências causais sobre mudanças T7 × T8.

## 9. Estrutura dos materiais

- [`PROMPTS_T7.md`](PROMPTS_T7.md) — textos fixos utilizados em todas as condições;
- [`REGISTRO_EXECUCOES.md`](REGISTRO_EXECUCOES.md) — ficha por execução e evidências;
- [`TABELA_COMPARATIVA.md`](TABELA_COMPARATIVA.md) — comparação T7 e T8, sem resultados fabricados;
- [`FLUXOGRAMA.md`](FLUXOGRAMA.md) — protocolo experimental atualizado;
- [`AUDITORIA_FONTES.md`](AUDITORIA_FONTES.md) — verificação das evidências no commit consultado do artefato;
- [`PARECER_PILOTO.md`](PARECER_PILOTO.md) — parecer exploratório desta sessão, não contado como teste E01–E08.
- [`MODELOS_PROVEDORES.md`](MODELOS_PROVEDORES.md) — orientação para executar Claude e Gemini, com disponibilidade e controle experimental.

### Fontes

- [Repositório do artefato](https://github.com/rafaeloj/sbrc2026)
- [Configuração do Flower](https://github.com/rafaeloj/sbrc2026/blob/main/selection-agent/pyproject.toml)
- [Instruções oficiais do SBRC 2026](https://doc-artefatos.github.io/sbrc2026/)
- [Resultados oficiais](https://doc-artefatos.github.io/sbrc2026/results.html)
- [Tarefa 7](https://github.com/fernandomarquesaluno-svg/ativ_revisao_artfatos_multiplas_llms)
**Commit do artefato auditado:** [`949f83c6db86d682240b7a61d1d2d406609413b6`](https://github.com/rafaeloj/sbrc2026/commit/949f83c6db86d682240b7a61d1d2d406609413b6).
