# Design

## Context

Le `<head>` de `layouts/_default/baseof.html` ne contient que `title`, `meta description` (une valeur globale) et, en préprod, la meta `noindex`. Hugo génère déjà `sitemap.xml` et le RSS du blog (`[outputs]` : RSS seulement pour les sections). L'image du hero (`static/images/hero-band-2026.jpeg`, 1600×1068) n'est pas traitée par Hugo. Voir proposal.md.

## Goals / Non-Goals

**Goals:**
- Un seul partial `layouts/partials/seo.html` regroupe toutes les métadonnées.
- Aucun JavaScript ni service externe ajouté.

**Non-Goals:**
- Pas d'analytics, pas de balises de suivi, pas de bandeau de consentement.
- Pas de gestion multilingue (`hreflang`).
- Pas de génération d'un flux RSS pour l'accueil ou les autres pages.

## Decisions

- **Partial `seo.html`** inclus dans `<head>` : `title` (page d'accueil : `params.homeTitle`), `description` (`.Params.description`, sinon `.Params.summary` pour le blog, sinon `.Site.Params.description`), `canonical` (`.Permalink`), Open Graph (`og:title`, `og:description`, `og:url`, `og:type` `website` ou `article`, `og:image`, `og:locale`), Twitter Card `summary_large_image`.
- **Image de partage** : l'image du hero est déplacée dans `assets/images/` pour que `resources.Get` + `.Fill "1200x630 Smart"` produise un JPEG de partage ; le hero CSS continue de pointer vers sa copie publiée (le fond reste en CSS, donc la photo reste aussi dans `static/` ou est copiée via `resources.Copy`). À trancher à l'implémentation : conserver `static/images/hero-band-2026.jpeg` et ajouter une seconde référence dans `assets/` est exclu (doublon) ; on déplace donc le fichier et on publie le hero via `resources.Get` dans le CSS inline ou `resources.Copy`. Alternative écartée : image de partage créée à la main (non reproductible).
- **JSON-LD** : bloc `<script type="application/ld+json">` sur l'accueil uniquement. `MusicGroup` avec `name`, `url`, `genre`, `location`, `sameAs` (liens de `data/social.yaml`) ; `Event` par concert, avec `startDate` convertie depuis `jj/mm/aaaa` par `time.AsTime` après découpage de la chaîne (les dates illisibles sont ignorées sans erreur), `location` (`venue`, `location`), `performer` ; `eventStatus`/`offers` omis (pas d'info de billetterie fiable).
- **robots.txt** : `enableRobotsTXT = true` et `layouts/robots.txt` : `User-agent: *` + `Sitemap: {{ "sitemap.xml" | absURL }}`, sans `Disallow`. En préprod, le Makefile supprime `public/robots.txt` après le build (inutile dans un sous-répertoire), et `make check` vérifie présence en prod et absence en préprod. Alternative écartée : fichier statique (l'URL du sitemap serait codée en dur).
- **RSS** : `<link rel="alternate" type="application/rss+xml" title="Blog Seableed" href="{{ "blog/index.xml" | absURL }}">` dans le partial.
- **Favicon** : `static/favicon.ico` + `<link rel="icon">`, dès qu'une image est fournie ; sinon cette tâche est reportée sans bloquer le reste.
- **Actions manuelles** : documentées dans le README (Search Console, Bing, liens depuis les bios des réseaux sociaux, test d'aperçu Facebook) car elles ne se font pas en code.

## Risks / Trade-offs

- [Dates des concerts en texte libre] → seules les dates `jj/mm/aaaa` donnent un `Event`, les autres sont ignorées silencieusement ; à terme, passer à un champ date ISO dans `concerts.yaml`.
- [`Event` de concerts passés] → les concerts passés restent des `Event` valides (date passée) ; aucun filtre n'est nécessaire.
- [Déplacer la photo du hero casse le fond du hero] → vérifier le rendu du hero et l'aperçu `og:image` avant de committer ; si le déplacement gêne, utiliser `resources.GetMatch` sur `static/` via un montage Hugo (`module.mounts`) en dernier recours.
- [Un `robots.txt` publié en préprod serait ignoré mais créerait de la confusion] → supprimé par le Makefile en préprod.
- [Les images d'aperçu sont mises en cache par Facebook et WhatsApp] → une mise à jour de l'image peut prendre du temps à apparaître ; le débogueur de partage Facebook force le rafraîchissement.
