-- ============================================================
-- TODOS PROTEGIDOS — História da empresa no Institucional
--
-- Preenche o texto da página Institucional (tabela `institucional`) com a
-- história/identidade da empresa. O admin/presidente pode editar depois
-- pela própria plataforma.
--
-- Pré-requisito: ter rodado institucional.sql (cria a tabela). Idempotente.
-- ============================================================
do $$
declare t uuid;
begin
  select id into t from public.tenants where slug = 'matriz';
  if t is null then raise notice 'Tenant "matriz" nao encontrado.'; return; end if;

  insert into public.institucional (tenant_id, conteudo, updated_at)
  values (t, $TXT$Bem-vindo(a) à Todos Protegidos!

É com grande satisfação que você inicia sua jornada conosco. Aqui você conhece a história da nossa empresa, nossos princípios e o que nos torna únicos no mercado de proteção veicular.

NOSSA HISTÓRIA
A Todos Protegidos nasceu em 15 de janeiro de 2025, com um propósito claro: tornar a proteção veicular acessível, justa e sem burocracia para quem realmente precisa. Nossa história carrega o DNA de uma das maiores redes de inclusão social do Brasil — o Cartão de TODOS.

Desde o início, unimos forças com o Cartão de TODOS porque compartilhamos a mesma visão: inclusão, acessibilidade e cuidado com as famílias brasileiras. Enquanto o Cartão de TODOS revolucionou o acesso à saúde, educação e lazer com serviços a preços populares em todo o país, nós trouxemos essa mentalidade para o universo da proteção veicular. Como unidade de negócio do Cartão de TODOS, garantimos um modelo que coloca o associado no centro de tudo — com valores acessíveis, atendimento humanizado e compromisso real com o bem protegido.

CRESCIMENTO E EXPANSÃO
Iniciamos nossas atividades com sede física em Goiânia-GO e, graças à confiança dos nossos associados, estamos em expansão para outras regiões, com uma nova unidade em abertura em Valparaíso-GO. Nossa atuação abrange carros e motos em diversas cidades do Brasil.

SERVIÇOS E BENEFÍCIOS
- Proteção contra roubo e furto
- Indenização por perda total
- Proteção contra incêndios decorrentes de colisão
- Cobertura de vidros
- Danos a terceiros
- Assistência 24h com guincho
- Rede de oficinas parceiras
- Fenômenos da natureza
- Chaveiro
- Hotelaria

MISSÃO
Levar proteção veicular acessível, confiável e de qualidade a todos, promovendo segurança e tranquilidade aos nossos associados, com atendimento humanizado e suporte eficiente em todos os momentos.

VISÃO
Ser a referência em proteção veicular no Brasil, reconhecida por nossa acessibilidade, compromisso com a inclusão e excelência no atendimento, impactando positivamente a vida de milhares de associados e motoristas.

VALORES
- Acessibilidade: garantir que todos possam ter acesso à proteção veicular sem burocracia.
- Compromisso: cumprir nossas promessas com transparência e responsabilidade.
- Empatia: tratar nossos associados com respeito, atenção e apoio em qualquer situação.
- Eficiência: oferecer suporte ágil e soluções rápidas em qualquer circunstância.
- Crescimento sustentável: expandir nossos serviços com responsabilidade e inovação.

SOBRE O PRESIDENTE
Ubirani Guimarães de Pinho, presidente da associação, iniciou sua trajetória empreendedora aos 20 anos. Hoje é CEO da NU Company, holding que reúne 39 empresas. Atuou por oito anos como Diretor do Cartão de TODOS, responsável pela expansão da marca nas regiões Centro-Oeste e Norte do Brasil — experiência que fortalece o nosso compromisso com qualidade e excelência.

NOSSA EQUIPE
- Presidente: Ubirani Guimarães
- Vice-Presidente: Celiomar Ramos
- Gerente Geral: Wellington Cruz
- Gestor de Eventos: Vitalino Pereira
- Regulador de Sinistros: Gustavo Rocha
- Gestor Comercial: Roberto Francisco
- Líder de Vendas, Consultores, Secretaria Administrativa, Auxiliares (Cobrança e Pós-Vendas) e Serviços Gerais

NOSSO CLIMA: "AQUI É TODO MUNDO PROTEGIDO, INCLUSIVE VOCÊ"
Na Todos Protegidos, o cuidado começa dentro de casa. Nossa cultura é construída com o mesmo propósito que nos guia no mercado: acessar, incluir, proteger e transformar. Valorizamos a colaboração autêntica, a abertura e a transparência, o protagonismo com suporte e um ambiente seguro, diverso e inclusivo. Temos metas ambiciosas — e acreditamos que é possível alcançá-las com empatia, bom senso e humanidade.

"Proteger pessoas é mais do que oferecer cobertura veicular. É criar um espaço onde elas se sintam valorizadas, motivadas e parte de algo maior."

Seja bem-vindo(a) a um ambiente onde o profissionalismo anda lado a lado com o acolhimento. Esse é o clima da Todos Protegidos. E agora ele também é seu.$TXT$, now())
  on conflict (tenant_id) do update set conteudo = excluded.conteudo, updated_at = now();

  raise notice 'Historia da empresa inserida no Institucional.';
end $$;
