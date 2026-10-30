# Tabela comparativa — Tarefas 7 e 8

**Critérios:** F (Funcional), R (Experimentos Reprodutíveis). `Parcial` é apenas classificação de análise, não selo oficial.

## 1. Selos por condição

| Origem | Execução | Modelo | Esforço | Etapa 1 — F | Etapa 1 — R | Etapa 2 — F | Etapa 2 — R | Evidências auditadas |
|---|---|---|---|---|---|---|---|---|
| T7 | Baseline documentado | GPT-6 | Não registrado | Atribuído preliminarmente | Parcial | Parcial | Não Atribuído | README, configuração e logs do enunciado |
| T8 | E01 | GPT-6 | Médio | **Pendente** | **Pendente** | **Pendente** | **Pendente** | **Pendente** |
| T8 | E02 | GPT-6 | Alto | **Pendente** | **Pendente** | **Pendente** | **Pendente** | **Pendente** |
| T8 | E03 | GPT-5.6 | Médio | **Pendente** | **Pendente** | **Pendente** | **Pendente** | **Pendente** |
| T8 | E04 | GPT-5.6 | Alto | **Pendente** | **Pendente** | **Pendente** | **Pendente** | **Pendente** |

**Comparação principal:** E01 × E02 (somente esforço), E03 × E04 (somente esforço), E01 × E03 (somente versão), E02 × E04 (somente versão). Comparar com T7 como histórico descritivo, pois seu esforço não foi registrado.

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

| Comparação | Mudou F? | Mudou R? | Evidências novas ou ausentes | Diagnóstico técnico melhorou? | Conclusão |
|---|---|---|---|---|---|
| E01 × E02 (esforço, GPT-6) | Pendente | Pendente | Pendente | Pendente | Pendente |
| E03 × E04 (esforço, GPT-5.6) | Pendente | Pendente | Pendente | Pendente | Pendente |
| E01 × E03 (versão, Médio) | Pendente | Pendente | Pendente | Pendente | Pendente |
| E02 × E04 (versão, Alto) | Pendente | Pendente | Pendente | Pendente | Pendente |

## 4. Síntese interpretativa (a completar)

Não há resultados novos registrados até o momento; não é possível afirmar melhora, piora ou estabilidade. Após as execuções, confrontar cada divergência com evidências verificáveis e os limites metodológicos, evitando equiparar falha local de infraestrutura a reprovação formal pelo CTA.