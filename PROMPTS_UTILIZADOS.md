# Prompts padronizados para coleta

**Estado:** preparados nesta revisão; ainda não aplicados às três LLMs. Os prompts históricos permanecem no histórico Git. Não apresentar estes textos como transcrições antigas.

## Materiais comuns

Anexar a íntegra de `evidencias/INSTRUCOES_SBRC2026.txt`, o artigo, o README, o código/configuração do commit `949f83c6db86d682240b7a61d1d2d406609413b6` e um manifesto de arquivos. Se o material não couber, fornecer o mesmo conjunto particionado a todos e registrar o procedimento. Um link inacessível não equivale a instrução recebida. Não revelar os selos oficiais antes dos julgamentos para reduzir ancoragem; compará-los depois.

## Prompt 1 — avaliação analítica

Avalie o artefato Selection Agent/K-Agent, SBRC 2026, no commit informado, usando exclusivamente as instruções oficiais anexadas da mesma edição. Para F e R, apresente: requisito, evidência com arquivo/seção/linha e commit, evidência faltante e recomendação analítica justificada. Diferencie expectativa documental de comprovação por execução. Não crie a categoria oficial “Parcial”. Não afirme ter executado código. Declare materiais inacessíveis. F exige observar algumas funcionalidades em execução; R exige reproduzir as principais reivindicações. Liste os comandos e condições necessários para verificar seu parecer. Use o mesmo escopo e materiais fornecidos, sem consultar a decisão oficial nesta etapa. Produza justificativa técnica verificável, sem inventar saídas ou resultados.

## Prompt 2 — execução ou uso e revisão do parecer

Mantendo o commit, as regras e o escopo do Prompt 1, conduza a instalação e a execução seguindo o README. Se possuir terminal, execute; se não possuir, apresente os comandos para o aluno executar e aguarde as saídas reais. Registre explicitamente quem operou os comandos. Colete ambiente, configuração efetiva, stdout, stderr, códigos de saída e arquivos gerados. Teste o mínimo e, quando possível, as principais reivindicações. Documente bloqueios em vez de simular sucesso. Para cada selo F/R, confronte o requisito oficial com a evidência obtida e confirme ou revise o parecer analítico. Explique se a observação é erro do artefato, inadequação do ambiente ou evidência inconclusiva. Identifique os resultados que não foram reproduzidos. Não trate uma análise de logs recebidos como execução própria. Ao final, faça uma tabela com F/R antes, F/R depois, evidências e justificativa da mudança.

## Registro obrigatório por sessão

Provedor; produto; nome exato do modelo exibido; data/hora; configurações disponíveis; materiais e hashes; prompt enviado; resposta integral; comandos; operador; logs; ambiente; configuração; métricas e conclusão. Registrar “não exposto pela interface” quando um parâmetro realmente não estiver disponível. Não adivinhar versão.
