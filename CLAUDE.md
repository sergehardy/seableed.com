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

## Conventions

- Langue : **français** (contenu et commits)
- Commits : **Conventional Commits** — `feat:`, `fix:`, `chore:`, `content:`, `docs:`
- Commiter souvent, petits commits atomiques
- Ne pas versionner `public/`, `resources/_gen/`, `.env`, `.idea/`
