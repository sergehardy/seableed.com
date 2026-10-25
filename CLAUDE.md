# seableed.com

Site statique Hugo pour le groupe de rock Seableed (Rennes, France). Page d'accueil avec navigation par ancres, plus des pages dédiées `/videos/`, `/radio/` et `/blog/`.

## Commandes

```bash
make serve       # Serveur local http://localhost:1313 (hot-reload, sans brouillons)
make serve DEBUG=true   # avec brouillons (draft: true) et articles à date future
make serve LAN=true     # écoute sur 0.0.0.0 (test mobile en wifi), baseURL = http://<IP locale>:1313
make build       # Génère public/ (minifié, nettoie les anciens fichiers)
make check       # Build + vérifie que public/ ne contient que le site
make deploy      # Check + upload SFTP via lftp (requiert .env)
# build/check/deploy/deploy-dry/ftp acceptent ENV=prod|preprod (prod par défaut), ex. make deploy ENV=preprod
make deploy-dry  # Simule le déploiement
make clean       # Supprime public/ et resources/_gen/
```

Le déploiement lit les variables depuis `.env` (non versionné, voir `.env.example`).

## Structure

```
layouts/
  _default/baseof.html   Base HTML (bloc collant .site-top : menu + pellicule, footer)
  index.html             Page d'accueil (sections hero, apropos, concerts, contact)
  videos/single.html     Page /videos/
  radio/single.html      Page /radio/
  blog/                  list.html (liste paginée) et single.html (article)
  partials/
    header.html          Navigation responsive
    footer.html          Pied de page
    pellicule.html       Bande de photos (picture bureau/mobile)
    pellicule-bande.html Assemble une bande unique à partir des photos

content/
  _index.md              Texte À propos
  videos.md, radio.md    Pages dédiées (front matter seulement)
  blog/                  Articles Markdown

data/
  concerts.yaml, social.yaml, videos.yaml, radio.yaml
  albums.yaml            Albums (désactivés pour l'instant)

assets/pellicule/        Photos sources de la pellicule (jamais publiées telles quelles)
assets/images/           Photo du hero (publiée + image de partage 1200x630)
assets/favicon.ico       Favicon

static/                  Copié tel quel dans public/
  css/style.css          Thème principal (teal/rust)
  js/main.js             Menu mobile + smooth scroll
  .htaccess              Redirection HTTPS

themes-alternatifs/      Anciennes variantes CSS (non chargées, non publiées)
```

## Sections et ancres

| Ancre        | Section      | Source données           | Statut    |
|--------------|--------------|--------------------------|-----------|
| `#accueil`   | Hero         | `config.toml` params     | actif     |
| `#apropos`   | À propos     | `content/_index.md`      | actif     |
| `#actualites`| Actualités   | dernier article de `content/blog/` | actif |
| `#concerts`  | Concerts     | `data/concerts.yaml`     | actif     |
| `#contact`   | Contact      | `config.toml` + `data/social.yaml` | actif |
| `/radio/`    | Page Radio   | `data/radio.yaml`        | actif (page dédiée) |
| `/blog/`     | Blog         | `content/blog/*.md`      | actif (page dédiée) |
| `#musique`   | Albums       | `data/albums.yaml`       | commenté  |
| `/videos/`   | Page Vidéos  | `data/videos.yaml`       | actif (page dédiée) |

## Visibilité

`layouts/partials/seo.html` (inclus dans `baseof.html`) : titre et description par page (front matter `description`/`summary`, sinon `[params]`), canonical, Open Graph et Twitter (image 1200×630 Hugo depuis `assets/images/hero-band-2026.jpeg`), lien RSS du blog, favicon (`assets/favicon.ico`), JSON-LD `MusicGroup` + `Event` sur l'accueil en production (concerts `jj/mm/aaaa`).
`robots.txt` (`layouts/robots.txt`) seulement en production (sitemap, sans `Disallow`) ; la préprod garde `noindex` et n'a ni robots.txt ni JSON-LD. Actions manuelles : voir README.

## Pellicule de photos

Photos sources dans `assets/pellicule/` (JPG/PNG, ≥ 800 px de large, ordre alphabétique : préfixer `01-`, `02-`…).
Hugo les assemble au build en **une seule image** (bande bureau + bande mobile, presque noir et blanc, traits blancs),
affichée sous le menu sur toutes les pages et collée avec lui. Pour changer les photos : modifier le dossier,
`make serve` (et `make clean` si une ancienne bande reste en cache), puis `make check` et `make deploy`.
Sans photo, la pellicule n'apparaît pas.

## Préproduction

Sous-répertoire `www/preprod/` (`https://www.seableed.com/preprod/`), choisi avec `ENV=preprod` (variables `.env` : `PREPROD_FTP_PATH`, `PREPROD_URL`).
Le build préprod ajoute `noindex, nofollow` (meta + en-tête `X-Robots-Tag` dans `.htaccess`), pas de `robots.txt`.
Le déploiement de production exclut `preprod/` du miroir. Les liens du menu passent par `relURL`.

## Déploiement

Seul le contenu de `public/` est envoyé (SFTP, `mirror --delete`). Les photos originales, `resources/_gen/`, `themes-alternatifs/`
et les sources ne doivent jamais y être. `make check` échoue si `public/` contient un png, jpg, md ou yaml.
Toujours lancer `make deploy-dry` avant `make deploy`.

## Blog

Articles en Markdown dans `content/blog/` (liste paginée, 5 par page via `paginate` dans `config.toml`).
Le dernier article publié s'affiche aussi sur l'accueil (section `#actualites`, masquée sans article).
Article avec images = dossier `content/blog/<nom>/index.md` + photos (rendu `layouts/_default/_markup/render-image.html` : 1200 px max, WebP ; originaux non publiés via `cascade.build.publishResources: false` dans `content/blog/_index.md`). Vidéo : shortcode `{{< youtube ID >}}` (nocookie). HTML brut non rendu. Guide complet : README « Rédiger un article ».
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
  Les variantes `style-jaune.css` et `style-vert.css` sont rangées dans `themes-alternatifs/` (non chargées, non publiées).
- La section À propos est la **seule section pilotée par du Markdown** (`content/_index.md`),
  pas par un data file YAML.
- Font Awesome 6.5.1 est chargé via CDN dans `baseof.html`.

## Conventions

- Langue : **français** (contenu et commits)
- Commits : **Conventional Commits** — `feat:`, `fix:`, `chore:`, `content:`, `docs:`
- **Claude fait les commits git lui-même**, souvent, en commits atomiques
- Ne pas versionner `public/`, `resources/_gen/`, `.env`, `.idea/`

## OpenSpec

Les specs de chaque section sont dans `openspec/specs/` ; les changements terminés dans `openspec/changes/archive/`.
Pour proposer un changement : `/openspec-propose` ou `/opsx:propose`.
