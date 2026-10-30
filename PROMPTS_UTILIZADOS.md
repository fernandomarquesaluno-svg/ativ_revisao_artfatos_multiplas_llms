# Prompts utilizados — Atividade 7

> **Proveniência:** textos fornecidos pelo aluno em 30/10/2026 como **prompts reconstruídos**. Não são transcrições autenticadas do histórico de cada LLM. Para comprovação experimental, anexar a versão efetivamente enviada, data, versão do modelo e respostas originais.

## Prompt 1 — Avaliação analítica (documental)

> Atue como um avaliador do comitê de artefatos do evento SBRC 2026. Com base exclusivamente nas instruções oficiais de avaliação de artefatos do SBRC 2026 e na documentação disponível no repositório (https://github.com/rafaeloj/sbrc2026), faça uma avaliação analítica do artefato "Selection Agent (K-Agent)". Indique se os selos F (Funcional) e R (Reprodutível) devem ser atribuídos. Para cada selo, exija o veredito final, as evidências encontradas na documentação que sustentam a sua decisão e aponte quaisquer falhas ou lacunas identificadas.

## Prompt 2 — Avaliação por execução (prática)

> Agora, reavalie os selos F e R com base nos resultados da execução prática do artefato. Ambiente: Ubuntu 22.04 LTS, Python 3.10, PyTorch 2.7.1, CPU 8 vCPUs, 16 GB RAM.
>
> **Teste 1 (Método random):** Comando: `cd selection-agent && flwr run . local-simulation` (selection-method='random', num-server-rounds=1). Resultado: `[SUCCESS] Simulation finished`. Modelo salvo em `models/20260315_random_final_model_.pt`.
>
> **Teste 2 (Método K-Agent):** Comando: `selection-method='k-agent'`, `num-server-rounds=50`. Resultado: Tentativa de conexão com Ollama (modelo qwen3:0.6b) gerou erro `ConnectionRefusedError` em `http://localhost:11434`. A execução falhou e foi abortada.
>
> Com base nessas evidências de execução, confirme ou revise os seus julgamentos anteriores para os selos F e R, justificando a decisão.

## Observações metodológicas

- Esses dois textos não incorporam literalmente as instruções de revisão do SBRC 2026: fazem referência a elas. Deve-se confirmar que o conteúdo oficial foi disponibilizado integralmente a cada LLM, como exige o enunciado.
- A etapa 2 fornece logs resumidos para reavaliação. **Não prova que cada LLM executou o código.**
- É necessário guardar as **respostas reais** e os registros de versões/data de pelo menos três modelos de três provedores distintos.
- Não confundir «parcial» (interpretação didática) com selo oficial.
