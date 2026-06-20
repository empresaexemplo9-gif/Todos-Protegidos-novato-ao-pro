-- ============================================================
-- TODOS PROTEGIDOS — Backend (Supabase / PostgreSQL)
-- Rode este script UMA VEZ no SQL Editor do seu projeto Supabase.
-- ============================================================

-- 1) PERFIS (1:1 com os usuários do Supabase Auth)
create table if not exists public.profiles (
  id         uuid primary key references auth.users(id) on delete cascade,
  nome       text,
  telefone   text,
  role       text not null default 'consultor' check (role in ('consultor','admin')),
  created_at timestamptz not null default now()
);

-- 2) MÓDULOS
create table if not exists public.modulos (
  id         uuid primary key default gen_random_uuid(),
  titulo     text not null,
  subtitulo  text default '',
  ordem      bigint not null default 0,
  created_at timestamptz not null default now()
);

-- 3) ITENS (aulas, vídeos, informações, materiais)
create table if not exists public.itens (
  id         uuid primary key default gen_random_uuid(),
  modulo_id  uuid not null references public.modulos(id) on delete cascade,
  tipo       text not null default 'aula' check (tipo in ('aula','video','info','file')),
  titulo     text not null,
  meta       text default '',
  url        text default '',
  descricao  text default '',
  ordem      bigint not null default 0,
  created_at timestamptz not null default now()
);

-- 4) Função: o usuário atual é admin?
create or replace function public.is_admin()
returns boolean language sql security definer stable as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.role = 'admin'
  );
$$;

-- 5) Cria o perfil automaticamente quando um usuário se registra
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.profiles (id, nome, telefone)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'nome', ''),
    coalesce(new.raw_user_meta_data->>'telefone', '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- 6) Row Level Security
alter table public.profiles enable row level security;
alter table public.modulos  enable row level security;
alter table public.itens    enable row level security;

-- profiles: cada um vê/edita o seu; admin vê todos
drop policy if exists "profiles_select" on public.profiles;
create policy "profiles_select" on public.profiles
  for select using (id = auth.uid() or public.is_admin());

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own" on public.profiles
  for update using (id = auth.uid());

drop policy if exists "profiles_admin_update" on public.profiles;
create policy "profiles_admin_update" on public.profiles
  for update using (public.is_admin());

-- modulos: leitura para usuários autenticados; escrita só admin
drop policy if exists "modulos_read" on public.modulos;
create policy "modulos_read" on public.modulos
  for select using (auth.role() = 'authenticated');

drop policy if exists "modulos_write" on public.modulos;
create policy "modulos_write" on public.modulos
  for all using (public.is_admin()) with check (public.is_admin());

-- itens: leitura para autenticados; escrita só admin
drop policy if exists "itens_read" on public.itens;
create policy "itens_read" on public.itens
  for select using (auth.role() = 'authenticated');

drop policy if exists "itens_write" on public.itens;
create policy "itens_write" on public.itens
  for all using (public.is_admin()) with check (public.is_admin());

-- 7) Conteúdo inicial (só insere se as tabelas estiverem vazias)
insert into public.modulos (titulo, subtitulo, ordem)
select v.titulo, v.subtitulo, v.ordem
from (values
  ('Nível 1 · Novato',         'Fundamentos da proteção veicular e cultura da empresa', 1),
  ('Nível 2 · Intermediário',  'Padrão de atendimento e abordagem',                     2),
  ('Nível 3 · Avançado',       'Protocolos de venda, vistoria e objeções',              3),
  ('Nível 4 · Pro',            'Gestão de carteira, pós-venda e mentoria',              4)
) as v(titulo, subtitulo, ordem)
where not exists (select 1 from public.modulos);

insert into public.itens (modulo_id, tipo, titulo, meta, ordem)
select m.id, x.tipo, x.titulo, x.meta, x.ordem
from public.modulos m
join (values
  ('Nível 1 · Novato',        'video', 'Boas-vindas e cultura Todos Protegidos',          '08:00',                  1),
  ('Nível 1 · Novato',        'info',  'Benefícios (assistência 24h, FIPE, carro e moto)', 'Texto de apoio',         2),
  ('Nível 2 · Intermediário', 'aula',  'Abordagem: formas e técnicas',                     '5 modelos de abordagem', 1),
  ('Nível 3 · Avançado',      'info',  'Contorno de 10 objeções',                          'Biblioteca de scripts',  1),
  ('Nível 3 · Avançado',      'file',  'Checklist de vistoria',                            'PDF',                    2),
  ('Nível 4 · Pro',           'info',  'Reativação de inadimplentes',                      'Scripts de voz e WhatsApp', 1)
) as x(modtitulo, tipo, titulo, meta, ordem) on x.modtitulo = m.titulo
where not exists (select 1 from public.itens);

-- ============================================================
-- ADMIN — depois de criar o usuário admin em Authentication > Users
-- (e-mail igual ao ADMIN_EMAIL do config.js), rode:
--
--   update public.profiles set role = 'admin'
--   where id = (select id from auth.users where email = 'admin@todosprotegidos.com.br');
-- ============================================================
