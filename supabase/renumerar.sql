-- ============================================================
-- TODOS PROTEGIDOS — Renumerar módulos de vendas (3–9 → 1–7)
--
-- Renumera: Módulo 3->1, 4->2, 5->3, 6->4, 7->5, 8->6, 9->7
-- Ajusta título do módulo, ordem, títulos das aulas/apostilas e os
-- cabeçalhos internos ("MÓDULO N" / "Módulo N") de cada módulo.
--
-- Rode no SQL Editor. Seguro rodar mais de uma vez (após a 1ª vez os títulos
-- antigos não existem mais → no-op). Não depende de outros scripts.
--
-- ATENÇÃO: depois de renumerar, NÃO rode de novo conteudo.sql /
-- conteudo-aprofundado.sql / apostila.sql (eles buscam pelos números antigos).
-- ============================================================
do $$
declare t uuid; m uuid;
begin
  select id into t from public.tenants where slug = 'matriz';
  if t is null then raise notice 'Tenant "matriz" nao encontrado.'; return; end if;

  -- Módulo 3 -> 1
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 3 · Fundamentos da Proteção Veicular';
  if m is not null then
    update public.modulos set titulo = 'Módulo 1 · Fundamentos da Proteção Veicular', ordem = 1 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 3.', 'Aula 1.'), 'Apostila 3', 'Apostila 1'),
      descricao = replace(replace(descricao, 'MÓDULO 3', 'MÓDULO 1'), 'Módulo 3', 'Módulo 1')
    where modulo_id = m;
  end if;

  -- Módulo 4 -> 2
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 4 · Mentalidade e Rotina de Alta Performance';
  if m is not null then
    update public.modulos set titulo = 'Módulo 2 · Mentalidade e Rotina de Alta Performance', ordem = 2 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 4.', 'Aula 2.'), 'Apostila 4', 'Apostila 2'),
      descricao = replace(replace(descricao, 'MÓDULO 4', 'MÓDULO 2'), 'Módulo 4', 'Módulo 2')
    where modulo_id = m;
  end if;

  -- Módulo 5 -> 3
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 5 · Prospecção e Abordagem';
  if m is not null then
    update public.modulos set titulo = 'Módulo 3 · Prospecção e Abordagem', ordem = 3 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 5.', 'Aula 3.'), 'Apostila 5', 'Apostila 3'),
      descricao = replace(replace(descricao, 'MÓDULO 5', 'MÓDULO 3'), 'Módulo 5', 'Módulo 3')
    where modulo_id = m;
  end if;

  -- Módulo 6 -> 4
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 6 · Diagnóstico com SPIN Selling';
  if m is not null then
    update public.modulos set titulo = 'Módulo 4 · Diagnóstico com SPIN Selling', ordem = 4 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 6.', 'Aula 4.'), 'Apostila 6', 'Apostila 4'),
      descricao = replace(replace(descricao, 'MÓDULO 6', 'MÓDULO 4'), 'Módulo 6', 'Módulo 4')
    where modulo_id = m;
  end if;

  -- Módulo 7 -> 5
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 7 · Apresentação de Valor (Challenger)';
  if m is not null then
    update public.modulos set titulo = 'Módulo 5 · Apresentação de Valor (Challenger)', ordem = 5 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 7.', 'Aula 5.'), 'Apostila 7', 'Apostila 5'),
      descricao = replace(replace(descricao, 'MÓDULO 7', 'MÓDULO 5'), 'Módulo 7', 'Módulo 5')
    where modulo_id = m;
  end if;

  -- Módulo 8 -> 6
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 8 · Fechamento e Tratamento de Objeções';
  if m is not null then
    update public.modulos set titulo = 'Módulo 6 · Fechamento e Tratamento de Objeções', ordem = 6 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 8.', 'Aula 6.'), 'Apostila 8', 'Apostila 6'),
      descricao = replace(replace(descricao, 'MÓDULO 8', 'MÓDULO 6'), 'Módulo 8', 'Módulo 6')
    where modulo_id = m;
  end if;

  -- Módulo 9 -> 7
  select id into m from public.modulos where tenant_id = t and titulo = 'Módulo 9 · Vistoria, Pós-venda e Retenção';
  if m is not null then
    update public.modulos set titulo = 'Módulo 7 · Vistoria, Pós-venda e Retenção', ordem = 7 where id = m;
    update public.itens set
      titulo    = replace(replace(titulo, 'Aula 9.', 'Aula 7.'), 'Apostila 9', 'Apostila 7'),
      descricao = replace(replace(descricao, 'MÓDULO 9', 'MÓDULO 7'), 'Módulo 9', 'Módulo 7')
    where modulo_id = m;
  end if;

  raise notice 'Modulos de vendas renumerados para 1 a 7.';
end $$;
