# Registro histórico das tentativas de execução — evidência secundária

**Estado (05/11/2026):** o aluno informou que **não tem mais acesso ao Ubuntu usado nos testes**. Não há, nesta revisão, arquivos originais completos de stdout/stderr, código de saída, configurações finais ou prova independente de execução. **Não afirmar que estes comandos foram reexecutados nem que os trechos são logs integrais.**

## Origem
Trechos de comandos e resultados apresentados em relatórios PDF anteriores do aluno, bem como no Prompt 2 enviado às LLMs. São registros **relatados**, não capturas autenticadas de terminal. Os PDFs `Relatório Final de Avaliação de Artefatos.pdf` e `atividade 7 lab de artefatos (1).pdf` foram fornecidos na conversa, mas não contêm as saídas integrais.

## Tentativa A — seleção Random (teste mínimo)

- **Ambiente relatado:** Ubuntu 22.04 LTS, Python 3.10, PyTorch 2.7.1, 8 vCPUs, 16 GB RAM; não foi possível confirmar essas versões por registros originais.
- **Comando relatado** (conforme documentos):
  ```bash
  cd selection-agent
  flwr run . local-simulation --options selection-method='random' num-server-rounds=1
  ```
- **Saída resumida relatada:** `[SUCCESS] Simulation finished`
- **Modelo salvo citado:** `models/20260315_random_final_model_.pt`; **arquivo não localizado nem autenticado** nesta revisão, e o nome pode não corresponder ao padrão da versão do repositório analisada.
- **Interpretação defensável:** relato favorável a um teste mínimo de Flower com seleção aleatória. **Não comprova execução do algoritmo K-Agent**.

## Tentativa B — seleção K-Agent (experimento principal)

- **Comando relatado:**
  ```bash
  cd selection-agent
  flwr run . local-simulation --options selection-method='k-agent' num-server-rounds=50
  ```
- **Saídas resumidas reportadas:** `Attempting connection to Ollama...`, `ConnectionRefusedError: [Errno 111] Connection refused`, `[ERROR] K-Agent selection failed`.
- **Serviço/modelo relatados:** API Ollama no `http://localhost:11434`, modelo `qwen3:0.6b`.
- **Interpretação defensável:** o processo foi interrompido antes de completar as 50 rodadas. **Não há métricas reproduzidas da reivindicação principal** (redução de tráfego 44,4%–59%).
- **Causa não identificada conclusivamente:** o erro pode decorrer de serviço não inicializado, endereço/configuração de rede/contêiner ou outro problema de integração; não demonstra defeito lógico no K-Agent.

## Matriz de rastreabilidade

| Item | Informação disponível | Evidência ausente | Estado |
|---|---|---|---|
| Comandos de Random e K-Agent | Textos reproduzidos nos PDFs | Histórico de shell e configurações efetivas | Relatado |
| Êxito do Random | Mensagem resumida `[SUCCESS]` | Log integral, saída e artefato verificáveis | Não autenticado |
| Falha do K-Agent | Excerto `ConnectionRefusedError` | Traceback completo, tentativa de recuperação e logs de Ollama | Não autenticado |
| Métricas do artigo | Redução esperada 44,4%–59% citada na documentação | Resultados práticos desta tentativa | Não reproduzida |
| Pareceres das LLMs | Respostas documentadas de GPT-6, Claude e Gemini | Execuções independentes por provedor | Análises de relatos/logs resumidos |

## Uso correto na entrega

Descrever esta fase como **“análise de evidências de execução relatadas pelo aluno”**, nunca como **“reprodução completa do experimento”**. No slide de resultados, usar "Random: sucesso relatado (sem log integral)" e "K-Agent: falha de conexão relatada (sem reprodução da métrica)". Em conclusões, preservar os selos oficiais F/R do SBRC 2026, separando-os das recomendações das LLMs.

## Limitação que permanece

A impossibilidade atual de acessar o Ubuntu impede verificar logs, parâmetros, arquivos gerados e métricas originais. Por isso, **não há comprovação técnica suficiente para concluir a etapa experimental exigida como execução reproduzível**. O relatório e os slides podem ser finalizados de modo transparente como **estudo comparativo com limitação de evidências**, mas não declarar execução plenamente auditada.
