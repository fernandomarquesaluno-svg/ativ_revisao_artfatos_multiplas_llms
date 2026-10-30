# Avaliação de Artefatos de Software com LLMs — SBRC 2026

> **Estudo de caso:** análise documental e auditoria de logs do artefato *Selection Agent / K-Agent* para Aprendizado Federado.

| Campo | Informação |
|---|---|
| Artefato analisado | [SBRC 2026 — Selection Agent](https://github.com/rafaeloj/sbrc2026) |
| Modelo utilizado nesta avaliação | GPT-6 |
| Data da avaliação | 30 de outubro de 2026 |
| Tipo de análise | Revisão documental + análise de logs fornecidos |
| Critérios | Funcional (F) e Experimentos Reprodutíveis (R) |

> [!IMPORTANT]
> Esta é uma **atividade acadêmica de avaliação simulada**. Os logs foram fornecidos no enunciado; o avaliador **não executou independentemente** o código. O parecer não substitui o julgamento oficial do Comitê Técnico de Artefatos (CTA) do SBRC 2026. No [resultado oficial do evento](https://doc-artefatos.github.io/sbrc2026/results.html), o trabalho *Agente K-alibra* consta com os quatro selos.

## 1. Objetivo

Avaliar se a documentação do repositório permite compreender, instalar e executar o artefato, e se os logs disponibilizados demonstram sua funcionalidade e a reprodução das alegações experimentais.

O projeto utiliza [Flower](https://flower.ai/) para Aprendizado Federado e integra um agente baseado em modelo de linguagem (K-Agent), por meio do [Ollama](https://ollama.com/), com o objetivo de adaptar dinamicamente a quantidade de clientes selecionados. O README original reivindica **redução de tráfego de dados de 44,4% a 59%**, conforme as condições experimentais descritas pelos autores.

## 2. Etapa 1 — Avaliação documental

### 2.1 Selo F — Funcional

**Veredito analítico inicial: Atribuído preliminarmente, condicionado à verificação prática.**

**Evidências favoráveis:**
- `README.md` apresenta dependências, instalação, configuração, execução mínima e experimentos.
- `requirements.txt` e `selection-agent/pyproject.toml` documentam dependências e parâmetros do projeto.
- A documentação identifica o servidor federado, os clientes, as estratégias de seleção e a integração do K-Agent.
- Existe um procedimento de teste mínimo baseado em seleção aleatória, com saída esperada de modelo treinado.

**Limitações:** a documentação, por si só, não comprova o funcionamento. Além disso, o teste mínimo com `selection-method=random` não exercita a integração com o modelo de linguagem, componente essencial da contribuição central.

**Interpretação:** a estrutura parece adequada para iniciar a avaliação, mas a atribuição efetiva do selo depende de evidências de execução.

### 2.2 Selo R — Experimentos Reprodutíveis

**Veredito analítico inicial: Parcial (categoria didática).**

**Evidências favoráveis:**
- O README especifica experimentos de 50 rodadas, parâmetros e resultados esperados.
- O repositório disponibiliza scripts de execução e notebooks para análise.
- Há instruções para obter o modelo `qwen3:0.6b` e utilizar o serviço Ollama.

**Limitações:**
1. A configuração padrão em `selection-agent/pyproject.toml` contém `num-supernodes=5`, `sample-size=15` e `k-agent-selection-method='random_selection'`, enquanto a reivindicação experimental principal especifica `num-supernodes=25`, `sample-size=-1` e `k-agent-selection-method='oort_selection'`.
2. Algumas dependências adotam versões mínimas (`>=`) em vez de versões fixadas, potencialmente afetando a estabilidade do ambiente de reprodução.
3. O procedimento depende da disponibilidade e da configuração do serviço Ollama.
4. Somente os testes efetivos e a comparação das métricas permitem comprovar quantitativamente a reivindicação de economia de tráfego.

**Interpretação:** há material para orientar uma tentativa de reprodução, porém a documentação não comprova que os resultados foram reproduzidos.

## 3. Etapa 2 — Auditoria dos logs fornecidos

### 3.1 Ambiente de execução informado

| Componente | Configuração |
|---|---|
| Sistema operacional | Ubuntu 22.04 LTS |
| Linguagem | Python 3.10 |
| Framework de aprendizado profundo | PyTorch 2.7.1 |
| Hardware | 8 vCPUs, 16 GB RAM |
| Infraestrutura federada | Flower |
| Serviço LLM | Ollama (`qwen3:0.6b`) |

### 3.2 Evidência 1 — Seleção aleatória

Comando informado:

```bash
cd selection-agent && flwr run . local-simulation --options selection-method='random' num-server-rounds=1
```

Saída informada:

```text
[SUCCESS] Simulation finished.
Modelo salvo em models/20260315_random_final_model_.pt
```

**Análise:** o resultado é compatível com o funcionamento do fluxo básico de treinamento federado com seleção aleatória e a geração do arquivo de modelo. A evidência não valida a lógica de seleção com LLM.

### 3.3 Evidência 2 — K-Agent (50 rodadas)

Comando informado:

```bash
cd selection-agent && flwr run . local-simulation --options selection-method='k-agent' num-server-rounds=50
```

Saída informada:

```text
Attempting connection to Ollama model qwen3:0.6b at http://localhost:11434...
ConnectionRefusedError: [Errno 111] Connection refused
[ERROR] K-Agent selection failed. Execution aborted.
```

**Análise:** a conexão foi recusada em `localhost:11434`, porta padrão do servidor Ollama. Esse resultado é compatível com um serviço não iniciado, indisponível ou inacessível naquele endereço. **Não é prova de defeito lógico no código do K-Agent.** Entretanto, a execução foi interrompida e sua funcionalidade principal não foi testada com sucesso.

Além disso, o comando informado não demonstra que os demais parâmetros do experimento principal foram aplicados; é necessário conferir a configuração efetivamente utilizada antes de classificar uma execução futura como reprodução fiel.

## 4. Revisão dos vereditos

### 4.1 Selo F — Funcional

**Veredito revisado: Parcial (categoria analítica; não é um selo oficial).**

O método aleatório concluiu uma simulação, indicando que parte do ambiente e do fluxo federado opera. Contudo, a principal funcionalidade — seleção dinâmica pelo K-Agent — não foi validada porque a comunicação com o Ollama falhou.

A evidência aponta uma **falha de infraestrutura ou configuração**, sem permitir concluir pela existência de erro de implementação. Portanto, o desempenho funcional observado é parcial e a concessão plena não pode ser fundamentada nesses logs.

### 4.2 Selo R — Experimentos Reprodutíveis

**Veredito revisado: Não Atribuído nesta simulação.**

A falha impediu completar a execução de 50 rodadas e gerar resultados suficientes para verificar:

- redução de tráfego entre 44,4% e 59%;
- acurácia comparada aos métodos de referência;
- comportamento da seleção dinâmica de clientes;
- figuras, tabelas e métricas derivadas do experimento principal.

A ausência de reprodução **não significa que o resultado científico esteja errado**; significa que a tentativa apresentada não produziu evidências para verificá-lo.

## 5. Quadro consolidado

| Critério | Etapa 1 — Documental | Etapa 2 — Auditoria dos logs |
|---|---|---|
| **F — Funcional** | Atribuído preliminarmente | **Parcial** |
| **R — Experimentos Reprodutíveis** | Parcial | **Não Atribuído** |

> **Nota de interpretação:** “Parcial” é uma categoria descritiva adotada para esta atividade. Não representa um selo intermediário concedido pelo CTA.

## 6. Comparação com modelos de referência

| Modelo | Etapa 1 (F / R) | Etapa 2 (F / R) |
|---|---|---|
| GPT-4o | Atribuído / Atribuído | Parcial ou Atribuído / Não Atribuído |
| Claude 3.5 Sonnet | Atribuído / Parcial | Parcial ou Atribuído / Não Atribuído |
| Gemini 1.5 Pro | Atribuído / Atribuído | Parcial ou Atribuído / Não Atribuído |
| **GPT-6 (esta avaliação)** | **Atribuído / Parcial** | **Parcial / Não Atribuído** |

Os resultados dos três primeiros modelos foram **fornecidos no enunciado** e não foram reexecutados ou auditados nesta atividade.

O modelo avaliado revisou o parecer após os logs e distinguiu a indisponibilidade de um serviço externo de uma falha comprovada no algoritmo.

## 7. Recomendações técnicas

1. Confirmar que o Ollama está ativo (`ollama serve` em ambientes que exigem inicialização manual).
2. Verificar que o modelo esteja disponível (`ollama pull qwen3:0.6b`).
3. Testar a API local (`curl http://localhost:11434/api/tags`).
4. Executar um teste mínimo usando `selection-method='k-agent'`.
5. Registrar a configuração efetiva da execução, incluindo `num-supernodes`, `sample-size` e `k-agent-selection-method`.
6. Repetir as 50 rodadas e preservar logs, métricas e configurações para comparação com os resultados do artigo.
7. Acrescentar verificações automatizadas de dependências e serviços ao procedimento de reprodução.

## 8. Parecer final

A análise documental indica que o Selection Agent possui documentação de instalação, organização de componentes e orientação para execução experimental. Na auditoria dos logs fornecidos, o fluxo básico com seleção aleatória concluiu uma simulação, enquanto a execução principal foi interrompida por recusa de conexão com Ollama.

Assim, **o parecer didático é F: Parcial e R: Não Atribuído**, considerando apenas as evidências disponibilizadas nesta atividade.

A falha de infraestrutura não demonstra que o algoritmo esteja incorreto, mas impede verificar seu funcionamento e as alegações quantitativas de economia de tráfego. A obtenção de resultados reproduzíveis requer execução completa, parâmetros equivalentes e métricas passíveis de comparação.

Este resultado é **independente da decisão oficial do CTA**, que atribuiu os quatro selos ao trabalho no SBRC 2026.

## 9. Fontes

1. [Repositório público do artefato — rafaeloj/sbrc2026](https://github.com/rafaeloj/sbrc2026)
2. [README do artefato](https://github.com/rafaeloj/sbrc2026/blob/main/README.md)
3. [Configuração `selection-agent/pyproject.toml`](https://github.com/rafaeloj/sbrc2026/blob/main/selection-agent/pyproject.toml)
4. [Portal de Avaliação de Artefatos — SBRC 2026](https://doc-artefatos.github.io/sbrc2026/)
5. [Resultados oficiais da avaliação de artefatos](https://doc-artefatos.github.io/sbrc2026/results.html)
6. [Documentação do Ollama](https://docs.ollama.com/)
7. Logs do experimento disponibilizados no enunciado desta atividade (transcritos em [LOGS_FORNECIDOS.md](LOGS_FORNECIDOS.md)).

---

**Escopo e autoria:** este repositório contém apenas a análise técnica elaborada para a atividade. O código e a documentação do Selection Agent pertencem aos autores do [repositório original](https://github.com/rafaeloj/sbrc2026); não foram copiados para cá.