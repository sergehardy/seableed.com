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
| `#musique`   | Albums       | `data/albums.yaml`       | commenté  |
| `#videos`    | Vidéos       | `data/videos.yaml`       | planifié  |

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
