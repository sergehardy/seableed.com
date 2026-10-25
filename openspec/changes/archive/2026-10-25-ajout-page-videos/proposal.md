# Proposal

## Why

Le site n'a aucune vidéo, alors que la page Vidéos est l'outil principal pour démarcher (salles, organisateurs). Il faut une page soignée, facile à alimenter, qui présente les captations du groupe et renvoie vers la chaîne et les playlists YouTube.

## What Changes

- Nouvelle page native Hugo `/videos/` (pas une section de la page d'accueil, absente aujourd'hui du HTML), avec le même en-tête et pied de page que l'accueil.
- Mise en page : bandeau de titre avec bouton vers la chaîne YouTube, puis une rubrique par playlist (titre + lien « Voir la playlist ») contenant une grille de vidéos intégrées.
- Contenu piloté par un nouveau data file `data/videos.yaml` (chaîne, playlists, vidéos), initialisé avec « Fortunate son » et « Lonely boy » (playlist « Fête de la musique 2026 »).
- Embeds via `youtube-nocookie.com`, chargés en différé (`loading="lazy"`), uniquement sur la page `/videos/`.
- Nouvelle entrée « Vidéos » dans le menu principal, qui pointe vers `/videos/`.
- Le site n'est plus strictement mono-page : le menu mélange ancres de l'accueil et une page dédiée.

## Capabilities

### New Capabilities

### Modified Capabilities
- `videos`: de « planifié » à actif : page `/videos/`, data file `data/videos.yaml`, rubriques par playlist, liens chaîne/playlist, embeds différés et sans cookies.
- `navigation`: ajout d'un lien de menu vers une page dédiée (`/videos/`) en plus des ancres de l'accueil.

## Impact

- Data files YAML : nouveau `data/videos.yaml` (schéma : `channel`, `playlists[].videos[]`).
- Code : `content/videos.md`, `layouts/videos/single.html`, `config.toml` (menu), `static/css/style.css` (styles de la page).
- Specs et docs à mettre à jour : `openspec/specs/videos`, `navigation`, `architecture`, `CLAUDE.md`, `openspec/config.yaml`.
- Dépendance externe : iframes YouTube (domaine `youtube-nocookie.com`).
