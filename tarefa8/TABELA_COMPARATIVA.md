# Tabela comparativa — Tarefas 7 e 8

**Critérios:** F (Funcional), R (Experimentos Reprodutíveis). `Parcial` é apenas classificação de análise, não selo oficial.

## 1. Selos por condição

As entradas **Referência fornecida** não são reproduções independentes da Tarefa 7. `Pendente` não deve ser convertido em veredito sem ter o registro integral da execução.

| Origem | ID | Provedor / modelo | Esforço | Documental F / R | Após logs F / R | Procedência |
|---|---|---|---|---|---|---|
| T7 | Base própria | OpenAI / GPT-6 | Desconhecido | Atribuído preliminarmente / Parcial | Parcial / Não Atribuído | Relatório próprio |
| T7 | Referência | OpenAI / GPT-4o | Não informado | Atribuído / Atribuído | Parcial ou Atribuído / Não Atribuído | Gabarito do enunciado |
| T7 | Referência | Anthropic / Claude 3.5 Sonnet | Não informado | Atribuído / Parcial | Parcial ou Atribuído / Não Atribuído | Gabarito do enunciado |
| T7 | Referência | Google / Gemini 1.5 Pro | Não informado | Atribuído / Atribuído | Parcial ou Atribuído / Não Atribuído | Gabarito do enunciado |
| T8 | E01 | OpenAI / GPT-6 | Médio | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E02 | OpenAI / GPT-6 | Alto | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E03 | OpenAI / GPT-5.6 | Médio | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E04 | OpenAI / GPT-5.6 | Alto | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E05 | Anthropic / Claude Sonnet 5 | Médio* | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E06 | Anthropic / Claude Sonnet 5 | Alto* | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E07 | Google / Gemini 3.1 Pro | Médio* | **Pendente** | **Pendente** | Teste não realizado |
| T8 | E08 | Google / Gemini 3.1 Pro | Alto* | **Pendente** | **Pendente** | Teste não realizado |

\* **Esforço alvo**: usar apenas quando for configurável e verificável na plataforma; senão registrar a impossibilidade ou o valor real. 

**Comparações planejadas:** (1) esforço: E01×E02, E03×E04, E05×E06, E07×E08; (2) versão OpenAI: E01×E03 e E02×E04; (3) comparação qualitativa entre provedores, com ressalva de diferenças de modelos e esforço. As três referências T7 são dados secundários sem transcrições completas.

## 2. Auditoria das evidências

| Afirmação a verificar | Fonte de verificação | Resultado esperado da checagem | Observações por modelo |
|---|---|---|---|
| O fluxo `random` concluiu uma simulação | Log fornecido na T7 | Confirmado **apenas pelo log transcrito** | Pendente |
| O K-Agent completou 50 rodadas | Log fornecido na T7 | Não demonstrado: execução interrompida | Pendente |
| O erro é prova de defeito no algoritmo | Log fornecido na T7 | Não: compatível com recusa de conexão ao serviço | Pendente |
| O experimento foi configurado como descrito no README | README vs. `pyproject.toml` e comando | Não comprovado pelo comando isolado | Pendente |
| Economia de tráfego de 44,4–59% foi reproduzida | Métricas/resultados das 50 rodadas | Não demonstrado nesses logs | Pendente |
| O trabalho recebeu oficialmente F e R | Portal de resultados do SBRC 2026 | Sim, na avaliação oficial | Pendente |

## 3. Matriz de divergências

| Comparação | Tipo | Mudança de F/R | Evidência adicional ou ausente | Interpretação |
|---|---|---|---|---|
| E01 × E02 | Esforço GPT-6 | Pendente | Pendente | Pendente |
| E03 × E04 | Esforço GPT-5.6 | Pendente | Pendente | Pendente |
| E05 × E06 | Esforço Claude Sonnet 5 | Pendente | Pendente | Pendente |
| E07 × E08 | Esforço Gemini 3.1 Pro | Pendente | Pendente | Pendente |
| E01 × E03 | Versão OpenAI, esforço Médio | Pendente | Pendente | Pendente |
| E02 × E04 | Versão OpenAI, esforço Alto | Pendente | Pendente | Pendente |
| OpenAI × Anthropic × Google | Exploração interprovedor | Pendente | Pendente | **Não interpretar** os nomes de esforço como escala universal |

## 4. Síntese interpretativa (a completar)

Não há resultados novos registrados até o momento; não é possível afirmar melhora, piora ou estabilidade. Após as execuções, confrontar cada divergência com evidências verificáveis e os limites metodológicos, evitando equiparar falha local de infraestrutura a reprovação formal pelo CTA.