# Laboratório de IA Aplicada — Tarefa 7
**Avaliação multimodelo de artefatos científicos**  
**Autor:** Fernando Henrique de Souza Marques  
**Artefato:** Selection Agent (K-Agent) — SBRC 2026

## 1. Objetivo e recorte
Comparar as recomendações de três LLMs de provedores distintos com os selos oficialmente atribuídos ao artefato, considerando a análise documental e a reavaliação à luz dos resultados de execução. Artefato: https://github.com/rafaeloj/sbrc2026. Fonte oficial: https://doc-artefatos.github.io/sbrc2026/results.html.

O SBRC 2026 registra os selos D, F, S e R para o trabalho correspondente. A atividade se concentra nos selos **F (Funcional)** e **R (Experimentos Reprodutíveis)**.

## 2. Modelos avaliados
- **GPT-6 — OpenAI**
- **Claude 3.5 Sonnet — Anthropic**
- **Gemini 1.5 Pro — Google**

As atribuições a seguir reproduzem os resultados **relatados pelo aluno**. Sua rastreabilidade depende da preservação de respostas originais, datas, versões e prompts efetivamente enviados.

## 3. Avaliação analítica — etapa 1
**GPT-6:** recomendou F preliminarmente e avaliou R com ressalvas; a documentação isolada não comprova a execução.

**Claude 3.5 Sonnet:** recomendou F e manifestou ressalvas sobre R, especialmente quanto ao provisionamento e à disponibilidade do serviço Ollama.

**Gemini 1.5 Pro:** recomendou F e R, com ênfase nos procedimentos e scripts de orquestração apresentados.

Os três pareceres foram produzidos a partir das informações documentais relatadas; a atribuição de um selo oficial depende de critérios e avaliação completos, não apenas do README.

## 4. Execução — etapa 2
**Ambiente informado:** Ubuntu 22.04 LTS, Python 3.10, PyTorch 2.7.1, 8 vCPUs e 16 GB RAM.

**Teste 1 — baseline aleatório:** `selection-method='random'`, uma rodada. Log fornecido: `[SUCCESS] Simulation finished`; arquivo de modelo salvo em `models/20260315_random_final_model_.pt`. Evidencia a execução do fluxo mínimo, não a funcionalidade principal do K-Agent.

**Teste 2 — K-Agent:** `selection-method='k-agent'`, 50 rodadas previstas. A chamada ao modelo `qwen3:0.6b` via `http://localhost:11434` resultou em `ConnectionRefusedError` e interrupção. O experimento central não foi concluído.

**Limite da evidência:** os logs informados, isoladamente, não distinguem ausência de serviço iniciado, configuração incorreta do ambiente ou defeito no artefato. Eles não comprovam que a avaliação oficial estava incorreta, tampouco que os resultados experimentais dos autores são irreprodutíveis.

## 5. Revisão relatada após os logs
**GPT-6:** considerou F parcialmente demonstrado (categoria didática) e R não atribuído nesta tentativa, devido à interrupção do experimento principal.

**Claude 3.5 Sonnet:** manteve F com ressalvas; sua cautela original em R foi reforçada pelo teste não concluído.

**Gemini 1.5 Pro:** manteve F com ressalvas e retirou a recomendação de R na tentativa apresentada.

**Importante:** “parcial” é uma categoria descritiva neste relatório; não corresponde a selo intermediário oficial. A falha observada de conexão não constitui, por si só, fundamento suficiente para invalidar um selo concedido pelo comitê.

## 6. Tabela comparativa
| LLM / provedor | Fase 1: F | Fase 1: R | Fase 2: F | Fase 2: R |
|---|---|---|---|---|
| GPT-6 / OpenAI | Preliminar, condicionado | Com ressalvas | Parcialmente demonstrado | Não atribuído nesta tentativa |
| Claude 3.5 Sonnet / Anthropic | Recomendado | Com ressalvas | Com ressalvas | Não recomendado nesta tentativa |
| Gemini 1.5 Pro / Google | Recomendado | Recomendado | Com ressalvas | Não recomendado nesta tentativa |
| Comitê SBRC 2026 | Atribuído | Atribuído | — | — |

