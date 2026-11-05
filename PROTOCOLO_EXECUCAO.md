# Protocolo para completar a etapa prática

## 1. Fixar e registrar o material

```bash
git clone https://github.com/rafaeloj/sbrc2026.git
cd sbrc2026
git checkout 949f83c6db86d682240b7a61d1d2d406609413b6
git rev-parse HEAD
python --version
```

Obter o artigo associado e identificar as tabelas/figuras e os valores de referência. Usar as instruções SBRC 2026 anexadas. Não assumir que o commit atual é o mesmo avaliado oficialmente.

## 2. Instalar conforme os autores

Usar ambiente virtual dedicado, as dependências de `requirements.txt` e `pip install -e selection-agent`, conforme README. Registrar sistema, CPU/RAM/GPU, `pip freeze` e versões de Flower e Ollama. Não confundir a resolução atual de dependências `>=` com ambiente histórico idêntico.

## 3. Configurar e executar

Para o teste mínimo, editar `[tool.flwr.app.config]`: `selection-method="random"` e `num-server-rounds=1`. Conferir que o tamanho de amostra é compatível com os clientes configurados. Guardar original, diff e TOML efetivo. Os valores de clientes aparecem tanto na configuração da aplicação quanto em `[tool.flwr.federations.local-simulation]`.

O TOML original anuncia 30 CPUs e 1 GPU para o backend. Em ambiente somente CPU, registrar a adaptação de `options.backend.init_args.num_cpus` para os recursos disponíveis, `options.backend.init_args.num_gpus=0` e `options.backend.client-resources.num_gpus=0`. Isso constitui adaptação de ambiente, não reprodução idêntica de desempenho.

```bash
cd selection-agent
flwr run . local-simulation
```

Para K-Agent: iniciar Ollama, instalar `qwen3:0.6b`, verificar `http://localhost:11434/api/tags` e guardar o digest do modelo. Fazer teste reduzido de integração antes do experimento. Para a primeira reivindicação, aplicar 25 clientes nos dois locais, `sample-size=-1`, `k-agent-selection-method="oort_selection"`, 50 rodadas, `selection-method="k-agent"` e o prompt indicado pelos autores. Registrar toda mudança adicional. Executar também os comparadores exigidos pelo artigo. Não comparar tempos de hardware diferente como se fossem equivalentes.

## 4. Guardar provas

Por provedor e sessão: prompt, resposta integral, comandos exatos, operador, stdout, stderr, código de saída, duração, TOML final, versões, pesos/saídas e métricas. Salvar antes de executar novamente para não sobrescrever resultados. Se o comando falhar, preservar a falha e sua tentativa de correção.

## 5. Comparar resultados

Relacionar cada figura/tabela às saídas produzidas. Para tráfego, registrar a mesma unidade e calcular `100 * (trafego_baseline - trafego_kagent) / trafego_baseline`; baseline deve ser positivo e ter configuração comparável. Confrontar acurácia e critérios estatísticos do artigo; definir previamente a tolerância apropriada, sem inventar limiar depois de observar resultados. Uma execução curta serve como teste funcional, não como reprodução de 50 rodadas.

## 6. Julgar e relatar

Aplicar Prompt 2 a cada sessão. Separar decisão proposta, status da evidência e selo oficial. Resultados pendentes não entram como discordância. Distinguir análise de logs compartilhados de sessões práticas por LLM. Não afirmar que a IA executou se o aluno operou o terminal.

**Estado atual:** este é um protocolo preparado, não um relatório de execuções concluídas. Veja a pré-checagem real em `evidencias/prechecagem_2026-11-05.json`.
