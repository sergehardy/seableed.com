# Proposal

## Why

Le site sert à démarcher salles et organisateurs, mais il se présente mal hors de ses pages : l'aperçu d'un lien partagé (Facebook, WhatsApp, e-mail) est pauvre, toutes les pages ont la même description, le sitemap n'est signalé à aucun moteur et le flux RSS du blog n'est pas détectable. Des améliorations simples rendent le groupe plus facile à trouver et à partager.

## What Changes

- Nouveau partial de `<head>` (absent aujourd'hui) : titre et description propres à chaque page, `canonical`, balises Open Graph et Twitter Card, avec une image de partage 1200×630 générée par Hugo depuis la photo du hero.
- Titre de l'accueil plus parlant (« Seableed – groupe de rock à Rennes ») au lieu de « Accueil - Seableed ».
- Données structurées JSON-LD sur l'accueil : le groupe (`MusicGroup`, liens des réseaux sociaux) et ses concerts (`Event`) quand la date est lisible.
- `robots.txt` de production avec l'adresse du sitemap, sans `Disallow` ; le sitemap existant est conservé.
- `<link rel="alternate" type="application/rss+xml">` vers le flux du blog, dans le `<head>`.
- Favicon (une fois l'image disponible).
- Documentation des actions manuelles (Google Search Console, Bing Webmaster Tools, liens depuis les réseaux sociaux) dans le README.

## Capabilities

### New Capabilities
- `seo`: métadonnées par page, aperçus de partage, données structurées, robots.txt, découverte du flux RSS et favicon.

### Modified Capabilities

## Impact

- Data files YAML : `data/concerts.yaml` est lu pour générer les `Event` (aucun champ ajouté ; seules les dates au format `jj/mm/aaaa` donnent un `Event`) ; `data/social.yaml` alimente `sameAs`.
- Code : `layouts/partials/seo.html` (nouveau), `layouts/_default/baseof.html`, `layouts/robots.txt`, `config.toml` (description, `enableRobotsTXT`, image de partage), éventuel déplacement de la photo du hero dans `assets/` pour la recadrer.
- Docs/specs : `README.md`, `CLAUDE.md`, spec `seo` (nouvelle), spec `architecture`.
- Préproduction : conserve son `noindex` et n'a pas de `robots.txt` ni de JSON-LD.
