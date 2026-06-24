-- ============================================================
-- TODOS PROTEGIDOS UNIVERSITY — Pré-treinamento "PRIMEIROS PASSOS"
-- "Todos Protegidos, seja bem-vindo"
--
-- Módulos em ALGARISMOS ROMANOS (I a VI), posicionados ACIMA dos módulos
-- aprofundados (1 a 7) na trilha. Os módulos aprofundados ficam como estão
-- (apenas a ordem é empurrada para baixo, para os novos entrarem em cima).
--
-- Base: índice da apostila + manual de vendas (WhatsApp) + abordagem externa.
-- A "palavra/visão do presidente" NÃO entra aqui (fica separada).
-- Enquadramento: Todos Protegidos é associação REGULAMENTADA pela SUSEP.
--
-- Rode no SQL Editor depois de conteudo/renumerar. Idempotente.
-- ============================================================
do $$
declare t uuid; m uuid;
begin
  select id into t from public.tenants where slug = 'matriz';
  if t is null then raise notice 'Tenant "matriz" nao encontrado.'; return; end if;

  -- Empurra os módulos numerados (aprofundados 1–7 + Diretrizes 8) para baixo,
  -- para os módulos romanos do Primeiros Passos aparecerem acima. (Idempotente.)
  update public.modulos
     set ordem = 100 + (substring(titulo from '^Módulo ([0-9]+)'))::int
   where tenant_id = t and titulo ~ '^Módulo [0-9]';

  -- =========================================================
  -- MÓDULO I — Boas-vindas e o mercado
  -- =========================================================
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo I · Boas-vindas e o mercado';
  if m is null then
    insert into public.modulos (tenant_id, titulo, subtitulo, ordem)
      values (t, 'Módulo I · Boas-vindas e o mercado', 'Primeiros Passos · Todos Protegidos, seja bem-vindo', 1) returning id into m;
    insert into public.itens (tenant_id, modulo_id, tipo, titulo, meta, descricao, ordem) values
    (t, m, 'info', 'Aula I.1 — Seja bem-vindo à Todos Protegidos', 'Primeiros Passos · Leitura',
'Seja muito bem-vindo(a) à Todos Protegidos!

Você está começando uma jornada em uma empresa que nasceu para tornar a proteção veicular acessível, justa e sem burocracia. Este pré-treinamento, o "Primeiros Passos", foi feito para te dar a base completa antes de você ir para a rua e para os atendimentos: você vai entender a empresa, o produto, as ferramentas que usamos no dia a dia (SGA, Power CRM e Visto) e as técnicas de venda.

COMO ESTUDAR
- Leia cada módulo na ordem. O conteúdo é para estudo por leitura; os vídeos, quando houver, são complemento prático.
- Depois do Primeiros Passos, avance para os módulos aprofundados (1 a 7), que destrincham cada etapa da venda.
- Anote suas dúvidas e leve para o seu líder.

O QUE VOCÊ VAI DOMINAR AO FINAL
1. A história e a cultura da Todos Protegidos.
2. O produto: o que é proteção veicular, coberturas, FIPE e a diferença para o seguro.
3. As ferramentas: SGA, Power CRM e app Visto, passo a passo.
4. Técnicas de venda e abordagem (rua e WhatsApp).

Bons estudos — e bem-vindo(a) ao time!', 1),

    (t, m, 'info', 'Aula I.2 — Como surgiu a Todos Protegidos e o Grupo Cartão de TODOS', 'Primeiros Passos · Leitura',
'A Todos Protegidos nasceu em 15 de janeiro de 2025, como uma unidade de negócio do Grupo Cartão de TODOS.

O CARTÃO DE TODOS
É uma das maiores redes de inclusão social do Brasil: levou acesso a saúde, educação e lazer a preços populares, com presença em todo o território nacional. A Todos Protegidos trouxe essa mesma mentalidade — inclusão, acessibilidade e cuidado com as famílias — para a proteção veicular.

O QUE ISSO SIGNIFICA NA PRÁTICA
- Pertencer a um grupo grande e consolidado transmite CONFIANÇA ao cliente (use isso como prova social).
- O modelo coloca o associado no centro: valores acessíveis, atendimento humanizado e compromisso real com o bem protegido.
- Fazemos parte de um ecossistema (NU Company / Holding) que reúne dezenas de empresas.

PARA A VENDA
Quando o cliente desconfia ("essa empresa é confiável?"), lembre: somos do Grupo Cartão de TODOS, com sede em Goiânia-GO e expansão em andamento (Valparaíso-GO). A história completa da empresa está na página INSTITUCIONAL — leia com atenção, ela te dá argumentos.', 2),

    (t, m, 'info', 'Aula I.3 — O mercado de proteção veicular', 'Primeiros Passos · Leitura',
'A proteção veicular cresceu muito no Brasil porque resolve uma dor real: muita gente precisa proteger o carro ou a moto, mas o seguro tradicional é caro ou recusa o perfil.

POR QUE O MERCADO É GRANDE
- Frota enorme e em crescimento (carros e motos), inclusive motoristas de aplicativo e profissionais autônomos.
- Muitos motoristas ficam SEM qualquer proteção por causa do preço ou da recusa do seguro — esse é o nosso público.
- A proteção veicular oferece custo acessível e processo simples, ampliando o acesso.

QUEM É O NOSSO CLIENTE
- Quem usa o veículo para trabalhar (app, entregas, autônomos): a maior dor é ficar sem renda.
- Famílias que dependem do carro no dia a dia.
- Quem foi recusado ou achou caro no seguro tradicional.

O SEU PAPEL
O consultor é a ponte entre essa necessidade e a solução. Quanto mais você entende o mercado e o cliente, mais natural e consultiva fica a venda. Nos próximos módulos você vai conhecer o produto a fundo e as ferramentas para atender com eficiência.', 3);
  end if;

  -- =========================================================
  -- MÓDULO II — Entendendo o produto
  -- =========================================================
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo II · Entendendo o produto';
  if m is null then
    insert into public.modulos (tenant_id, titulo, subtitulo, ordem)
      values (t, 'Módulo II · Entendendo o produto', 'Primeiros Passos · O que vendemos', 2) returning id into m;
    insert into public.itens (tenant_id, modulo_id, tipo, titulo, meta, descricao, ordem) values
    (t, m, 'info', 'Aula II.1 — O que é proteção veicular e o que é associação', 'Primeiros Passos · Leitura',
'PROTEÇÃO VEICULAR
É um sistema de ajuda mútua entre pessoas: os associados contribuem mensalmente para um fundo comum e, quando um deles sofre um prejuízo coberto (roubo, furto, colisão, perda total), esse fundo cobre o prejuízo. É o princípio "um por todos, todos por um" aplicado ao veículo.

O QUE É UMA ASSOCIAÇÃO
A Todos Protegidos é uma ASSOCIAÇÃO de proteção veicular: os associados se unem em torno de um estatuto e de um rateio de custos. O dinheiro é do grupo, administrado pela associação para proteger todos — não há a lógica de lucro de uma seguradora sobre o prêmio.

PONTO FORTE PARA A VENDA
Mesmo sendo uma associação, a Todos Protegidos é REGULAMENTADA e FISCALIZADA pela SUSEP (veja a próxima aula). Ou seja: você tem o melhor dos dois mundos — o custo acessível e a proximidade de uma associação, com a segurança de uma empresa supervisionada pelo órgão oficial.

RESUMO
Associação + rateio + regulamentação pela SUSEP = proteção acessível e segura.', 1),

    (t, m, 'info', 'Aula II.2 — Regulamentação: como funciona a SUSEP', 'Primeiros Passos · Leitura',
'A SUSEP (Superintendência de Seguros Privados) é o órgão oficial que supervisiona o setor.

O QUE VOCÊ PRECISA SABER E SABER EXPLICAR
- A Todos Protegidos é uma associação de proteção veicular REGULAMENTADA e FISCALIZADA pela SUSEP.
- Isso significa que seguimos regras oficiais e somos supervisionados — o que traz SEGURANÇA, CREDIBILIDADE e GARANTIA ao associado.
- É um diferencial importante: muitas associações no mercado não têm essa regulamentação. A nossa tem. Use isso a seu favor.

COMO USAR NA OBJEÇÃO DE CONFIANÇA
Quando o cliente perguntar "isso é confiável? tem garantia?", responda com firmeza:
"A Todos Protegidos é uma associação regulamentada e fiscalizada pela SUSEP, do Grupo Cartão de TODOS. Você tem o custo acessível de uma associação com a segurança de uma empresa supervisionada pelo órgão oficial. Posso te mostrar tudo antes de você decidir."

TRANSPARÊNCIA SEMPRE
Explique cobertura, carência e o que está incluso com clareza, por escrito. Transparência evita cancelamento e fortalece a sua reputação.', 2),

    (t, m, 'info', 'Aula II.3 — Proteção veicular x seguradoras', 'Primeiros Passos · Leitura',
'Saber diferenciar (sem atacar a concorrência) é essencial.

PROTEÇÃO VEICULAR (TODOS PROTEGIDOS)
- Associação regulamentada e fiscalizada pela SUSEP.
- Funciona por rateio entre associados.
- Aceitação mais ampla e processo de adesão mais simples e ágil.
- Custo mensal geralmente mais acessível.
- Assistência 24h, cobertura a terceiros e indenização pela tabela FIPE.

SEGURO TRADICIONAL
- Vendido por seguradoras, com apólice e análise de perfil/score (pode recusar).
- Custo geralmente mais alto.
- Mais burocracia na contratação.

COMO POSICIONAR (sem criticar)
"As duas opções protegem; mudam o jeito e o custo. A proteção veicular costuma ser mais acessível e mais simples de aderir, e a nossa ainda é regulamentada pela SUSEP. Posso te mostrar lado a lado para você comparar e decidir."

REGRA: nunca fale mal da concorrência. Mostre VALOR, deixe o cliente comparar e decidir.', 3),

    (t, m, 'info', 'Aula II.4 — Nossos benefícios (o produto)', 'Primeiros Passos · Leitura',
'O que o associado da Todos Protegidos tem:

COBERTURAS E SERVIÇOS
- Proteção contra roubo e furto
- Indenização por perda total
- Proteção contra incêndios decorrentes de colisão
- Cobertura de vidros
- Danos a terceiros
- Assistência 24h com guincho
- Rede de oficinas parceiras
- Fenômenos da natureza (enchente, granizo, queda de árvore)
- Chaveiro
- Hotelaria

COMO APRESENTAR (traduzir em benefício)
Não liste cláusula: mostre o que o cliente ganha na prática.
- "Se roubarem o carro, você é indenizado pela FIPE — não fica no prejuízo."
- "Bateu e deu perda total? Você recebe e volta a se organizar."
- "Pane, pneu furado, chave trancada? Assistência 24h e guincho resolvem na hora."

DICA: descubra o USO do veículo antes de oferecer (trabalho x família x lazer) e conecte o benefício à dor do cliente. Carro e moto têm dores diferentes — para quem trabalha com a moto, a dor é ficar sem renda.', 4),

    (t, m, 'info', 'Aula II.5 — Tabela FIPE e concorrentes', 'Primeiros Passos · Leitura',
'A TABELA FIPE
É a referência de preço médio dos veículos no Brasil. Quando dizemos "indenização de 100% da FIPE", o associado recebe, na perda total, o valor de mercado do carro dele — não um valor depreciado.

POR QUE A FIPE É UMA FERRAMENTA DE VENDA
Citar o número real ancora o valor: "Seu carro vale cerca de R$ X na FIPE. Repor isso do zero seria um baque. A proteção custa o equivalente a centavos por dia desse valor." O cliente passa a comparar a mensalidade com o tamanho do prejuízo evitado, e não com "zero".

CONCORRENTES
Existem muitas associações e seguradoras no mercado. Nossos diferenciais:
- Regulamentação pela SUSEP (nem toda associação tem).
- Força e confiança do Grupo Cartão de TODOS.
- Atendimento humanizado e custo acessível.

POSTURA: conheça os diferenciais, mas nunca fale mal de ninguém. Venda o nosso valor.', 5);
  end if;

  -- =========================================================
  -- MÓDULO III — As ferramentas do dia a dia (SGA / Power CRM / Visto)
  -- =========================================================
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo III · As ferramentas do dia a dia';
  if m is null then
    insert into public.modulos (tenant_id, titulo, subtitulo, ordem)
      values (t, 'Módulo III · As ferramentas do dia a dia', 'Primeiros Passos · SGA, Power CRM e Visto', 3) returning id into m;
    insert into public.itens (tenant_id, modulo_id, tipo, titulo, meta, descricao, ordem) values
    (t, m, 'info', 'Aula III.1 — SGA (Sistema de Gestão de Associados)', 'Primeiros Passos · Ferramentas',
'O QUE É
O SGA é o sistema de GESTÃO DO ASSOCIADO — onde ficam os dados de quem já é cliente: cadastro, mensalidades/boletos, situação do plano e eventos (sinistros). Enquanto o Power CRM cuida da VENDA (lead até contrato), o SGA cuida da VIDA do associado depois que ele entra.

O QUE VOCÊ FAZ NO SGA (no dia a dia)
1. Localizar o associado (por nome, CPF ou placa).
2. Consultar a situação do plano (ativo, em atraso, suspenso).
3. Ver mensalidades e emitir 2ª via de boleto quando o associado pedir.
4. Conferir/atualizar dados cadastrais.
5. Consultar/abrir um evento (sinistro) e acompanhar o andamento — direcionando o associado ao Setor de Eventos quando for o caso.

REGRA DE OURO DE ATENDIMENTO (do Manual do Consultor)
- Assistência 24h e abertura de sinistro: oriente o associado a ligar para o 0800.
- Informações de eventos já registrados (colisão, roubo, furto, indenização): encaminhe para o Setor de Eventos.
- Não passe informação sem validar com a área responsável.

OBS.: as telas e menus exatos dependem da sua versão/acesso do SGA — peça ao seu líder um acesso de teste e pratique localizar um associado e emitir uma 2ª via.', 1),

    (t, m, 'info', 'Aula III.2 — Power CRM: cotação, cadastro, vistoria e contrato', 'Primeiros Passos · Ferramentas',
'O Power CRM é o sistema da VENDA: do lead até o contrato. É onde você passa a maior parte do tempo. Veja o fluxo completo, passo a passo.

1) COTAÇÃO
Há duas formas de cotar:
- POR PLACA: digite a placa e o sistema traz os dados do veículo automaticamente (jeito mais rápido).
- POR ANO E MODELO: quando não tiver a placa, selecione marca, modelo e ano manualmente.
Gere a cotação e envie ao cliente (o sistema permite mandar pelo WhatsApp).

2) ACEITE DA COTAÇÃO
O aceite pode acontecer de três formas: pelo próprio CLIENTE (link), pelo SISTEMA ou pelo CONSULTOR registrando o aceite. Confirme o plano e o valor antes de seguir.

3) CADASTRO DO CLIENTE (passo a passo)
Com a cotação aceita, faça o cadastro: dados pessoais (nome, CPF, contato, endereço), dados do veículo (placa, modelo, ano) e a forma de pagamento. Confira tudo — um erro de digitação trava as etapas seguintes.

4) LIBERAÇÃO DA VISTORIA
No Power CRM você LIBERA a vistoria: o sistema gera um LINK e um CÓDIGO que serão usados no app Visto (próxima aula). Envie o link/código ao cliente (ou faça você mesmo, presencialmente).

5) ENVIO DO CONTRATO / ACEITE DO CLIENTE
Gere o contrato de adesão e envie ao cliente para aceite/assinatura. Confirme o aceite no sistema. Pronto: a adesão segue para ativação.

DICA: registre TUDO no Power CRM e mantenha cada lead com um próximo passo definido. A maior parte das vendas acontece no follow-up.
OBS.: os nomes exatos dos botões podem variar conforme a sua conta — pratique com um líder ao lado nas primeiras vezes.', 2),

    (t, m, 'info', 'Aula III.3 — Visto: como fazer a vistoria', 'Primeiros Passos · Ferramentas',
'A vistoria é feita no app VISTO, usando o link/código gerado no Power CRM na etapa de liberação.

PASSO A PASSO
1. Abra o app Visto e entre com o LINK/CÓDIGO da vistoria (gerado no Power CRM).
2. Tire as fotos solicitadas, com boa luz e foco:
   - Frente, traseira e as duas laterais do veículo
   - Painel com o hodômetro (quilometragem) visível
   - Número do chassi
   - Pneus e estado geral
3. Envie o documento do veículo conforme pedido (em geral FOTO/JPG do CRLV — PDF normalmente não é aceito).
4. Confira tudo e ENVIE a vistoria.

DICAS DE QUALIDADE (evitam recusa e retrabalho)
- Placa sempre legível na foto.
- Sem reflexos, sem dedo na lente, sem foto tremida.
- Registre avarias já existentes (riscos, amassados) — protege o associado e a associação.

EXPLIQUE A CARÊNCIA AO CLIENTE neste momento, para alinhar expectativa.
Vistoria bem feita = ativação rápida = associado satisfeito. Vistoria malfeita = atraso e desconfiança logo no começo.', 3),

    (t, m, 'info', 'Aula III.4 — Ferramentas de apoio: Busca Placa e CRLV', 'Primeiros Passos · Ferramentas',
'Duas ferramentas ajudam a agilizar a cotação e o cadastro:

BUSCA PLACA
Serve para consultar os dados do veículo a partir da placa (marca, modelo, ano). Útil quando o cliente passa só a placa — você já adianta a cotação no Power CRM sem ficar perguntando tudo.

CRLV ATUALIZADO (documento do veículo)
Para conferir/obter o CRLV atualizado do cliente:
- Pelo gov.br (portal/app oficial) ou pelo site do DETRAN do estado correspondente.
- O CRLV confirma se o documento está em dia e os dados do veículo/proprietário — importante para a vistoria e o contrato.

BOAS PRÁTICAS
- Confirme sempre se os dados do veículo batem (placa, modelo, ano) entre a Busca Placa, o CRLV e o que o cliente informou.
- Documento do cliente e do veículo em foto nítida agiliza tudo.
OBS.: confirme com seu líder quais ferramentas de Busca Placa a associação utiliza e como acessá-las.', 4);
  end if;

  -- =========================================================
  -- MÓDULO IV — Técnicas de vendas
  -- =========================================================
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo IV · Técnicas de vendas';
  if m is null then
    insert into public.modulos (tenant_id, titulo, subtitulo, ordem)
      values (t, 'Módulo IV · Técnicas de vendas', 'Primeiros Passos · Como conduzir a venda', 4) returning id into m;
    insert into public.itens (tenant_id, modulo_id, tipo, titulo, meta, descricao, ordem) values
    (t, m, 'info', 'Aula IV.1 — AIDA e SPIN aplicados à proteção veicular', 'Primeiros Passos · Vendas',
'Duas técnicas formam a base da abordagem.

AIDA (rápida, ótima para abordagem)
- ATENÇÃO: "Boa tarde! Seu veículo já possui alguma proteção contra colisão, roubo ou furto?"
- INTERESSE: "Hoje muitos proprietários estão economizando bastante em relação ao seguro tradicional."
- DESEJO: "Além de roubo e colisão, você conta com guincho 24h e assistência."
- AÇÃO: "Posso fazer uma simulação rápida, sem compromisso?"

SPIN (consultiva, leva o cliente a concluir que precisa)
- SITUAÇÃO: "Qual veículo você tem? Usa para trabalho ou lazer? Tem proteção hoje?"
- PROBLEMA: "Já teve prejuízo com veículo? Conhece alguém que teve o carro roubado? Já deixou de fazer seguro pelo valor?"
- IMPLICAÇÃO: "Se seu carro fosse roubado hoje, qual seria o prejuízo? Conseguiria comprar outro na hora?"
- NECESSIDADE: "Então faz sentido ter uma proteção que cabe no bolso e evita esse risco?"

REGRA: a pergunta vende mais que o discurso. Quem pergunta bem, conduz a venda.', 1),

    (t, m, 'info', 'Aula IV.2 — Dor financeira, prova social, segurança e comparação', 'Primeiros Passos · Vendas',
'DOR FINANCEIRA
Faça o cliente sentir o tamanho do prejuízo: "Seu veículo vale cerca de R$ 50.000. Se houver perda total amanhã, quanto tempo levaria para recuperar esse valor?" A dor da perda costuma ser maior que o custo da proteção.

PROVA SOCIAL
As pessoas confiam na experiência de outras: "Temos muitos associados ativos." "Recentemente indenizamos um associado aqui da região." "Vários motoristas de app e autônomos usam a nossa proteção." (Nunca invente números nem depoimentos.)

GATILHO DA SEGURANÇA
O cliente compra tranquilidade. Troque "vendemos proteção veicular" por "ajudamos famílias a evitar prejuízos por acidentes e roubos".

COMPARAÇÃO (sem falar mal de ninguém)
Seguro: análise de perfil, mais burocracia, custo geralmente maior.
Proteção veicular: menos burocracia, processo simples, melhor custo-benefício — e regulamentada pela SUSEP.', 2),

    (t, m, 'info', 'Aula IV.3 — Escuta ativa e fechamento', 'Primeiros Passos · Vendas',
'ESCUTA ATIVA
Regra de ouro: o cliente fala 70%, o consultor 30%. Evite falar demais; faça perguntas. Quem faz perguntas controla a venda. Use as palavras do próprio cliente na hora de apresentar a solução.

FECHAMENTO PRESUNTIVO
Assuma que o cliente já decidiu. Em vez de "você quer fechar?", pergunte:
- "Qual a melhor forma de pagamento para você?"
- "Podemos iniciar sua proteção ainda hoje?"

FECHAMENTO POR ALTERNATIVAS
Nunca deixe a resposta ser só "não". Em vez de "vai contratar?", use:
- "Prefere iniciar no Pix ou no cartão?"

MEDO DA PERDA (com equilíbrio)
"Ninguém espera sofrer um acidente. O problema é que, quando acontece, normalmente já é tarde para buscar proteção."

PEÇA A VENDA com naturalidade. Quem não pede, não fecha.', 3),

    (t, m, 'info', 'Aula IV.4 — Roteiro completo, os 5 erros e a regra de ouro', 'Primeiros Passos · Vendas',
'ROTEIRO DE ABORDAGEM COMPLETO
- Abertura: "Boa tarde! Meu nome é ___, da Todos Protegidos. Posso fazer uma pergunta rápida?"
- Investigação: "Seu veículo possui alguma proteção atualmente?"
- Dor: "Se acontecesse um roubo ou perda total hoje, qual seria o impacto financeiro?"
- Apresentação: "É justamente para evitar esse prejuízo que nossos associados contam com proteção contra colisão, roubo, furto, assistência 24h e guincho."
- Prova social: "Hoje já protegemos muitos veículos aqui na região."
- Fechamento: "Posso fazer uma simulação gratuita agora?"

OS 5 ERROS QUE MAIS DERRUBAM VENDAS
1. Falar de preço antes de gerar valor.
2. Falar demais e ouvir pouco.
3. Discutir com o cliente.
4. Criticar seguradoras.
5. Não pedir o fechamento.

REGRA DE OURO
O cliente não compra "proteção veicular". Ele compra tranquilidade, segurança financeira e proteção do patrimônio. Quando o consultor entende isso, a conversão sobe.

MANTRA DA EQUIPE: "Não vendemos proteção veicular. Protegemos sonhos de trabalhadores, o patrimônio e a tranquilidade das famílias."', 4);
  end if;

  -- =========================================================
  -- MÓDULO V — Abordagem externa (rua)
  -- =========================================================
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo V · Abordagem externa';
  if m is null then
    insert into public.modulos (tenant_id, titulo, subtitulo, ordem)
      values (t, 'Módulo V · Abordagem externa', 'Primeiros Passos · Captação na rua', 5) returning id into m;
    insert into public.itens (tenant_id, modulo_id, tipo, titulo, meta, descricao, ordem) values
    (t, m, 'info', 'Aula V.1 — Semáforos e estacionamentos', 'Primeiros Passos · Rua',
'SEMÁFOROS
O semáforo NÃO é lugar de vender — é lugar de gerar curiosidade e pegar o contato.
Abordagem de 15 segundos: "Boa tarde! Você conhece a proteção veicular da Todos Protegidos? Estamos fazendo simulações gratuitas para proprietários da região."
Não faça: falar de preço, insistir, bloquear o veículo, explicar tudo.
Faça: entregar material, coletar o WhatsApp, agendar retorno.

ESTACIONAMENTOS (melhor para conversão — o cliente está parado)
Observe o veículo (estado, ano, conservação, acessórios) e use a valorização:
"Parabéns pelo veículo, muito bem conservado. Você usa ele todo dia? Hoje ele já tem alguma proteção?"
A conversa flui natural. Elogio sincero abre portas.', 1),

    (t, m, 'info', 'Aula V.2 — Postos e lava-jatos', 'Primeiros Passos · Rua',
'POSTOS DE COMBUSTÍVEL (ótimo para relacionamento)
"Boa tarde! Estamos com uma campanha para motoristas da região. Posso fazer uma simulação rápida da proteção do seu veículo?"
Gancho: "Você abastece toda semana. Se acontecer um imprevisto, quanto tempo levaria para recuperar o valor desse veículo?"

LAVA-JATOS (quem cuida do carro valoriza o patrimônio)
"Vejo que você cuida muito bem do seu veículo. Hoje ele já tem proteção contra colisão e roubo?"
Transição: "Quem investe no cuidado estético costuma proteger também o patrimônio."

REGRA: nesses pontos o objetivo principal é captar contato e iniciar a conversa; a venda evolui no follow-up.', 2),

    (t, m, 'info', 'Aula V.3 — Parcerias e indicações', 'Primeiros Passos · Rua',
'PARCERIAS COM OFICINAS (canal estratégico)
Benefícios para a oficina: receita extra, fidelização e diferencial. Proposta: "Toda indicação que virar adesão gera uma bonificação para a oficina." Material: banner, cartão, QR Code, folder.

PARCERIAS COM COMÉRCIOS
Locais ideais: auto elétricas, auto centers, borracharias, lojas de som, lojas de acessórios, despachantes.
Discurso: "Quero criar uma parceria sem custo para sua empresa. Sempre que um cliente precisar de proteção veicular, atendemos com prioridade."

INDICAÇÕES (a forma mais barata de vender)
Regra: todo cliente novo deve gerar no mínimo 3 indicações.
Pergunta: "Quem são três pessoas que você conhece que têm veículo parecido com o seu?"
Melhor momento: logo após a adesão, com o cliente satisfeito.
Pós-venda (após 7 dias): "Olá! Obrigado pela confiança na Todos Protegidos. Aproveitando, conhece alguém que também possa se beneficiar da nossa proteção?"', 3),

    (t, m, 'info', 'Aula V.4 — Gatilhos mentais e metas diárias', 'Primeiros Passos · Rua',
'GATILHOS MENTAIS MAIS EFICAZES
- Segurança: "Proteja seu patrimônio."
- Tranquilidade: "Durma tranquilo sabendo que seu veículo está protegido."
- Prova social: "Muitos associados já confiam na Todos Protegidos."
- Autoridade: "Nossa equipe tem experiência no mercado de proteção veicular."
- Urgência: "Quanto antes a proteção estiver ativa, antes você está protegido."

META DIÁRIA DO CONSULTOR (referência)
- 50 abordagens por dia
- 15 contatos coletados
- 5 simulações
- 2 propostas
- 1 adesão

A REGRA DOS CAMPEÕES
A cada 100 abordagens: ~40 demonstram interesse, ~20 pedem simulação, ~10 recebem proposta, ~3 a 5 fecham. O segredo não é convencer todo mundo — é falar com MAIS pessoas todos os dias, com um processo consistente e profissional.', 4);
  end if;

  -- =========================================================
  -- MÓDULO VI — Vendas pelo WhatsApp
  -- =========================================================
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo VI · Vendas pelo WhatsApp';
  if m is null then
    insert into public.modulos (tenant_id, titulo, subtitulo, ordem)
      values (t, 'Módulo VI · Vendas pelo WhatsApp', 'Primeiros Passos · Atendimento e fechamento online', 6) returning id into m;
    insert into public.itens (tenant_id, modulo_id, tipo, titulo, meta, descricao, ordem) values
    (t, m, 'info', 'Aula VI.1 — Visão geral e os 2 tipos de lead', 'Primeiros Passos · WhatsApp',
'O WhatsApp é o principal canal de atendimento. As etapas do funil são sempre: Abertura, Diagnóstico, Apresentação, Objeções, Fechamento, Pós-venda. O que muda é o tom, conforme a origem do lead.

OS 2 TIPOS DE LEAD
- LEAD DE IMPULSIONAMENTO (anúncio): a pessoa clicou num anúncio e chamou. Tem interesse inicial, mas pouca confiança. É um lead frio-morno, curioso e cheio de pé atrás.
- LEAD DE CONTATO ATIVO (prospecção): você busca o cliente (indicação, base própria, pontos de fluxo). A pessoa não estava pensando em comprar — você gera o interesse do zero, e a tolerância à insistência é menor.

INDICADORES (metas de referência)
- 1ª resposta a lead de anúncio: até 5 minutos.
- 1ª resposta a contato ativo: até 24h.
- Conversão proposta -> fechamento: acima de 25%.
- Follow-ups antes de desistir: no mínimo 5 tentativas em 10 dias.

REGRAS INEGOCIÁVEIS
- Velocidade: anúncio que não recebe resposta rápido esfria e vai pro concorrente. Notificações sempre ativas.
- Áudio com moderação (curto, até 30s, em momento-chave). Texto como padrão.
- Sempre confirmar por ESCRITO: valor, carência, o que está incluso.', 1),

    (t, m, 'info', 'Aula VI.2 — Funil A: lead de anúncio (scripts)', 'Primeiros Passos · WhatsApp',
'Esse lead está pesquisando preço e ainda não confia. Objetivo: responder rápido, qualificar e gerar confiança antes de mandar preço.

ABERTURA (primeiros 60 segundos)
"Oi, [Nome]! Tudo bem? Aqui é o(a) [Vendedor] da Todos Protegidos. Vi que você se interessou pela proteção veicular. Pra eu já te mandar um valor certinho, me conta: qual o modelo e o ano do seu carro?"

DIAGNÓSTICO (poucas mensagens, sem interrogatório)
- Modelo, ano e cidade do veículo.
- Uso (particular, app, trabalho).
- Se já tem proteção/seguro hoje e por que está buscando.
- Se é urgência (já bateu/roubaram) ou planejamento.

GERAÇÃO DE CONFIANÇA (antes do preço)
"Antes de te passar os valores, separei um print rápido de associados que já usaram a assistência este mês, pra você ver como funciona na prática." (Use prova real; nunca invente.)

APRESENTAÇÃO DA PROPOSTA (sempre por escrito)
- Resumo do plano: nome + valor mensal.
- O que está incluso (3 a 5 itens).
- Carência e participação: sempre informar.
- Próximo passo: "quer que eu já adiante seu cadastro?"', 2),

    (t, m, 'info', 'Aula VI.3 — Funil B: contato ativo e LGPD', 'Primeiros Passos · WhatsApp',
'Aqui você inicia a conversa. A 1ª mensagem precisa ser relevante e não invasiva — senão vira bloqueio ou denúncia.

ABERTURA POR INDICAÇÃO
"Oi, [Nome]! Aqui é o(a) [Vendedor], da Todos Protegidos. O [quem indicou] me passou seu contato porque comentou que você pensava em proteger o carro. Posso te explicar rapidinho como funciona?"

ABERTURA POR BASE PRÓPRIA / REATIVAÇÃO
"Oi, [Nome]! Aqui é o(a) [Vendedor] da Todos Protegidos. Vi que você já conversou com a gente sobre proteção veicular. Ainda está com o [modelo]? Surgiu uma condição que vale a pena te mostrar."

LGPD E REPUTAÇÃO (regras obrigatórias)
- Só aborde números de origem clara: indicação, base própria, formulário com consentimento, ou contato dado presencialmente. Nunca compre listas frias.
- Sempre dê uma saída fácil: "se não for o momento, é só me avisar que eu não te incomodo mais."
- Pedido de remoção da lista é atendido NA HORA, sem insistência. Ignorar gera denúncia, bloqueio do número e risco jurídico.

RITMO: aceite o "não agora" com tranquilidade e agende retorno. Insistência excessiva é a principal causa de denúncia.', 3),

    (t, m, 'info', 'Aula VI.4 — Fechamento, pós-venda e objeções', 'Primeiros Passos · WhatsApp',
'SINAIS DE QUE ESTÁ PRONTO PARA FECHAR
Pergunta forma de pagamento ou data de início; pede para reenviar o resumo "pra confirmar com o cônjuge"; pergunta quais documentos enviar; para de objetar e faz perguntas operacionais.

FECHAMENTO
"Perfeito, [Nome]! Pra eu gerar seu cadastro, preciso de 3 coisinhas: foto do documento, foto do CRLV do veículo e a forma de pagamento (Pix ou cartão). Pode me mandar?"
Confirme SEMPRE por escrito: valor, início/carência, coberturas e exclusões, participação, forma de cobrança, documentos recebidos, contrato de adesão enviado.

PÓS-VENDA (primeiras 48h)
Boas-vindas com número da adesão e canal de suporte; confirmar recebimento do boleto/débito; follow-up de satisfação em 7 dias. Pós-venda bem feito gera indicação.

QUEBRA DE OBJEÇÕES (treine até falar natural)
- "Isso é confiável?": "Somos uma associação regulamentada e fiscalizada pela SUSEP, do Grupo Cartão de TODOS. Te envio tudo antes de você decidir."
- "Tá caro / achei mais barato": "Antes de comparar só o valor, veja o que está incluso em cada plano — carência, participação e cobertura mudam o preço. Te mando lado a lado?"
- "Vou pensar": "Sem problema. Só pra eu te ajudar: ficou dúvida no valor, na cobertura ou no timing? Já te respondo enquanto você pensa."
- "Já tenho seguro/proteção": "Que ótimo que você já se protege! Muita gente compara na renovação. Quando vence o seu? Posso te lembrar para comparar sem compromisso."', 4);
  end if;

  raise notice 'Pre-treinamento Primeiros Passos (I a VI) criado acima dos modulos aprofundados.';
end $$;
