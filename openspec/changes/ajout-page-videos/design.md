# Design

## Context

Site Hugo statique : un seul `layouts/index.html` pour l'accueil, un `baseof.html` partagé (header/footer), CSS et JS vanilla. Le menu est défini dans `config.toml` et rendu par `layouts/partials/header.html`. `static/js/main.js` ne gère que le burger et le défilement doux des liens `href^="#"` ; les liens `/#x` ne sont pas interceptés. Voir proposal.md pour la motivation.

## Goals / Non-Goals

**Goals:**
- Page `/videos/` native Hugo, soignée, alimentée uniquement par `data/videos.yaml`.
- Aucun JS ajouté.

**Non-Goals:**
- Pas de récupération automatique des vidéos de la chaîne (pas d'API, pas de clé).
- Pas de façade au clic ni de transition de page.

## Decisions

- **Page Hugo dédiée** (`content/videos.md` + `layouts/videos/single.html`) plutôt qu'une section d'accueil : effet « changement de page » natif, iframes absentes de l'accueil. Alternative écartée : routeur JS (maintenance, non natif).
- **Structure du YAML** : `channel` (name, url) + `playlists[]` (title, url, `videos[]` avec title, youtubeId). Une vidéo appartient à une playlist, ce qui permet d'afficher le lien de la playlist. Alternative écartée : liste plate de vidéos (ne porte pas l'info de playlist).
- **Embed** : `https://www.youtube-nocookie.com/embed/<id>` avec `loading="lazy"`, `allowfullscreen`, `title`, conteneur `aspect-ratio: 16 / 9`. Limite les cookies tiers (RGPD).
- **Mise en page** : bandeau (titre « Vidéos », accroche, bouton vers la chaîne, style `.btn` existant) ; par playlist : `h2` + lien « Voir la playlist » ; grille `repeat(auto-fit, minmax(320px, 1fr))` de cartes (embed + titre) avec le style de carte existant (fond blanc, rayon 8px, ombre teal). Réutilise les couleurs du thème (#3a5a52 / #d4604d).
- **Menu** : entrée `/videos/` ; liens d'ancres déjà en `/#...`, donc valides depuis `/videos/`.

## Risks / Trade-offs

- [Titres des vidéos dupliqués à la main dans le YAML] → acceptable, 2 à quelques dizaines de vidéos.
- [Les iframes YouTube alourdissent la page] → `loading="lazy"` ; une façade pourra être ajoutée plus tard si besoin.
- [Un ID YouTube erroné donne un lecteur en erreur] → vérifier avec `make serve` à chaque ajout.
