# Backend (Supabase) — Todos Protegidos

A plataforma funciona em **dois modos**, decididos automaticamente:

- **Modo local** (padrão): enquanto `assets/js/config.js` estiver sem chaves, os dados ficam no navegador (bom para demonstração).
- **Modo nuvem (Supabase)**: ao preencher as chaves, o site passa a usar um **banco Postgres + login real**, compartilhado entre todos os usuários.

Nada no front-end precisa ser reescrito para ativar — basta configurar.

---

## Passo a passo para ativar o Supabase

### 1. Criar o projeto
1. Acesse <https://supabase.com> e crie uma conta (gratuita).
2. **New project** → escolha um nome e uma senha de banco → aguarde subir.

### 2. Criar as tabelas e regras
1. No projeto, abra **SQL Editor**.
2. Cole **todo** o conteúdo de [`supabase/schema.sql`](supabase/schema.sql) e clique em **Run**.
   - Isso cria as tabelas `profiles`, `modulos`, `itens`, as políticas de segurança (RLS) e o conteúdo inicial.

### 3. Pegar as chaves de API
1. **Project Settings → API**.
2. Copie **Project URL** e a chave **anon public**.

### 4. Configurar o front-end
Edite `assets/js/config.js`:
```js
window.TP_CONFIG = {
  SUPABASE_URL: "https://SEU-PROJETO.supabase.co",
  SUPABASE_ANON_KEY: "SUA-CHAVE-ANON",
  ADMIN_EMAIL: "admin@todosprotegidos.com.br",
  ADMIN_LOCAL_SENHA: "admin2026"
};
```
Faça commit/push — o GitHub Pages publica e o backend fica ativo.

### 5. Criar o administrador
1. No Supabase: **Authentication → Users → Add user**.
   - E-mail: o mesmo do `ADMIN_EMAIL` (ex.: `admin@todosprotegidos.com.br`)
   - Senha: a que desejar (ex.: `admin2026`)
   - Marque **Auto Confirm User**.
2. Promova esse usuário a admin no **SQL Editor**:
   ```sql
   update public.profiles set role = 'admin'
   where id = (select id from auth.users where email = 'admin@todosprotegidos.com.br');
   ```
3. Na tela de login do site, digite **`admin`** e a senha — o sistema usa o `ADMIN_EMAIL` automaticamente.

### 6. (Recomendado) Cadastro de consultores sem e-mail de confirmação
Para uso interno, em **Authentication → Providers → Email**, desative **Confirm email**.
Assim, ao se cadastrar, o consultor já entra direto. (Se mantiver ativo, ele precisa confirmar o e-mail antes do primeiro login.)

---

## O que fica no banco
| Tabela | Conteúdo |
|---|---|
| `profiles` | nome, telefone e **perfil** (`consultor`/`admin`) de cada usuário |
| `modulos` | módulos da trilha |
| `itens` | aulas, vídeos, informações e materiais de cada módulo |

**Segurança (RLS):** qualquer usuário logado **lê** a trilha; só **admin** cria/edita/exclui módulos e itens. Cada usuário só vê o próprio perfil (admin vê todos).

---

## Modelo de dados (camada `TPData`)
Todo o front fala com `window.TPData` (em `assets/js/api.js`), que expõe a mesma API nos dois modos:
`register`, `login`, `logout`, `session`, `listModules`, `addModule`, `deleteModule`, `addItem`, `deleteItem`.
Trocar de modo local → nuvem (ou vice-versa) é só preencher/esvaziar o `config.js`.
