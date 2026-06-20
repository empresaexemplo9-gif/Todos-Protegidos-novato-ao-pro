-- ============================================================
-- TODOS PROTEGIDOS — Prova por módulo + título de cargo
-- Rode no SQL Editor se você JÁ tinha rodado o schema antes.
-- Seguro rodar mais de uma vez.
-- ============================================================

-- Título/cargo no perfil (ex.: "Presidente da empresa")
alter table public.profiles add column if not exists titulo text;

-- Questões da prova (por módulo, isoladas por tenant)
create table if not exists public.questoes (
  id         uuid primary key default gen_random_uuid(),
  tenant_id  uuid not null references public.tenants(id) on delete cascade,
  modulo_id  uuid not null references public.modulos(id) on delete cascade,
  ordem      bigint not null default 0,
  enunciado  text not null,
  opcoes     jsonb not null default '[]'::jsonb,   -- array de textos das alternativas
  correta    int  not null default 0,              -- índice (0..n) da alternativa correta
  created_at timestamptz not null default now()
);

alter table public.questoes enable row level security;

drop trigger if exists set_tenant_questoes on public.questoes;
create trigger set_tenant_questoes before insert on public.questoes
  for each row execute function public.set_tenant_id();

drop policy if exists "questoes_read" on public.questoes;
create policy "questoes_read" on public.questoes
  for select using (tenant_id = public.current_tenant_id() or public.is_superadmin());

drop policy if exists "questoes_write" on public.questoes;
create policy "questoes_write" on public.questoes
  for all using (public.is_admin() and tenant_id = public.current_tenant_id())
  with check (public.is_admin() and tenant_id = public.current_tenant_id());

-- ============================================================
-- Definir o Ubirani como PRESIDENTE (ajuste o e-mail para o real):
--   update public.profiles set titulo = 'Presidente da empresa'
--   where id = (select id from auth.users where email = 'ubirani@todosprotegidos.com.br');
-- ============================================================
