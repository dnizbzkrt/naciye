-- ============================================================
-- NACIYE PROJECT - SUPABASE SETUP SCRIPT
-- Paste this into Supabase Dashboard > SQL Editor and run it.
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

create policy "authenticated_all_ingredients" on ingredients
  for all
  to authenticated
  using (true)
  with check (true);

create policy "authenticated_all_recipes" on recipes
  for all
  to authenticated
  using (true)
  with check (true);

create policy "authenticated_all_recipe_ingredients" on recipe_ingredients
  for all
  to authenticated
  using (true)
  with check (true);

-- ============================================================
-- Optional sample data. Remove the leading -- on the lines
-- below if you want to insert example rows.
-- ============================================================

-- insert into ingredients (name, unit, price) values
--   ('Kıyma', 'kg', 320),
--   ('Un', 'kg', 25),
--   ('Yumurta', 'adet', 3.5);
