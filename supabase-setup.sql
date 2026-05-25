-- ══════════════════════════════════════════════════════
--  GOMIX — Setup de Supabase
--  Ejecuta este script en el SQL Editor de tu proyecto
--  https://supabase.com/dashboard → SQL Editor → New Query
-- ══════════════════════════════════════════════════════

-- ── 1. Tabla de productos ──────────────────────────────
create table if not exists products (
  id          uuid primary key default gen_random_uuid(),
  producto    text not null,
  categoria   text not null,
  precio      numeric(10,2) not null,
  descripcion text default '',
  imagen      text default '',
  activo      boolean default true,
  orden       integer default 0,
  created_at  timestamptz default now()
);

-- ── 2. Tabla de pedidos ───────────────────────────────
create table if not exists orders (
  id          uuid primary key default gen_random_uuid(),
  items       jsonb not null default '[]',
  total       numeric(10,2) not null,
  nombre      text not null,
  pago        text not null check (pago in ('efectivo','transferencia')),
  direccion   text not null,
  status      text not null default 'nuevo'
              check (status in ('nuevo','en_proceso','entregado','cancelado')),
  created_at  timestamptz default now()
);

-- ── 3. Row Level Security ─────────────────────────────
alter table products enable row level security;
alter table orders   enable row level security;

-- Cualquiera puede leer productos activos
create policy "public_read_products"
  on products for select to anon
  using (activo = true);

-- Cualquiera puede insertar pedidos
create policy "public_insert_orders"
  on orders for insert to anon
  with check (true);

-- Cualquiera puede leer pedidos (el admin usa la misma clave anon)
-- En producción deberías restringir esto con Supabase Auth
create policy "public_read_orders"
  on orders for select to anon
  using (true);

-- Admin autenticado puede hacer todo
create policy "auth_all_products"
  on products for all to authenticated using (true);

create policy "auth_all_orders"
  on orders for all to authenticated using (true);

-- ── 4. Realtime ───────────────────────────────────────
-- Habilita realtime para la tabla orders
alter publication supabase_realtime add table orders;

-- ── 5. Storage para imágenes ──────────────────────────
-- Crea el bucket (también puedes hacerlo desde el dashboard)
insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

-- Cualquiera puede ver las imágenes (bucket público)
create policy "public_read_images"
  on storage.objects for select to anon
  using (bucket_id = 'product-images');

-- Cualquiera puede subir imágenes
-- (en producción, restringe a usuarios autenticados)
create policy "public_upload_images"
  on storage.objects for insert to anon
  with check (bucket_id = 'product-images');

-- ── 6. Carga de datos iniciales (opcional) ────────────
insert into products (producto, categoria, precio, descripcion, imagen, orden) values
  ('Gomiboing de mango',   'Gomiboing', 35, 'Fresco Boing congelado sabor mango con toppings a elegir.',        'https://images.unsplash.com/photo-1546173159-315724a31696?w=600&auto=format&fit=crop', 1),
  ('Gomiboing de uva',     'Gomiboing', 35, 'Fresco Boing congelado sabor uva con toppings a elegir.',          'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=600&auto=format&fit=crop', 2),
  ('Gomiboing de fresa',   'Gomiboing', 35, 'Fresco Boing congelado sabor fresa con toppings a elegir.',        'https://images.unsplash.com/photo-1553361371-9b22f78e8b1d?w=600&auto=format&fit=crop', 3),
  ('Gomiboing de guayaba', 'Gomiboing', 35, 'Fresco Boing congelado sabor guayaba con toppings a elegir.',      'https://images.unsplash.com/photo-1621955964441-c173e01c135b?w=600&auto=format&fit=crop', 4),
  ('Gomiboing de manzana', 'Gomiboing', 35, 'Fresco Boing congelado sabor manzana con toppings a elegir.',      'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=600&auto=format&fit=crop', 5),
  ('Frape de oreo',        'Frape',     50, 'Cremoso frappé helado de galleta Oreo con jarabe de chocolate.',  'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=600&auto=format&fit=crop', 6),
  ('Frape de fresa',       'Frape',     50, 'Suave frappé sabor fresa intensa, dulce y refrescante.',          'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=600&auto=format&fit=crop', 7),
  ('Frape de cajeta',      'Frape',     50, 'Frappé cremoso con el toque dulce y tradicional de la cajeta.',   'https://images.unsplash.com/photo-1534353436294-0dbd4bdac845?w=600&auto=format&fit=crop', 8);
