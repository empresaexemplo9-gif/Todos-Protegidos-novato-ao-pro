-- ============================================================
-- TODOS PROTEGIDOS — Institucional (apresentação da empresa, texto único)
--
-- Transforma a parte de "Palavra do Presidente" e "Filosofia/Cultura":
--  1) Cria a tabela `institucional` (1 texto por tenant), editável SÓ por
--     admin/presidente; leitura para todos do tenant.
--  2) Remove os dois MÓDULOS institucionais da trilha (deixam de ser módulos
--     de aula). O texto da apresentação é preenchido depois, na própria
--     plataforma (página Institucional).
--
-- Rode no SQL Editor (depois do schema.sql). Seguro rodar mais de uma vez.
-- ============================================================

-- 1) Tabela: um texto institucional por tenant
create table if not exists public.institucional (
  tenant_id  uuid primary key references public.tenants(id) on delete cascade,
  conteudo   text not null default '',
  updated_at timestamptz not null default now()
);
alter table public.institucional enable row level security;

-- leitura: todos do tenant (superadmin vê todos). Escrita é feita via RPC abaixo.
drop policy if exists "institucional_read" on public.institucional;
create policy "institucional_read" on public.institucional
  for select using (tenant_id = public.current_tenant_id() or public.is_superadmin());

-- 2) Função para salvar (upsert) — só admin/presidente do próprio tenant
create or replace function public.set_institucional(p_conteudo text)
returns void language plpgsql security definer as $$
begin
  if not public.is_admin() then
    raise exception 'Apenas administradores podem editar o conteúdo institucional.';
  end if;
  insert into public.institucional (tenant_id, conteudo, updated_at)
    values (public.current_tenant_id(), coalesce(p_conteudo, ''), now())
  on conflict (tenant_id)
    do update set conteudo = excluded.conteudo, updated_at = now();
end;
$$;
grant execute on function public.set_institucional(text) to authenticated;

-- 3) Remove os módulos institucionais da trilha (viram apresentação editável)
--    Cobre os títulos atuais e os antigos. Apaga em cascata as aulas vinculadas.
do $$
declare t uuid;
begin
  select id into t from public.tenants where slug = 'matriz';
  if t is null then return; end if;
  delete from public.modulos
   where tenant_id = t
     and (titulo ilike '%Palavra do Presidente%' or titulo ilike '%Filosofia e Cultura%');
end $$;
