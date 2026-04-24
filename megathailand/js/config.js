// ============================================================
// FILL IN YOUR SUPABASE CREDENTIALS BELOW
// Get them from: https://supabase.com/dashboard → Settings → API
// ============================================================
const SUPABASE_URL = "https://lcxiilnovbzytkvkzrfq.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxjeGlpbG5vdmJ6eXRrdmt6cmZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzcwMTQ0NDAsImV4cCI6MjA5MjU5MDQ0MH0.MHqm0SyoVAc4xureTM37L0mS4XJ6aakywemZ9ckqPbo";
// ============================================================

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
