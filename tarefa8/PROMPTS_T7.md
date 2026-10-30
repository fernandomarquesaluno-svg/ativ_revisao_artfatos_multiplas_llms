# Prompts fixos — Tarefa 7, reaplicados na Tarefa 8

**Regra de controle:** enviar o mesmo texto em todas as configurações. Modelo, versão e esforço devem ser alterados na interface de execução, e não por meio de mudanças no enunciado. Enviar o Prompt 2 **na mesma conversa** da resposta ao Prompt 1.

## Prompt 1 — Análise documental

```text
Você é um revisor de artefatos de software participando do Comitê de Avaliação de Artefatos do SBRC 2026.
Sua tarefa é realizar uma avaliação analítica (documental) do repositório do artefato "sbrc2026 — Selection Agent" (https://github.com/rafaeloj/sbrc2026), que propõe um K-Agent para Aprendizado Federado utilizando a biblioteca Flower e LLMs.

Com base nas diretrizes oficiais do SBRC 2026 (https://doc-artefatos.github.io/sbrc2026/), analise a documentação (README, diretórios e scripts) e forneça sua avaliação para os seguintes selos:
1. Selo F (Funcional): O artefato parece completo, executável e funcional com base na documentação?
2. Selo R (Reprodutível): A documentação apresenta instruções suficientes para reproduzir os experimentos descritos no artigo (incluindo a reivindicação de redução de tráfego entre 44,4% e 59%)?

Para cada selo, forneça:
- Veredito (Atribuído, Não Atribuído ou Parcial)
- Evidências encontradas no repositório
- Falhas ou limitações identificadas na documentação
```

## Prompt 2 — Auditoria de logs de execução

```text
Agora apresento as evidências da execução prática realizada no seguinte ambiente operacional:
- Sistema Operacional: Ubuntu 22.04 LTS
- Linguagem/Framework: Python 3.10 | PyTorch 2.7.1
- Hardware: CPU com 8 vCPUs e 16 GB de RAM

Evidência 1 — Teste Mínimo (Método Aleatório):
Comando executado:
cd selection-agent && flwr run . local-simulation --options selection-method='random' num-server-rounds=1
Resultado obtido no terminal:
[SUCCESS] Simulation finished. Modelo salvo em models/20260315_random_final_model_.pt.

Evidência 2 — Execução Experimental Principal (K-Agent):
Comando executado:
cd selection-agent && flwr run . local-simulation --options selection-method='k-agent' num-server-rounds=50
Resultado obtido no terminal:
Attempting connection to Ollama model qwen3:0.6b at http://localhost:11434...
ConnectionRefusedError: [Errno 111] Connection refused
[ERROR] K-Agent selection failed. Execution aborted.

Com base nestes logs de execução real:
1. Você mantém ou altera o veredito anterior do Selo F (Funcional)? Justifique.
2. Você mantém ou altera o veredito anterior do Selo R (Reprodutível)? Justifique.
3. Apresente o seu parecer final de concessão dos selos e a recomendação técnica para o autor do artefato.
```

> **Proveniência:** textos dos prompts fornecidos na atividade da Tarefa 7. Os logs dentro do Prompt 2 foram informados no enunciado; sua origem não foi auditada independentemente.