## 7. Fluxograma do procedimento
```text
[Artefato SBRC 2026 + selos oficiais]
                 |
                 v
[Instruções oficiais + documentação]
                 |
                 v
[Prompt 1 padronizado -> 3 LLMs]
                 |
                 v
[Avaliação analítica: F e R + evidências]
                 |
                 v
[Verificação no repositório + execução/logs]
                 |
                 v
[Prompt 2 padronizado -> mesmas 3 LLMs]
                 |
                 v
[Reavaliação F e R + justificativas]
                 |
                 v
[Comparação com selos oficiais]
                 |
                 v
[Concordâncias, divergências e limitações]
```

## 8. Análise e conclusão
Na etapa documental, Gemini recomendou F e R, Claude apontou ressalvas sobre R e GPT-6 recomendou F preliminarmente e R com ressalvas. Após os logs, os modelos teriam convergido quanto à insuficiência de evidência para reproduzir o experimento principal naquela tentativa.

O estudo exemplifica como a inspeção documental e o teste operacional podem conduzir a conclusões diferentes. A interpretação tecnicamente defensável é **não ter sido possível reproduzir o experimento K-Agent com os logs apresentados**, e não afirmar que os selos oficiais deveriam ser revogados. A confirmação dos resultados multimodelo requer anexar as respostas autênticas e confirmar que cada LLM recebeu as instruções oficiais completas.

## Apêndice A — Prompt 1 (texto informado/reconstruído)
> Atue como um avaliador do comitê de artefatos do evento SBRC 2026. Com base exclusivamente nas instruções oficiais de avaliação de artefatos do SBRC 2026 e na documentação disponível no repositório (https://github.com/rafaeloj/sbrc2026), faça uma avaliação analítica do artefato "Selection Agent (K-Agent)". Indique se os selos F (Funcional) e R (Reprodutível) devem ser atribuídos. Para cada selo, exija o veredito final, as evidências encontradas na documentação que sustentam a sua decisão e aponte quaisquer falhas ou lacunas identificadas.

## Apêndice B — Prompt 2 (texto informado/reconstruído)
> Agora, reavalie os selos F e R com base nos resultados da execução prática do artefato. Ambiente: Ubuntu 22.04 LTS, Python 3.10, PyTorch 2.7.1, CPU 8 vCPUs, 16 GB RAM.
>
> **Teste 1 (Método random):** Comando: `cd selection-agent && flwr run . local-simulation` (selection-method='random', num-server-rounds=1). Resultado: `[SUCCESS] Simulation finished`. Modelo salvo em `models/20260315_random_final_model_.pt`.
>
> **Teste 2 (Método K-Agent):** Comando: `selection-method='k-agent'`, `num-server-rounds=50`. Resultado: Tentativa de conexão com Ollama (modelo qwen3:0.6b) gerou erro `ConnectionRefusedError` em `http://localhost:11434`. A execução falhou e foi abortada.
>
> Com base nessas evidências de execução, confirme ou revise os seus julgamentos anteriores para os selos F e R, justificando a decisão.

**Nota metodológica:** os textos dos prompts foram informados como reconstruídos, não autenticados por exportação das conversas. As respostas das LLMs são descritas no relatório, mas os registros integrais ainda devem ser anexados. As instruções oficiais devem ter sido de fato fornecidas a cada LLM, e não apenas citadas por URL.

## Referências
1. Repositório do artefato: https://github.com/rafaeloj/sbrc2026
2. Instruções e resultados do SBRC 2026: https://doc-artefatos.github.io/sbrc2026/
3. Resultados oficiais: https://doc-artefatos.github.io/sbrc2026/results.html

**Nota de versão:** GPT-6 substituiu GPT-4o como modelo OpenAI. Os pareceres do GPT-6 correspondem à avaliação desta conversa, e não foram simplesmente renomeados. Os resultados de Claude e Gemini são relatados pelo aluno, pendente a anexação das respostas originais.
