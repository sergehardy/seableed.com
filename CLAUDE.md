# seableed.com

Site statique Hugo pour le groupe de rock Seableed (Rennes, France). Site mono-page avec navigation par ancres.

## Commandes

```bash
make serve       # Serveur local http://localhost:1313 (hot-reload, drafts inclus)
make build       # Génère public/ (minifié)
make deploy      # Build + upload FTP via lftp (requiert .env)
make deploy-dry  # Simule le déploiement
make clean       # Supprime public/ et resources/_gen/
```

Le déploiement lit les variables depuis `.env` (non versionné, voir `.env.example`).

## Structure

```
layouts/
  _default/baseof.html   Base HTML (head, nav, footer)
  index.html             Page d'accueil (sections hero, concerts, apropos, contact)
  partials/
    header.html          Navigation responsive
    footer.html          Pied de page

data/
  concerts.yaml          Dates de concerts
  social.yaml            Liens réseaux sociaux
  albums.yaml            Albums (désactivés pour l'instant)

static/
  css/style.css          Thème principal (teal/rust)
  js/main.js             Menu mobile + smooth scroll
```

## Sections et ancres

| Ancre        | Section      | Source données           | Statut    |
|--------------|--------------|--------------------------|-----------|
| `#accueil`   | Hero         | `config.toml` params     | actif     |
| `#apropos`   | À propos     | `content/_index.md`      | actif     |
| `#concerts`  | Concerts     | `data/concerts.yaml`     | actif     |
| `#contact`   | Contact      | `config.toml` + `data/social.yaml` | actif |
| `/radio/`    | Page Radio   | `data/radio.yaml`        | actif (page dédiée) |
| `/blog/`     | Blog         | `content/blog/*.md`      | actif (page dédiée) |
| `#musique`   | Albums       | `data/albums.yaml`       | commenté  |
| `/videos/`   | Page Vidéos  | `data/videos.yaml`       | actif (page dédiée) |

## Pellicule de photos

Photos sources dans `assets/pellicule/` (≤ 2000 px de large, nommées `01-…`, `02-…` pour fixer l'ordre).
Hugo génère les miniatures WebP 400×300 au build (`layouts/partials/pellicule.html`), affichées sous le hero.
Le texte alternatif est déduit du nom de fichier. Sans photo, la pellicule n'apparaît pas.

## Blog

Articles en Markdown dans `content/blog/` (liste paginée, 5 par page via `paginate` dans `config.toml`).
Front matter : `title`, `date`, `summary` (optionnel, sinon résumé automatique), `draft: true` pour ne pas publier.

## Schémas des data files

```yaml
# data/concerts.yaml
- date: string        # ex: "15 Nov 2025"
  venue: string       # nom de la salle
  location: string    # ville, pays
  ticketLink: string  # URL complète ou "#"

# data/social.yaml
- name: string        # ex: "Instagram"
  url: string         # URL complète
  icon: string        # classe Font Awesome, ex: "fa-brands fa-instagram"

# data/videos.yaml
channel:
  name: string        # libellé du bouton
  url: string         # URL de la chaîne
playlists:
  - title: string
    url: string       # URL de la playlist
    videos:
      - title: string
        youtubeId: string  # valeur après "v=" dans l'URL

# data/radio.yaml
title: string
intro: string
playlist:
  id: string          # valeur après /playlist/ dans l'URL Spotify
  url: string         # URL de la playlist

# data/albums.yaml (désactivé — tout commenté)
- title: string
  year: number
  cover: string
  link: string
```

## Points d'attention

- Le thème CSS actif est **hardcodé** dans `baseof.html` (`style.css`).
  Les fichiers `style-jaune.css` et `style-vert.css` existent mais ne sont pas chargés.
- La section À propos est la **seule section pilotée par du Markdown** (`content/_index.md`),
  pas par un data file YAML.
- Font Awesome 6.5.1 est chargé via CDN dans `baseof.html`.

## Conventions

- Langue : **français** (contenu et commits)
- Commits : **Conventional Commits** — `feat:`, `fix:`, `chore:`, `content:`, `docs:`
- **Claude fait les commits git lui-même**, souvent, en commits atomiques
- Ne pas versionner `public/`, `resources/_gen/`, `.env`, `.idea/`

## OpenSpec

Les specs de chaque section sont dans `openspec/specs/`.
Pour proposer un changement : `/openspec-propose` ou `/opsx:propose`.
