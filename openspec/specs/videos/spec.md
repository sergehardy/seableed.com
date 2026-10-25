# Spec : Page Vidéos (/videos/)

## Description

Page Hugo dédiée (pas une section de l'accueil) présentant les vidéos YouTube du groupe.
Page importante : c'est celle utilisée pour démarcher salles et organisateurs.

## Statut

**Actif**

## Fichiers concernés

- `data/videos.yaml` — contenu (chaîne, playlists, vidéos)
- `content/videos.md` — front matter (`title: "Vidéos"`, `type: videos`)
- `layouts/videos/single.html` — template de la page
- `static/css/style.css` — styles `.videos-hero`, `.playlist`, `.videos`, `.video`, `.video-embed`
- `config.toml` — entrée de menu « Vidéos » (`/videos/`, weight 5)

## Schéma de data/videos.yaml

```yaml
channel:
  name: string        # libellé du bouton vers la chaîne
  url: string         # https://www.youtube.com/@seableed
playlists:
  - title: string
    url: string       # URL de la playlist YouTube
    videos:
      - title: string
        youtubeId: string  # valeur après "v=" dans l'URL
```

Ajouter une vidéo : ajouter `title` + `youtubeId` dans la playlist. Nouvelle playlist : nouveau bloc avec `title`, `url`, `videos`.

## Comportement

- Le même en-tête, menu et pied de page que l'accueil.
- Bandeau avec le titre et un bouton vers la chaîne YouTube.
- Une rubrique par playlist : titre, lien « Voir la playlist », grille de cartes (embed + titre).
- Embeds via `youtube-nocookie.com`, `loading="lazy"`, ratio 16/9 ; aucune iframe sur l'accueil.
- Grille `auto-fit, minmax(320px, 1fr)` ; une colonne sous 768 px.

## Exigences

- La page SHALL être générée uniquement à partir de `data/videos.yaml`.
- Les vidéos SHALL utiliser `youtube-nocookie.com` avec chargement différé.
- La page d'accueil MUST NOT charger d'iframe YouTube.
