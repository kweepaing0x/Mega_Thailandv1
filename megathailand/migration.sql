-- ============================================
-- MegaThailand Profit Calculator - Migration
-- Run this in Supabase SQL Editor
-- ============================================

-- Products table
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  name_my text,
  category text,
  price_thb numeric NOT NULL,
  weight_kg numeric NOT NULL DEFAULT 0,
  image_url text,
  tag text DEFAULT '',
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- Settings table
CREATE TABLE IF NOT EXISTS settings (
  key text PRIMARY KEY,
  value text NOT NULL,
  updated_at timestamptz DEFAULT now()
);

-- Default settings
INSERT INTO settings (key, value) VALUES
  ('exchange_rate', '132'),
  ('ship_dense_mmk_per_kg', '1200'),
  ('ship_light_mmk_per_kg', '12000'),
  ('shopper_fee_pct', '10')
ON CONFLICT (key) DO NOTHING;

-- Storage bucket for product images
INSERT INTO storage.buckets (id, name, public)
VALUES ('product-images', 'product-images', true)
ON CONFLICT (id) DO NOTHING;

-- RLS
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read products" ON products FOR SELECT USING (is_active = true);
CREATE POLICY "Public read settings" ON settings FOR SELECT USING (true);
CREATE POLICY "Anon manage products" ON products FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Anon manage settings" ON settings FOR ALL USING (true) WITH CHECK (true);

-- Storage policies
CREATE POLICY "Public read images" ON storage.objects FOR SELECT USING (bucket_id = 'product-images');
CREATE POLICY "Anon upload images" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'product-images');
CREATE POLICY "Anon update images" ON storage.objects FOR UPDATE USING (bucket_id = 'product-images');
CREATE POLICY "Anon delete images" ON storage.objects FOR DELETE USING (bucket_id = 'product-images');

-- Sample products
INSERT INTO products (name, name_my, category, price_thb, weight_kg, tag) VALUES
  ('Thai Jasmine Rice 5kg', 'ထိုင်းကြာဆန်', 'Food', 89, 5, 'hot'),
  ('Bird Nest Drink', 'ငှက်သိုက်ဖျော်ရည်', 'Health', 450, 1.2, 'hot'),
  ('Thai Sunscreen SPF50', 'နေရောင်ကာဆေး', 'Beauty', 280, 0.3, 'new'),
  ('Thai Green Tea 50pcs', 'ကြာသနပ်လက်ဖက်', 'Beverage', 120, 0.5, 'new'),
  ('Coconut Oil 1L', 'အုန်းဆီ', 'Health', 320, 1.0, ''),
  ('Instant Noodles 30pcs', 'ချက်ချင်းခေါက်ဆွဲ', 'Food', 195, 2.5, '')
ON CONFLICT DO NOTHING;
