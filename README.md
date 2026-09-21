# Seket Admin

Single-page hockey match admin for GitHub Pages.

- https://wearefaces.github.io/seket-admin/ — main app
- https://wearefaces.github.io/seket-admin/sportadmin/ — redirects to the main app

What’s included:

- Dark SvenskHockey-inspired UI (navy background, yellow accents, rounded cards)
- Match cards with home/away hockey team logotypes, flanking the matchup
- Roles: `klocka`, `ovr`, `speaker`, `musik`, `bas1`, `bas2`
- SportAdmin iCal sync (imports only `Match: …`, drops träning/morgonskills)
- Export to CSV

Data storage:

- By default, data is stored in the browser (`localStorage`).
- Optional shared storage via Supabase (live mode): add `site/config.js` with:

```html
<script>
  // Either prefix (SEKET_*) or plain (SUPABASE_*) works:
  window.SEKET_SUPABASE_URL = 'https://<your-project>.supabase.co';
  window.SEKET_SUPABASE_ANON_KEY = '<your-anon-key>';
  // Optional: scope rows to a specific squad so different teams don't mix
  window.SEKET_TEAM = 'U16'; // or 'A-lag', etc.
  // Back-compat fallbacks if you prefer:
  window.SUPABASE_URL = window.SEKET_SUPABASE_URL;
  window.SUPABASE_ANON_KEY = window.SEKET_SUPABASE_ANON_KEY;
</script>
```

Live mode is enabled automatically when both URL and anon key are present.  
The client talks directly to the Supabase REST API (PostgREST) and:
- upserts rows into the `public.seket_assignments` table on edit
- fetches rows on init and after calendar sync
- merges results into the local `assignments` and bumps a revision counter so Alpine updates headers/counters/dots

Logos:

- Team logos are mapped by name fragments in `site/assets/team-logos.json`.
- If a logo is missing, the UI falls back to a navy/yellow initials avatar.

Supabase schema and RLS:

Use the SQL in `supabase/schema.sql` in your Supabase project's SQL editor to create the table and open RLS for the anon role (suitable for a small club on GitHub Pages). It creates:
- `public.seket_assignments` with `match_id text primary key`, optional `team text`, role columns, and `updated_at timestamptz`
- RLS enabled with open policies for select/insert/update/delete
- an index on `team` for the optional filter

Troubleshooting:
- If live writes fail, a visible status banner shows the HTTP error or network error.
- If the page runs without keys, it stays in "Lokalt läge" (local-only) and never attempts cloud writes.
- If you set `SEKET_TEAM`, only rows with that exact `team` value are fetched.

Deployment:

- Static files under `site/` (GitHub Pages can be pointed at this folder).
- No build step required.
