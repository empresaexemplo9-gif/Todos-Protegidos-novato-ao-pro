-- ============================================================
-- TODOS PROTEGIDOS — Correção: somos ASSOCIAÇÃO, regulamentada pela SUSEP
--
-- Corrige nos conteúdos JÁ GRAVADOS no banco a informação de que a
-- Todos Protegidos é uma associação de proteção veicular REGULAMENTADA e
-- FISCALIZADA pela SUSEP (antes alguns textos diziam que "não" era regulada).
--
-- Rode no SQL Editor (depois de conteudo / conteudo-aprofundado / apostila /
-- conteudo-web já terem sido rodados). Seguro rodar mais de uma vez:
-- o replace() só altera onde o texto antigo ainda existir.
-- ============================================================

-- ---- Aula 3.1 (texto aprofundado) ----
update public.itens set descricao = replace(descricao,
$o$Para vender com segurança, o consultor precisa primeiro entender em profundidade o que está vendendo. Proteção veicular não é seguro, e confundir os dois é o erro que mais derruba a confiança do cliente.$o$,
$n$Para vender com segurança, o consultor precisa primeiro entender em profundidade o que está vendendo. Saber explicar com precisão o que é a proteção veicular — uma associação regulamentada pela SUSEP — é o que mais constrói a confiança do cliente.$n$);

update public.itens set descricao = replace(descricao,
$o$Ninguém "lucra" com a sua mensalidade da forma como uma seguradora lucra; o dinheiro é dos próprios associados, administrado pela associação para proteger todos.$o$,
$n$O dinheiro é dos próprios associados, administrado pela associação para proteger todos. E, importante: a Todos Protegidos é uma associação regulamentada e fiscalizada pela SUSEP — ou seja, opera sob regras oficiais e supervisão do órgão do setor, o que traz segurança e garantia a quem adere.$n$);

update public.itens set descricao = replace(descricao,
$o$Como não é seguro regulado pela SUSEP, a proteção veicular tem três vantagens práticas que o cliente sente no bolso e na vida:$o$,
$n$Mesmo sendo uma associação regulamentada pela SUSEP, a Todos Protegidos mantém um atendimento ágil, com vantagens práticas que o cliente sente no bolso e na vida:$n$);

update public.itens set descricao = replace(descricao,
$o$Por ser uma associação, e não um seguro tradicional, conseguimos um custo menor, menos burocracia e adesão sem aquela análise pesada — com assistência 24 horas e indenização pela tabela FIPE em caso de perda total.$o$,
$n$A Todos Protegidos é uma associação de proteção veicular regulamentada pela SUSEP, o que te dá segurança e garantia, com adesão ágil, assistência 24 horas e indenização pela tabela FIPE em caso de perda total.$n$);

update public.itens set descricao = replace(descricao,
$o$- Dizer que "é a mesma coisa que seguro" (não é, e isso pode gerar problema).$o$,
$n$- Dizer que "não tem fiscalização" — somos uma associação regulamentada pela SUSEP.$n$);

-- ---- Aula 3.4 (leitura: proteção x seguro) ----
update public.itens set descricao = replace(descricao, $o$1. NATUREZA JURÍDICA$o$, $n$1. NATUREZA E REGULAMENTAÇÃO$n$);

update public.itens set descricao = replace(descricao,
$o$O seguro é um contrato regulado pela SUSEP, vendido por seguradoras, com apólice e regras padronizadas. A proteção veicular é uma relação associativa: você adere a uma associação/cooperativa e participa de um rateio de prejuízos. Não há "apólice de seguro", há um regulamento da associação. Por isso o consultor nunca deve usar a palavra "seguro" como sinônimo — além de incorreto, pode gerar reclamação.$o$,
$n$A Todos Protegidos é uma associação de proteção veicular: você adere à associação e participa de um rateio de prejuízos entre os associados. E há um ponto fundamental que é um diferencial de venda: embora seja uma associação (e não uma seguradora tradicional), a Todos Protegidos é REGULAMENTADA e FISCALIZADA pela SUSEP. Ou seja, opera sob regras oficiais e supervisão do órgão do setor — o que dá segurança, credibilidade e garantia ao associado. Use isso a seu favor.$n$);

