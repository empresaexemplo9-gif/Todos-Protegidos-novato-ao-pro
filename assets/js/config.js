// ============================================================
// Configuração do backend (Supabase)
// ------------------------------------------------------------
// Enquanto SUPABASE_URL/ANON_KEY estiverem VAZIOS, a plataforma
// funciona em modo LOCAL (dados salvos no navegador).
// Preencha com os dados do SEU projeto Supabase para ativar o
// backend na nuvem (banco Postgres + login real compartilhado).
// ============================================================
window.TP_CONFIG = {
  // Project Settings > API, no painel do Supabase:
  SUPABASE_URL: "",            // ex.: "https://abcdefgh.supabase.co"
  SUPABASE_ANON_KEY: "",       // chave "anon public"

  // E-mail real da conta de administrador criada no Supabase.
  // No login, digitar "admin" usa este e-mail automaticamente.
  ADMIN_EMAIL: "admin@todosprotegidos.com.br",

  // Senha do admin usada APENAS no modo LOCAL (demo, sem Supabase).
  ADMIN_LOCAL_SENHA: "admin2026"
};
