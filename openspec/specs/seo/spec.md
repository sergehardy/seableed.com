# Spec : SEO et partage

## Description

Métadonnées de `<head>` regroupées dans `layouts/partials/seo.html` : titre, description, canonical, Open Graph, Twitter Card, flux RSS du blog, favicon et données structurées.

## Statut

**Actif**

## Fichiers concernés

- `layouts/partials/seo.html` — toutes les métadonnées
- `layouts/robots.txt` — robots.txt (`enableRobotsTXT = true`)
- `layouts/_default/baseof.html` — inclut le partial
- `config.toml` — `params.homeTitle`, `params.description`
- `assets/images/hero-band-2026.jpeg` — photo du hero, source de l'image de partage 1200×630
- `assets/favicon.ico` — favicon
- `Makefile` — retire `robots.txt` du build de préprod et le contrôle dans `make check`

## Comportement

- Titre : accueil = `params.homeTitle` ; autres pages = « Titre - Seableed ». Description : `description`, sinon `summary`, sinon `params.description`. `canonical` = URL de la page.
- Open Graph et Twitter Card (`summary_large_image`) avec l'image 1200×630 recadrée par Hugo ; `og:type` vaut `article` pour les articles du blog.
- Lien `rel="alternate"` vers `/blog/index.xml`, favicon `rel="icon"`.
- JSON-LD (accueil, production seulement) : `MusicGroup` (réseaux de `data/social.yaml`) et un `Event` par concert dont la date est `jj/mm/aaaa` ; les autres dates sont ignorées sans erreur.
- `robots.txt` en production : `Sitemap: <baseURL>sitemap.xml`, sans `Disallow`. En préprod : aucun `robots.txt`, meta `noindex` et en-tête `X-Robots-Tag`, pas de JSON-LD.

## Exigences

- Chaque page SHALL avoir un titre, une description et un canonical propres.
- Le build de préproduction MUST NOT contenir de `robots.txt` ni de JSON-LD.
