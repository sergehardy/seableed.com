# Spec : Page Radio (/radio/)

## Description

Page Hugo dédiée qui intègre une playlist Spotify du groupe, avec un lien de repli vers Spotify.

## Statut

**Actif**

## Fichiers concernés

- `data/radio.yaml` — titre, intro, playlist (id, url)
- `content/radio.md` — front matter (`title: "Radio"`, `type: radio`)
- `layouts/radio/single.html` — template
- `static/css/style.css` — styles `.radio-hero`, `.radio`, `.radio-player`, `.radio-link`
- `config.toml` — entrée de menu « Radio » (`/radio/`, weight 6)

## Schéma de data/radio.yaml

```yaml
title: string
intro: string
playlist:
  id: string    # valeur après /playlist/ dans l'URL Spotify (sans "?si=...")
  url: string
```

## Comportement

- Même en-tête, menu et pied de page que l'accueil.
- Lecteur Spotify en iframe `https://open.spotify.com/embed/playlist/<id>`, `loading="lazy"`, grand (720 px de haut, 600 px sur mobile) pour que la liste des titres soit bien visible.
- Bouton « Ouvrir sur Spotify » vers `playlist.url`.

## Exigences

- Aucune iframe Spotify sur la page d'accueil.
- Le lecteur SHALL être piloté uniquement par `data/radio.yaml`.
