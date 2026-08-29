-- ============================================================
-- NACIYE PROJECT - SUPABASE SETUP SCRIPT
-- Paste this into Supabase Dashboard > SQL Editor and run it.
-- Safe to re-run: uses "on conflict do nothing" for seed data.
-- ============================================================

-- 1) Ingredients table
create table if not exists ingredients (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  unit text not null,
  price numeric not null default 0,
  created_at timestamp with time zone default now()
);

-- 2) Recipes table
create table if not exists recipes (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamp with time zone default now()
);

-- 3) Recipe-ingredient link table (which ingredients a recipe uses)
create table if not exists recipe_ingredients (
  id uuid primary key default gen_random_uuid(),
  recipe_id uuid references recipes(id) on delete cascade,
  ingredient_id uuid references ingredients(id) on delete cascade,
  quantity numeric not null default 0
);

-- ============================================================
-- ROW LEVEL SECURITY: only authenticated users can read/write.
-- Anonymous (not logged in) users cannot access any data.
-- ============================================================

alter table ingredients enable row level security;
alter table recipes enable row level security;
alter table recipe_ingredients enable row level security;

drop policy if exists "authenticated_all_ingredients" on ingredients;
create policy "authenticated_all_ingredients" on ingredients
  for all
  to authenticated
  using (true)
  with check (true);

drop policy if exists "authenticated_all_recipes" on recipes;
create policy "authenticated_all_recipes" on recipes
  for all
  to authenticated
  using (true)
  with check (true);

drop policy if exists "authenticated_all_recipe_ingredients" on recipe_ingredients;
create policy "authenticated_all_recipe_ingredients" on recipe_ingredients
  for all
  to authenticated
  using (true)
  with check (true);

-- ============================================================
-- DEFAULT SEED DATA
-- Fixed UUIDs so this script can be re-run safely without
-- creating duplicates. Users can freely edit these afterwards
-- from the Master Tablo page; if they never touch them, these
-- defaults stay in effect.
-- ============================================================

insert into ingredients (id, name, unit, price) values
  ('11111111-1111-1111-1111-111111111101', 'Kıyma', 'kg', 650),
  ('11111111-1111-1111-1111-111111111102', 'Un', 'kg', 25),
  ('11111111-1111-1111-1111-111111111103', 'Yumurta', 'adet', 4.5),
  ('11111111-1111-1111-1111-111111111104', 'Soğan', 'kg', 35),
  ('11111111-1111-1111-1111-111111111105', 'Patates', 'kg', 30),
  ('11111111-1111-1111-1111-111111111106', 'Mayonez', 'kg', 180),
  ('11111111-1111-1111-1111-111111111107', 'Tereyağı', 'kg', 450),
  ('11111111-1111-1111-1111-111111111108', 'Çilek', 'kg', 120),
  ('11111111-1111-1111-1111-111111111109', 'Şeker', 'kg', 45),
  ('11111111-1111-1111-1111-111111111110', 'Kırmızı Mercimek', 'kg', 55),
  ('11111111-1111-1111-1111-111111111111', 'Bulgur', 'kg', 40),
  ('11111111-1111-1111-1111-111111111112', 'Salça', 'kg', 90)
on conflict (id) do nothing;

insert into recipes (id, name) values
  ('22222222-2222-2222-2222-222222222201', 'Mantı'),
  ('22222222-2222-2222-2222-222222222202', 'Patates Salatası'),
  ('22222222-2222-2222-2222-222222222203', 'Çilekli Tart'),
  ('22222222-2222-2222-2222-222222222204', 'Mercimek Köftesi')
on conflict (id) do nothing;

insert into recipe_ingredients (recipe_id, ingredient_id, quantity) values
  -- Mantı: Kıyma, Un, Yumurta, Soğan
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111101', 1),
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111102', 2),
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111103', 3),
  ('22222222-2222-2222-2222-222222222201', '11111111-1111-1111-1111-111111111104', 0.5),

  -- Patates Salatası: Patates, Mayonez, Soğan, Yumurta
  ('22222222-2222-2222-2222-222222222202', '11111111-1111-1111-1111-111111111105', 2),
  ('22222222-2222-2222-2222-222222222202', '11111111-1111-1111-1111-111111111106', 0.3),
  ('22222222-2222-2222-2222-222222222202', '11111111-1111-1111-1111-111111111104', 0.2),
  ('22222222-2222-2222-2222-222222222202', '11111111-1111-1111-1111-111111111103', 3),

  -- Çilekli Tart: Un, Tereyağı, Çilek, Yumurta, Şeker
  ('22222222-2222-2222-2222-222222222203', '11111111-1111-1111-1111-111111111102', 0.5),
  ('22222222-2222-2222-2222-222222222203', '11111111-1111-1111-1111-111111111107', 0.25),
  ('22222222-2222-2222-2222-222222222203', '11111111-1111-1111-1111-111111111108', 0.4),
  ('22222222-2222-2222-2222-222222222203', '11111111-1111-1111-1111-111111111103', 2),
  ('22222222-2222-2222-2222-222222222203', '11111111-1111-1111-1111-111111111109', 0.15),

  -- Mercimek Köftesi: Kırmızı Mercimek, Bulgur, Soğan, Salça
  ('22222222-2222-2222-2222-222222222204', '11111111-1111-1111-1111-111111111110', 0.5),
  ('22222222-2222-2222-2222-222222222204', '11111111-1111-1111-1111-111111111111', 0.5),
  ('22222222-2222-2222-2222-222222222204', '11111111-1111-1111-1111-111111111104', 0.3),
  ('22222222-2222-2222-2222-222222222204', '11111111-1111-1111-1111-111111111112', 0.1)
on conflict do nothing;
