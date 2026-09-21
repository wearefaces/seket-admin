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
- Optional shared storage via Supabase: add `site/config.js` with:

```html
<script>
  window.SUPABASE_URL = 'https://...supabase.co';
  window.SUPABASE_ANON_KEY = 'ey...';
  // Optional — defaults to "assignments"
  window.SUPABASE_TABLE = 'assignments';
</script>
```

The app automatically detects these values and uses the CDN `@supabase/supabase-js` client.

Logos:

- Team logos are mapped by name fragments in `site/assets/team-logos.json`.
- If a logo is missing, the UI falls back to a navy/yellow initials avatar.

Deployment:

- Static files under `site/` (GitHub Pages can be pointed at this folder).
- No build step required.
