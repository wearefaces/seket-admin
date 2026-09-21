-- Seket Admin - Supabase schema for shared assignments
-- Free-tier friendly: one public table with open RLS for anon key
-- Tradeoff: anyone with the anon key can read/write/delete rows.
-- Scope rows by optional 'team' if you want to separate squads logically.

create table if not exists public.seket_assignments (
  match_id text primary key,
  team text,
  klocka text,
  ovr text,
  speaker text,
  musik text,
  bas1 text,
  bas2 text,
  updated_at timestamptz not null default now()
);

-- Helpful index if you use the optional team filter client-side
create index if not exists seket_assignments_team_idx on public.seket_assignments (team);

-- Enable Row Level Security
alter table public.seket_assignments enable row level security;

-- OPEN policies for anon key (no auth). Suitable for a small volunteer club.
-- Anyone who has the site link (and embedded anon key) can read/write/delete.
create policy if not exists "Public read"
  on public.seket_assignments
  for select
  using (true);

create policy if not exists "Public insert"
  on public.seket_assignments
  for insert
  with check (true);

create policy if not exists "Public update"
  on public.seket_assignments
  for update
  using (true)
  with check (true);

create policy if not exists "Public delete"
  on public.seket_assignments
  for delete
  using (true);

