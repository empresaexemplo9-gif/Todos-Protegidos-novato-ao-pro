-- ============================================================
-- TODOS PROTEGIDOS UNIVERSITY — Migração das novas funcionalidades
-- Rode UMA VEZ no Supabase: Dashboard > SQL Editor > New query > cole tudo > Run.
-- Cria as tabelas de: Meus clientes, Minhas vendas, Certificações, Metas,
-- mais a função de Ranking. Tudo com RLS (cada consultor vê só os seus dados).
-- É seguro rodar mais de uma vez (idempotente).
-- ============================================================

-- ---------- MEUS CLIENTES ----------
create table if not exists public.clientes (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  nome       text not null,
  email      text,
  telefone   text,
  documento  text,
  veiculo    text,
  status     text not null default 'lead',      -- lead | ativo | inativo
  obs        text,
  criado_em  timestamptz not null default now()
);
alter table public.clientes enable row level security;
drop policy if exists "clientes_own" on public.clientes;
create policy "clientes_own" on public.clientes
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------- MINHAS VENDAS ----------
create table if not exists public.vendas (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null default auth.uid() references auth.users(id) on delete cascade,
  cliente_id    uuid references public.clientes(id) on delete set null,
  cliente_nome  text,
  veiculo       text,
  plano         text,
  valor         numeric(12,2) default 0,         -- mensalidade/adesão
  comissao      numeric(12,2) default 0,
  status        text not null default 'ativa',   -- ativa | pendente | cancelada
  data          date not null default current_date,
  criado_em     timestamptz not null default now()
);
alter table public.vendas enable row level security;
drop policy if exists "vendas_own" on public.vendas;
create policy "vendas_own" on public.vendas
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------- CERTIFICAÇÕES ----------
create table if not exists public.certificados (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid not null default auth.uid() references auth.users(id) on delete cascade,
  modulo_id      uuid,
  modulo_titulo  text,
  score          int not null default 0,
  id_validacao   text,
  data           date not null default current_date,
  criado_em      timestamptz not null default now()
);
alter table public.certificados enable row level security;
drop policy if exists "certificados_own" on public.certificados;
create policy "certificados_own" on public.certificados
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------- METAS (Ranking & metas) ----------
create table if not exists public.metas (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid not null default auth.uid() references auth.users(id) on delete cascade,
  mes            int not null,
  ano            int not null,
  meta_vendas    int default 0,
  meta_comissao  numeric(12,2) default 0,
  unique (user_id, mes, ano)
);
alter table public.metas enable row level security;
drop policy if exists "metas_own" on public.metas;
create policy "metas_own" on public.metas
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ---------- RANKING (agregado entre consultores) ----------
-- SECURITY DEFINER: agrega vendas de todos os consultores expondo só nome + totais.
create or replace function public.ranking_mensal(p_mes int, p_ano int)
returns table (user_id uuid, nome text, total_vendas bigint, total_comissao numeric)
language sql security definer set search_path = public as $$
  select v.user_id,
         coalesce(p.nome, 'Consultor') as nome,
         count(*)::bigint as total_vendas,
         coalesce(sum(v.comissao), 0) as total_comissao
  from public.vendas v
  left join public.profiles p on p.id = v.user_id
  where extract(month from v.data) = p_mes
    and extract(year  from v.data) = p_ano
    and v.status <> 'cancelada'
  group by v.user_id, p.nome
  order by total_comissao desc, total_vendas desc
  limit 50;
$$;
grant execute on function public.ranking_mensal(int, int) to anon, authenticated;
