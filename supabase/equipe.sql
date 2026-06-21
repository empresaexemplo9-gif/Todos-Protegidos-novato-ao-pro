-- ============================================================
-- TODOS PROTEGIDOS — Painel da equipe (admin lê o progresso do tenant)
-- Rode no SQL Editor se já tinha o progress.sql rodado antes.
-- Seguro rodar mais de uma vez.
-- ============================================================
drop policy if exists "progresso_admin_select" on public.progresso;
create policy "progresso_admin_select" on public.progresso
  for select using (
    public.is_admin() and exists (
      select 1 from public.profiles p
      where p.id = progresso.user_id and p.tenant_id = public.current_tenant_id()
    )
  );
