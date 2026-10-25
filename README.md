# seableed.com

Site statique [Hugo](https://gohugo.io/) du groupe de rock Seableed (Rennes). La page d'accueil a une navigation par ancres (À propos, Concerts, Contact) et le site compte trois pages dédiées : `/videos/`, `/radio/` et `/blog/`. Une pellicule de photos est collée sous le menu sur toutes les pages.

## Pour reprendre le projet

### Prérequis

Il faut Hugo en version étendue (testé avec 0.123.7, la version étendue est nécessaire pour la pellicule) et `lftp` pour le déploiement. Le fichier `.env` n'est pas versionné : on le crée à partir de `.env.example` avec les identifiants SFTP (les mêmes que dans FileZilla).

```bash
cp .env.example .env   # puis renseigner FTP_HOST, FTP_USER, FTP_PASS, FTP_PATH (et PREPROD_FTP_PATH, PREPROD_URL)
```

### Commandes

```bash
make serve       # http://localhost:1313, hot-reload, comme en production (sans brouillons)
make serve DEBUG=true   # idem avec les brouillons (draft: true) et les articles à date future
make serve LAN=true     # accessible depuis un mobile du même wifi (affiche l'adresse http://IP:1313/)
make build       # génère public/ (minifié, supprime les anciens fichiers)
make check       # build + vérifie que public/ ne contient que le site
make deploy-dry  # simule le déploiement SFTP (à lancer avant deploy)
make deploy      # check + upload SFTP (attention : mirror --delete)
make ftp         # session SFTP interactive (cd dans le dossier de l'environnement)
make clean       # supprime public/ et resources/_gen/
```

`make serve DEBUG=true|false` (défaut `false`) choisit d'afficher ou non les brouillons.

`build`, `check`, `deploy`, `deploy-dry` et `ftp` acceptent `ENV=prod` (défaut) ou `ENV=preprod`. Toute autre valeur est refusée.

`make deploy` utilise `mirror --reverse --delete` : tout fichier distant absent de `public/` est supprimé. Lance toujours `make deploy-dry` d'abord et relis la liste.

Hébergement OVH : le déploiement se fait en SFTP (SSH, port 22), comme FileZilla. Le FTP classique d'OVH refuse par intermittence la connexion de données. `FTP_PATH` doit valoir `www/` (chemin relatif au dossier du compte : en SFTP, `/www` n'existe pas).

## Préproduction

Le multisite OVH n'est pas disponible : la préprod est un sous-répertoire du même hébergement, `www/preprod/`, donc `https://www.seableed.com/preprod/`.

```bash
make deploy-dry ENV=preprod   # simule, à relire
make deploy ENV=preprod       # construit avec le baseURL de la préprod et envoie dans www/preprod/
curl -I https://www.seableed.com/preprod/ | grep -i x-robots-tag   # doit afficher noindex, nofollow
make deploy-dry               # production : preprod/ est exclu du miroir, jamais supprimé
make deploy                   # puis, une fois la préprod validée
```

- Variables dans `.env` : `PREPROD_FTP_PATH=www/preprod/` et `PREPROD_URL=https://www.seableed.com/preprod/`.
- Le build préprod ajoute `<meta name="robots" content="noindex, nofollow">` à chaque page et l'en-tête `X-Robots-Tag` au `.htaccess` (module Apache `mod_headers`). Pas de `robots.txt` : il n'est lu qu'à la racine du domaine, et un `Disallow` empêcherait les robots de lire le `noindex`.
- La préprod reste accessible par son URL (pas de mot de passe).
- Le déploiement de production exclut `preprod/` du miroir : sans cela, `mirror --delete` l'effacerait.
- Les liens du menu suivent le `baseURL` (`relURL`) pour fonctionner dans le sous-répertoire.
- La sortie de `deploy` masque le mot de passe SFTP.

## Visibilité (SEO et partage)

- **Par page** : le titre et la description viennent du front matter (`description:`, ou `summary:` pour un article de blog), sinon de `[params]` dans `config.toml`. L'accueil utilise `homeTitle`. Chaque page a un `canonical`.
- **Aperçu de partage** (Facebook, WhatsApp, e-mail) : balises Open Graph et Twitter Card avec une image 1200×630 générée par Hugo depuis `assets/images/hero-band-2026.jpeg`.
- **Données structurées** (accueil, production seulement) : le groupe (`MusicGroup`, liens de `data/social.yaml`) et un `Event` par concert dont la date est au format `jj/mm/aaaa`. Une date d'un autre format est ignorée sans erreur.
- **robots.txt** (production seulement) : annonce `sitemap.xml`, sans aucune interdiction. Le sitemap est généré par Hugo.
- **RSS** : le flux du blog est `/blog/index.xml`, déclaré dans le `<head>` de toutes les pages.
- **Favicon** : `assets/favicon.ico`.

