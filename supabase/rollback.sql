-- ============================================================
-- TODOS PROTEGIDOS — Reverter o schema (rollback)
-- Remove tudo que supabase/schema.sql criou neste projeto.
-- NÃO afeta os usuários do Authentication (auth.users).
-- Rode no SQL Editor do projeto onde deseja desfazer.
-- ============================================================

-- 1) Trigger no auth.users (criado pelo schema)
drop trigger if exists on_auth_user_created on auth.users;

-- 2) Funções
drop function if exists public.handle_new_user() cascade;
drop function if exists public.is_admin() cascade;

-- 3) Tabelas (a ordem/CASCADE remove também as políticas RLS e o seed)
drop table if exists public.itens   cascade;
drop table if exists public.modulos cascade;
drop table if exists public.profiles cascade;
