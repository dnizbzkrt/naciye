// ==========================================================
// Supabase project credentials
// ==========================================================
const SUPABASE_URL = "https://exvrwqtikkbiiphkpuys.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_Sq_8ugzFVUQVeZkM0xFXlw_1KKQRwXS";

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Redirect to login page if not authenticated
async function requireAuth() {
  const { data: { session } } = await supabaseClient.auth.getSession();
  if (!session) {
    window.location.href = "index.html";
    return null;
  }
  return session;
}

// If already logged in, redirect away from login page
async function redirectIfLoggedIn() {
  const { data: { session } } = await supabaseClient.auth.getSession();
  if (session) {
    window.location.href = "home.html";
  }
}

async function logout() {
  await supabaseClient.auth.signOut();
  window.location.href = "index.html";
}

function setupLogoutButton() {
  const btn = document.getElementById("logoutBtn");
  if (btn) btn.addEventListener("click", logout);
}