À faire à la main, une fois le site en production :

1. Ajouter le site dans [Google Search Console](https://search.google.com/search-console) et [Bing Webmaster Tools](https://www.bing.com/webmasters), puis soumettre `https://www.seableed.com/sitemap.xml`.
2. Mettre l'adresse du site dans les bios Instagram, Facebook, YouTube et Spotify : ces liens vers le site aident le plus le référencement.
3. Tester l'aperçu d'une page dans le [débogueur de partage Facebook](https://developers.facebook.com/tools/debug/) (il force aussi le rafraîchissement du cache d'image).

Avant de déployer, arrêter `make serve` : un serveur Hugo en marche peut réécrire `public/` avec des adresses `localhost`.

## Ce qui est déployé (et ce qui ne l'est pas)

Seul le contenu de `public/` part en production. `make check` le reconstruit et échoue s'il y trouve un `png`, `jpg`, `md` ou `yaml` (ou, selon l'environnement, un `noindex` en production ou son absence en préprod), puis liste les fichiers.

- **Publié** : le HTML des pages, `sitemap.xml`, `robots.txt` (production seulement), `favicon.ico`, le flux RSS du blog, `.htaccess`, `css/style.css`, `js/main.js`, `images/hero-band-2026.jpeg`, l'image de partage 1200×630 et les deux bandes de la pellicule (`pellicule/bande-bureau.<hash>.webp` et `bande-mobile.<hash>.webp`).
- **Jamais publié** : les photos originales de `assets/pellicule/`, le cache `resources/_gen/`, `themes-alternatifs/`, les fichiers `data/`, `content/` et `openspec/`.

## Mises à jour courantes

Chaque page a sa source de données. Dans tous les cas, on vérifie avec `make serve` avant de déployer.

| Je veux…                         | Je modifie                              | Remarque                                              |
|----------------------------------|-----------------------------------------|-------------------------------------------------------|
| Ajouter ou retirer un concert    | `data/concerts.yaml`                    | L'ordre du YAML est l'ordre affiché. Supprimer ou commenter les dates passées. |
| Concert sans billetterie         | `ticketLink: "#"` dans `concerts.yaml`  | Le bouton « Infos » s'affiche quand même.             |
| Changer le texte « À propos »    | `content/_index.md`                     | Markdown.                                             |
| Ajouter un réseau social         | `data/social.yaml`                      | Icône = classe Font Awesome 6.5.1 (ex. `fa-brands fa-instagram`). |
| Ajouter une vidéo                | `data/videos.yaml`                      | Voir ci-dessous.                                      |
| Changer la playlist de la radio  | `data/radio.yaml`                       | `playlist.id` = valeur après `/playlist/` dans l'URL Spotify, sans `?si=…`. |
| Publier un article               | `content/blog/mon-article.md`           | Voir ci-dessous.                                      |
| Changer les photos de la pellicule | `assets/pellicule/`                   | Voir ci-dessous.                                      |
| Changer nom, genre, ville, email | `config.toml` (section `[params]`)      | Alimente le hero et le contact.                       |
| Ajouter un item de menu          | `config.toml` (`[[menu.main]]`)         | Ordre par `weight`. Une ancre = `/#section`, une page = `/page/`. |
| Changer les couleurs             | `static/css/style.css`                  | Thème teal `#3a5a52` / rust `#d4604d`.                |

### Ajouter une vidéo

`data/videos.yaml` contient la chaîne et des playlists, chacune avec ses vidéos. `youtubeId` est la valeur après `v=` dans l'URL de la vidéo.

```yaml
channel:
  name: "Seableed sur YouTube"
  url: "https://www.youtube.com/@seableed"
playlists:
  - title: "Fête de la musique 2026"
    url: "https://www.youtube.com/playlist?list=…"
    videos:
      - title: "Fortunate son"
        youtubeId: "vudTL8M3hqk"
```

Les vidéos sont intégrées via `youtube-nocookie.com`, chargées en différé.

### Publier un article de blog

La marche à suivre complète (photos, légendes, vidéos YouTube) est dans « Rédiger un article » ci-dessous. Version courte, pour un article sans image : créer un fichier Markdown dans `content/blog/` :

```markdown
---
title: "Titre de l'article"
date: 2026-11-01
summary: "Une phrase pour la liste (facultatif)."
draft: false   # true : non publié par make build (visible avec make serve DEBUG=true)
---

Texte de l'article en Markdown.
```

La liste `/blog/` est paginée par 5 (`paginate` dans `config.toml`). Un article daté dans le futur n'est pas publié. Le dernier article publié (date la plus récente) s'affiche aussi sur l'accueil, dans la section « Actualités » ; elle disparaît s'il n'y a aucun article publié.

### Rédiger un article (photos, vidéos YouTube)

**1. Créer l'article.** Un article avec des images est un *dossier* (un « bundle » Hugo) qui contient `index.md` et ses photos :

```bash
hugo new content blog/mon-article     # crée content/blog/mon-article/index.md (brouillon)
```

Copier ensuite les photos dans `content/blog/mon-article/` (JPG ou PNG, tailles d'origine acceptées). Pour ajouter des images à un article déjà écrit en fichier seul (`content/blog/concert.md`), le déplacer : `content/blog/concert/index.md`.

**2. Écrire le Markdown** dans `index.md`, sous le front matter :

````markdown
---
title: "Concert à Cesson"
date: 2026-07-01
summary: "Une phrase pour la liste et l'accueil."
draft: false        # true : brouillon, non publié
---

Texte du paragraphe. **Gras**, *italique*, [un lien](https://www.youtube.com/@seableed).

## Un titre de partie

- une liste
- à puces

![Description de la photo](photo-scene.jpg)

![Avec légende](photo-groupe.jpg "Légende affichée sous la photo")

{{< youtube vudTL8M3hqk >}}
````

- **Photos** : `![description](nom-du-fichier.jpg)`, le fichier étant dans le même dossier que `index.md`. Le texte entre crochets est la description (accessibilité) ; un texte entre guillemets après le nom devient la légende. Hugo réduit chaque photo à 1200 px de large maximum et la convertit en WebP : seules ces versions réduites sont publiées, jamais les originaux.
- **Vidéo YouTube** : `{{< youtube ID >}}`, où l'ID est la valeur après `v=` dans l'adresse de la vidéo (par exemple `vudTL8M3hqk` pour `https://www.youtube.com/watch?v=vudTL8M3hqk`). La vidéo est intégrée via `youtube-nocookie.com`. Pour démarrer à un instant : `{{< youtube id="vudTL8M3hqk" start="30" >}}` (en secondes).
- **Pas de HTML brut** : une balise `<iframe>` ou `<img>` écrite à la main est ignorée sans message. Utiliser le Markdown et le shortcode ci-dessus.
- **Playlist ou chaîne** : pas d'embed de playlist ; mettre un lien Markdown vers la playlist.

**3. Contrôler** avec `make serve DEBUG=true` (les brouillons sont visibles), puis passer `draft: false`. L'article le plus récent apparaît aussi sur l'accueil (section « Actualités »). Un article daté dans le futur n'est publié qu'à sa date.

**4. Publier** : `make check`, puis `make deploy-dry ENV=preprod` / `make deploy ENV=preprod`, puis la production (voir « Préproduction »). `make check` échoue si un original (jpg, png) se retrouve dans `public/`.

### Changer les photos de la pellicule

La pellicule est une **image unique** assemblée par Hugo à partir de `assets/pellicule/`. Il n'y a aucune commande spécifique : elle est reconstruite à chaque `make serve` ou `make build`.

1. Remplacer ou ajouter des photos (JPG ou PNG, 800 px de large ou plus conseillés) dans `assets/pellicule/`. L'ordre est l'ordre alphabétique : préfixer `01-`, `02-`, etc.
2. Lancer `make serve` et regarder le haut de la page. Si une ancienne bande reste affichée, faire `make clean`.
3. Lancer `make check`, puis `make deploy-dry` et `make deploy`.

Chaque photo devient une tuile (recadrage intelligent, presque noir et blanc, plus de contraste) séparée des autres par un trait blanc. Les photos sont répétées deux fois pour remplir la largeur (tuiles de 48 px sur 28 px de haut). Une bande bureau et une bande mobile (plus petite) sont générées. Les originaux ne sont pas publiés. Sans aucune photo, la pellicule n'apparaît pas.

## Structure

```
config.toml                    Paramètres Hugo, menu, pagination, sorties (RSS blog seulement)
content/_index.md              Texte À propos
content/videos.md, radio.md    Pages dédiées (front matter, contenu dans data/)
content/blog/                  Articles Markdown
data/                          concerts, social, videos, radio, albums (désactivé)
layouts/_default/baseof.html   Squelette : bloc collant .site-top (menu + pellicule), footer, JS
layouts/index.html             Accueil
layouts/videos|radio|blog/     Templates des pages dédiées
layouts/partials/              header, footer, pellicule, pellicule-bande
assets/pellicule/              Photos sources de la pellicule (non publiées)
assets/images/                 Photo du hero (publiée et recadrée pour le partage)
assets/favicon.ico             Favicon
static/                        css/style.css, js/main.js, .htaccess (copiés dans public/)
themes-alternatifs/            Anciennes variantes CSS (non chargées, non publiées)
openspec/                      Specs et changements
```

## État des sections

| Où                | Section   | Statut   | Source                              |
|-------------------|-----------|----------|-------------------------------------|
| `/#accueil`       | Hero      | actif    | `config.toml`                       |
| `/#apropos`       | À propos  | actif    | `content/_index.md`                 |
| `/#actualites`    | Actualités | actif   | dernier article de `content/blog/`  |
| `/#concerts`      | Concerts  | actif    | `data/concerts.yaml`                |
| `/#contact`       | Contact   | actif    | `config.toml` + `data/social.yaml`  |
| `/videos/`        | Vidéos    | actif    | `data/videos.yaml`                  |
| `/radio/`         | Radio     | actif    | `data/radio.yaml`                   |
| `/blog/`          | Blog      | actif    | `content/blog/*.md`                 |
| `/#musique`       | Albums    | commenté | `data/albums.yaml`                  |

## Points d'attention

- Les trois concerts de `data/concerts.yaml` datent de 2025 et juin 2026 : tous sont passés. Il faut les remplacer ou les retirer.
- Le lecteur Spotify de `/radio/` est servi par Spotify sans cache. Si une ancienne liste s'affiche, c'est un cache du navigateur (Ctrl+Maj+R). Un visiteur non connecté à Spotify n'entend que des extraits de 30 secondes.
- La pellicule est étirée à la largeur de l'écran : le ratio des tuiles varie légèrement selon la fenêtre.
- Le thème CSS est écrit en dur dans `baseof.html`. Les variantes `style-jaune.css` et `style-vert.css` sont dans `themes-alternatifs/`.
- La section Albums est entièrement commentée (template, YAML, menu, bouton CTA du hero). La procédure de réactivation est dans `openspec/specs/albums/spec.md`.
- Il n'y a pas de formulaire de contact, seulement l'email et les réseaux sociaux.

## Méthode de travail avec OpenSpec

Le projet utilise [OpenSpec](https://github.com/Fission-AI/OpenSpec) (schéma `spec-driven`) avec Claude Code. Les specs décrivent le comportement actuel de chaque sujet.

```
openspec/config.yaml               Contexte du projet et règles de génération des propositions
openspec/specs/<sujet>/spec.md     Une spec par sujet
openspec/changes/                  Changements en cours
openspec/changes/archive/          Changements terminés (vidéos, radio, blog, …)
```

Specs disponibles : `architecture`, `hero`, `navigation`, `apropos`, `concerts`, `contact`, `social-links`, `theming`, `albums` (désactivé), `videos`, `radio`, `blog`, `pellicule`.

### Cycle de travail

Pour une évolution non triviale, on passe par ces commandes dans Claude Code :

| Commande         | Rôle                                                         |
|------------------|--------------------------------------------------------------|
| `/opsx:explore`  | Réfléchir et clarifier avant de s'engager                    |
| `/opsx:propose`  | Crée un changement avec proposal, design, specs et tâches    |
| `/opsx:apply`    | Implémente les tâches du changement                          |
| `/opsx:archive`  | Archive le changement terminé                                |

`openspec/config.yaml` impose deux règles : une proposition mentionne l'impact sur les data files YAML et précise si la section existe déjà, et une liste de tâches se termine par « vérifier avec `make serve` » en nommant les fichiers touchés. Les specs principales sont écrites en texte libre : à l'archivage on les met à jour à la main (`openspec archive --skip-specs`).

Pour une simple mise à jour de contenu (un concert, un lien, une photo), pas besoin d'OpenSpec : on édite le fichier de données directement.

### Chantiers identifiés

1. **Albums** : à réactiver quand il y aura de la musique à présenter (4 étapes dans la spec).
2. **Concerts** : tri automatique par date, masquage des concerts passés, `ticketLink` optionnel.
3. **Thèmes CSS** : supprimer les variantes de `themes-alternatifs/` ou construire un vrai système de thèmes.

## Conventions

- Contenu et commits en français.
- Commits [Conventional Commits](https://www.conventionalcommits.org/) : `feat:`, `fix:`, `chore:`, `content:`, `docs:`.
- Petits commits atomiques.
- On ne versionne pas `public/`, `resources/_gen/`, `.env`, `.idea/`.
- CSS et JS vanilla, sans framework ni bundler.

Le fichier `CLAUDE.md` contient les mêmes informations condensées pour Claude Code.
