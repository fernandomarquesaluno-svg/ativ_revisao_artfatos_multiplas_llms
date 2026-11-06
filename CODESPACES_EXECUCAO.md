# Executar o Selection Agent sem instalar Ubuntu — GitHub Codespaces

Esta configuração foi preparada no repositório da **Atividade 7** para abrir um ambiente baseado em **Ubuntu 22.04 (Jammy)** no navegador, instalar o projeto dos autores no commit fixado e capturar evidências de **novas** tentativas de execução.

## 1. Abrir o Codespace

**[Abrir Codespaces para a Atividade 7](https://codespaces.new/fernandomarquesaluno-svg/ativ_revisao_artfatos_multiplas_llms)**

No GitHub, faça login com o usuário `fernandomarquesaluno-svg`, selecione a configuração padrão `Atividade 7 - K-Agent (Ubuntu 22.04)` e clique em **Create codespace**. Se houver opção de máquina, prefira **4 núcleos e pelo menos 8 GB RAM**, sujeito ao saldo e à cobrança do GitHub. É necessária sua ação na interface para autorizar a criação do ambiente; essa etapa **não foi executada pelo assistente**.

## 2. Um comando no terminal online

Quando o editor VS Code no navegador abrir, selecione **Terminal > New Terminal** e execute:

```bash
bash scripts/codespaces/run_tests.sh
```

O script:
1. Registra hora, kernel, CPU/memória e espaço livre;
2. Obtém `rafaeloj/sbrc2026` no commit `949f83c6db86d682240b7a61d1d2d406609413b6`;
3. Instala Python 3.10, dependências do projeto em `venv` e guarda `pip freeze`;
4. Ajusta o TOML para **CPU, 5 clientes, uma rodada**, executa Random e registra `random.log` e o código de saída;
5. Instala/inicia Ollama, tenta obter `qwen3:0.6b` e registra seu estado;
6. Se Ollama funcionar, executa **K-Agent reduzido (uma rodada)**, gerando `kagent_1rodada.log` e código de saída;
7. Cria um pacote `evidencias_codespaces_<data>.tar.gz`, inclusive quando algum passo falhar.

O script **não executa automaticamente as 50 rodadas**, e o teste reduzido **não comprova a reprodutibilidade das reivindicações do artigo**. Os códigos de saída devem ser interpretados junto aos logs.

## 3. Baixar e entregar os novos logs

No Explorer do VS Code web, localize o arquivo `evidencias_codespaces_<data>.tar.gz` na raiz do repositório. Clique com o botão direito e use **Download**, então anexe esse arquivo na conversa.

Os registros detalhados ficam também em `evidencias/codespaces/<data>/` dentro do Codespace, com as versões e configurações usadas. Não renomeie nem apresente esses registros como logs antigos do Ubuntu perdido; são uma **nova tentativa**, que pode ter resultados diferentes.

**Quando terminar, pare o Codespace** para evitar consumo de cotas ou cobranças adicionais.

## Limitações e observações

- O procedimento foi escrito e publicado, mas **a execução no Codespaces ainda não foi realizada nem validada**. Instalação de dependências, disponibilidade de CPU/RAM e download de Ollama/modelo podem falhar.
- O sucesso do método Random mostra apenas uma funcionalidade básica. O sucesso do teste K-Agent reduzido demonstra integração inicial, não a reprodução das métricas de tráfego (44,4%–59%).
- O experimento principal exige 25 clientes, 50 rodadas e comparadores apropriados, mais configuração e tempo de cálculo. Não o iniciar automaticamente para preservar a cota da conta.
- Caso a criação de Codespaces esteja indisponível na sua conta ou organização, a execução nesse ambiente não poderá começar; isso não é prova de falha do artefato.
