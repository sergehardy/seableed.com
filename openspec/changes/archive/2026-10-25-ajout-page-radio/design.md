# Design

## Context

Même schéma que la page Vidéos : page Hugo dédiée (`content/<nom>.md` avec `type`, `layouts/<nom>/single.html`), contenu piloté par `data/`, menu dans `config.toml`. Voir proposal.md.

## Goals / Non-Goals

**Goals:**
- Page `/radio/` native, alimentée par `data/radio.yaml`, sans JS.

**Non-Goals:**
- Pas de lecteur audio maison, pas d'API Spotify, pas de gestion de consentement dédiée.

## Decisions

- **Embed iframe Spotify** `https://open.spotify.com/embed/playlist/<id>` (`loading="lazy"`, `allow="encrypted-media"`, hauteur 352 px) : solution officielle, sans clé. Alternative écartée : simple lien (moins engageant).
- **Lien de repli** affiché sous le lecteur, depuis `playlist.url`.
- **Schéma YAML** :
  ```yaml
  title: "Radio Seableed"
  intro: "Notre sélection du moment."
  playlist:
    id: "<ID_PLAYLIST>"   # valeur après /playlist/ dans l'URL Spotify
    url: "https://open.spotify.com/playlist/<ID_PLAYLIST>"
  ```
  L'identifiant réel de la playlist du groupe sera fourni par l'utilisateur à l'implémentation.
- **Menu** : weight 6 (après Vidéos 5), Contact passe à 8 pour laisser la place au Blog (7).

## Risks / Trade-offs

- [L'iframe Spotify dépose des cookies tiers] → page dédiée, iframe absente de l'accueil ; mention possible de la politique de confidentialité plus tard.
- [Playlist supprimée ou privée] → le lecteur affichera une erreur ; vérifier avec `make serve`.
