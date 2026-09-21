# Seket Admin

Static Seket admin on free GitHub Pages. Works offline in the browser (`localStorage`) and optionally with a shared database via free Supabase (no login UX).

- https://wearefaces.github.io/seket-admin/ — huvudapp (Alpine.js)
- https://wearefaces.github.io/seket-admin/sportadmin/ — SportAdmin matcher (Match-only filter)

If Supabase is not configured, the app falls back to localStorage and shows a banner: “Delad databas ej konfigurerad”.

## Delad databas (gratis Supabase)

This repository supports a single shared Supabase project for the whole club. Everyone with the link can read/write the same assignments (volunteer board style). No user accounts needed.

What you get:
- Shared storage for matchens funktionärer (`klocka`, `ovr`, `speaker`, `musik`, `bas1`, `bas2`)
- RLS is enabled but intentionally open for the anon key (read/write/delete for anyone with the site link)
- Optional `SEKET_TEAM` label to scope rows if you want to separate squads logically

Security tradeoff:
- Using the anon key with open policies means anyone who can load the site can modify assignments.
- Suitable for a small hockey club volunteer workflow. Not suitable for sensitive data.

### Steg för steg (gratisnivån)

1) Skapa ett gratis Supabase-projekt  
   - Gå till `https://supabase.com/`, skapa ett konto och ett nytt projekt (välj EU-region om ni vill).

2) Kör SQL-schemat  
   - Öppna SQL Editor i Supabase.  
   - Kör innehållet i `supabase/schema.sql` från detta repo för att skapa tabell och öppna RLS-policies.

3) Hämta URL och anon key  
   - I Supabase: Settings → API → Project URL och `anon` public key.

4) Lägg in i `site/config.js`  
   - Kopiera `site/config.example.js` till `site/config.js`.  
   - Fyll i:
     ```js
     window.SEKET_SUPABASE_URL = "https://<your-project-id>.supabase.co";
     window.SEKET_SUPABASE_ANON_KEY = "<anon-key>";
     window.SEKET_TEAM = ""; // valfri etikett, t.ex. "A-lag"
     ```
   - Lämnar du dem tomma körs appen i offline-läge (localStorage) och visar bannern “Delad databas ej konfigurerad”.

5) Commit & push  
   - Lägg till, committa och pusha ändringarna (GitHub Pages workflow deployar `site/` katalogen).

## Hur det funkar

- Båda sidorna (`site/index.html` och `site/sportadmin/index.html`) laddar in `site/config.js`.  
- Om Supabase är konfigurerat:
  - Vid start hämtas befintliga assignments från `seket_assignments` (filtrerat på `SEKET_TEAM` om satt).
  - När du ändrar en roll sparas det både i Supabase (upsert) och i `localStorage`.
- Om Supabase inte är konfigurerat:
  - Allt sparas enbart i `localStorage`.  
  - En kort banner visas med texten “Delad databas ej konfigurerad”.

## SportAdmin-kalender

- Kalenderhämtningen använder en fri proxy och filtrerar bort icke-matchhändelser (träning/morgonskills/etc.), behåller bara matcherna.

## Lokal utveckling

Det är en statisk sajt – öppna filerna under `site/` med en enkel statisk server eller via GitHub Pages. Ingen backend krävs utöver Supabase när delad databas används.

