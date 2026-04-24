// ============================================================
// FILL IN YOUR SUPABASE CREDENTIALS BELOW
// Get them from: https://supabase.com/dashboard → Settings → API
// ============================================================
const SUPABASE_URL = "https://your-project-id.supabase.co";
const SUPABASE_ANON_KEY = "your-anon-key-here";
// ============================================================

const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
