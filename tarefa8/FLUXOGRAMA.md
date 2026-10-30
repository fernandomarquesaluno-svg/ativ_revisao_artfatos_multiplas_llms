# Fluxograma — Tarefa 8

O fluxo preserva artefato, critérios, prompts e logs da Tarefa 7. O protocolo agora contempla OpenAI, Anthropic e Google. Versão e esforço variam dentro de cada provedor; níveis de esforço de provedores distintos não são necessariamente equivalentes.

```mermaid
flowchart TD
  A[Recuperar protocolo e resultados da Tarefa 7] --> B[Fixar artefato, fontes oficiais, prompts e logs]
  B --> C[Definir provedores e configurações E01 a E08]
  C --> D[Selecionar provedor, modelo e esforço disponível]
  D --> E[Etapa 1: avaliação documental]
  E --> F[Registrar F, R e evidências citadas]
  F --> G[Etapa 2: enviar logs na mesma conversa]
  G --> H[Registrar vereditos revisados e justificativas]
  H --> I[Verificar evidências diretamente no artefato]
  I --> J{Há outra configuração ou réplica?}
  J -->|Sim| D
  J -->|Não| K[Comparar T7 e pares intramodelo; analisar os três provedores]
  K --> L[Analisar divergências, limitações e robustez]
  L --> M[Relatório e conclusão sustentados por resultados reais]
```