update public.itens set descricao = replace(descricao,
$o$Proteção veicular = aceitação ampla + custo acessível + assistência 24h + 100% FIPE na perda total + adesão simples. Seguro = produto regulado, mais caro, com análise de risco. Posicione a proteção como a escolha inteligente para a maioria dos motoristas — sem atacar o seguro, apenas mostrando onde ela costuma sair na frente.$o$,
$n$Todos Protegidos = associação regulamentada e fiscalizada pela SUSEP + aceitação ampla + custo acessível + assistência 24h + 100% FIPE na perda total + adesão ágil. Posicione a proteção como a escolha inteligente para a maioria dos motoristas — uma associação com a segurança de ser supervisionada pela SUSEP — sem atacar o seguro tradicional, apenas mostrando onde ela costuma sair na frente.$n$);

-- ---- Apostila 3 ----
update public.itens set descricao = replace(descricao,
$o$- Natureza: o seguro é um contrato regulado pela SUSEP; a proteção veicular é uma relação associativa (não é seguro). Nunca use as palavras como sinônimo — além de tecnicamente errado, pode gerar reclamação.$o$,
$n$- Natureza e regulamentação: a Todos Protegidos é uma associação de proteção veicular — e, ponto importante, é regulamentada e fiscalizada pela SUSEP. Não é uma seguradora tradicional, mas opera sob supervisão oficial, o que dá segurança e garantia ao associado. Destaque essa regulamentação como diferencial.$n$);

update public.itens set descricao = replace(descricao,
$o$- Chamar proteção de "seguro".$o$,
$n$- Dizer que não tem fiscalização (somos uma associação regulamentada pela SUSEP).$n$);

update public.itens set descricao = replace(descricao,
$o$1. Proteção veicular = mutualismo/rateio entre associados; não é seguro.$o$,
$n$1. Proteção veicular = associação/rateio entre associados, regulamentada e fiscalizada pela SUSEP.$n$);

-- ---- Apostila 8 (objeção "já tenho seguro") ----
update public.itens set descricao = replace(descricao,
$o$"JÁ TENHO SEGURO/PROTEÇÃO" (informe sem depreciar): "Que bom que você se preocupa. A proteção veicular funciona por rateio entre associados; o seguro é regulado pela SUSEP. Posso te mostrar onde a proteção costuma sair mais em conta e com menos burocracia? Sem compromisso."$o$,
$n$"JÁ TENHO SEGURO/PROTEÇÃO" (informe sem depreciar): "Que bom que você se preocupa. A Todos Protegidos é uma associação de proteção veicular regulamentada e fiscalizada pela SUSEP — segurança e garantia, com ótimo custo-benefício. Posso te mostrar as diferenças, sem compromisso?"$n$);

-- ---- Aula 8.4 (boas práticas / pesquisa) ----
update public.itens set descricao = replace(descricao,
$o$"JÁ TENHO SEGURO / PROTEÇÃO" = INFORME E DIFERENCIE, SEM DEPRECIAR. "A proteção veicular funciona por rateio entre associados; o seguro é regulado pela SUSEP. Posso te mostrar as diferenças para você escolher com segurança." Autoridade e transparência derrubam a objeção e evitam objeções futuras.$o$,
$n$"JÁ TENHO SEGURO / PROTEÇÃO" = INFORME E DIFERENCIE, SEM DEPRECIAR. "A Todos Protegidos é uma associação de proteção veicular regulamentada e fiscalizada pela SUSEP — rateio entre associados com a segurança de uma empresa supervisionada pelo órgão oficial. Posso te mostrar as diferenças para você escolher com segurança." Autoridade e transparência derrubam a objeção e evitam objeções futuras.$n$);

-- ---- Questões da prova (Módulo 3) ----
update public.questoes set
  enunciado = 'O que melhor define a proteção veicular da Todos Protegidos?',
  opcoes = '["Uma associação de proteção (rateio/mutualismo) regulamentada pela SUSEP","Um financiamento do veículo","Uma garantia de fábrica","Um seguro vendido por seguradora"]'::jsonb,
  correta = 0
where enunciado = 'O que melhor define a proteção veicular?';

update public.questoes set
  enunciado = 'A Todos Protegidos é fiscalizada pela SUSEP?',
  opcoes = '["Sim — é uma associação de proteção veicular regulamentada e fiscalizada pela SUSEP","Não, não há nenhuma fiscalização","Apenas pelo Banco Central","Depende do estado"]'::jsonb,
  correta = 0
where enunciado = 'A proteção veicular é fiscalizada pela SUSEP?';
