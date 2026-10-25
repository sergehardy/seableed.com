# Spec : Architecture générale

## Vue d'ensemble

Seableed.com est un site statique généré par Hugo, déployé via FTP.
La page d'accueil est mono-page avec navigation par ancres ; une page dédiée `/videos/` (layout `layouts/videos/single.html`) complète le site.

## Flux de génération

```
config.toml          ← paramètres globaux (bandName, email, menus)
content/_index.md    ← contenu Markdown (section À propos)
data/*.yaml          ← données structurées (concerts, social, albums)
        │
        ▼
layouts/_default/baseof.html   ← squelette HTML
layouts/index.html             ← sections de la page d'accueil
layouts/partials/*.html        ← composants réutilisables
        │
        ▼
public/              ← site généré (non versionné)
```

## Sections actives

| Ordre | ID ancre    | Titre        | Source données           |
|-------|-------------|--------------|--------------------------|
| 1     | `#accueil`  | Hero         | `config.toml` params     |
| 2     | `#apropos`  | À propos     | `content/_index.md`      |
| 3     | `#concerts` | Concerts     | `data/concerts.yaml`     |
| 4     | `#contact`  | Contact      | `config.toml` + `data/social.yaml` |

## Sections désactivées / planifiées

| Statut    | ID ancre    | Titre   | Notes                                 |
|-----------|-------------|---------|---------------------------------------|
| Commenté  | `#musique`  | Albums  | HTML et YAML en place, tout commenté  |
| Planifié  | `#videos`   | Vidéos  | À créer (YouTube embed)               |

## Déploiement

```
make serve      → http://localhost:1313 (hot-reload)
make build      → génère public/ (minifié)
make deploy     → build + FTP upload via lftp (requiert .env)
make deploy-dry → simulation sans transfert
```

Les credentials FTP sont dans `.env` (non versionné). Voir `.env.example` pour la structure.

## Assets statiques

- `static/css/style.css` — thème actif, chargé par baseof.html
- `static/css/style-jaune.css` — variante jaune (orpheline, non chargée)
- `static/css/style-vert.css` — doublon du thème principal (orpheline, non chargée)
- `static/js/main.js` — hamburger menu + smooth scroll (vanilla JS)
- `static/images/hero-band.jpg` — photo du groupe (section hero)

## Dépendances externes

- Font Awesome 6.5.1 (CDN) — icônes réseaux sociaux
