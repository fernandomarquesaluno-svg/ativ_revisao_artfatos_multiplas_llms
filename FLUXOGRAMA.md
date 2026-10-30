# Fluxograma — protocolo de avaliação da Atividade 7

> Fluxograma do **procedimento exigido**. As etapas representadas não constituem, por si só, comprovação de sua execução.

```mermaid
flowchart TD
 A["Selecionar artefato SBRC/SBSeg"] --> B["Identificar edição e selos oficiais F e R"]
 B --> C["Reunir instruções oficiais e documentação"]
 C --> D["Definir prompts equivalentes"]
 D --> E["Aplicar a pelo menos 3 LLMs / 3 provedores"]
 E --> F["Etapa 1: avaliação documental F e R"]
 F --> G["Registrar respostas e evidências citadas"]
 G --> H["Verificar evidências no repositório"]
 H --> I["Executar o artefato / reunir logs e configurações"]
 I --> J["Etapa 2: reavaliar F e R por LLM"]
 J --> K["Comparar etapa 1, etapa 2 e selos oficiais"]
 K --> L["Analisar concordâncias, divergências e limitações"]
 L --> M["Conclusão e publicação das evidências"]
```

### Evidência já apresentada
- Método `random`: log de simulação concluída.
- Método `k-agent`: tentativa interrompida por `ConnectionRefusedError` na conexão com Ollama.

**Importante:** uma falha de conexão não permite concluir que o K-Agent tenha defeito lógico; tampouco constitui reprodução bem-sucedida do experimento principal.
