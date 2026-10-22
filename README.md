# seableed.com

Site statique [Hugo](https://gohugo.io/) du groupe de rock Seableed (Rennes). C'est un site mono-page : une seule route (`/`) et une navigation par ancres.

## Pour reprendre le projet

### Prérequis

Il faut Hugo (version étendue, testé avec 0.123.7) et `lftp` pour le déploiement. Le fichier `.env` n'est pas versionné : on le crée à partir de `.env.example` avec les identifiants FTP.

```bash
cp .env.example .env   # puis renseigner FTP_HOST, FTP_USER, FTP_PASS, FTP_PATH
```

### Commandes

```bash
make serve       # http://localhost:1313, hot-reload, brouillons inclus
make build       # génère public/ (minifié)
make deploy-dry  # simule le déploiement FTP (à lancer avant deploy)
make deploy      # build + upload FTP (attention : mirror --delete)
make ftp         # session lftp interactive (cd dans FTP_PATH)
make clean       # supprime public/ et resources/_gen/
```

`make deploy` utilise `mirror --reverse --delete` : tout fichier distant absent de `public/` est supprimé. Lance toujours `make deploy-dry` d'abord.

Hébergement OVH : `FTP_PATH` doit valoir `/www/` (la racine FTP est `/`). Le serveur ne supporte pas FTPS (`AUTH TLS` refusé) et refuse par intermittence la connexion de données (`Data socket error`). Le Makefile désactive donc SSL et laisse lftp réessayer (`LFTP_SET`). Un échec isolé n'est pas anormal.

## Mises à jour courantes

Chaque section a sa source de données. Dans tous les cas, on vérifie avec `make serve` avant de déployer.

| Je veux…                      | Je modifie                                | Remarque                                              |
|-------------------------------|-------------------------------------------|-------------------------------------------------------|
| Ajouter ou retirer un concert | `data/concerts.yaml`                      | Pas de tri ni de gestion des concerts passés : l'ordre du YAML est l'ordre affiché. Supprimer ou commenter les dates passées. |
| Concert sans billetterie      | `ticketLink: "#"` dans `concerts.yaml`    | Le bouton s'affiche quand même.                       |
| Changer le texte « À propos » | `content/_index.md`                       | Seule section pilotée par du Markdown.                |
| Ajouter un réseau social      | `data/social.yaml`                        | Icône = classe Font Awesome 6.5.1 (ex. `fa-brands fa-instagram`). |
| Changer nom, genre, ville, email | `config.toml` (section `[params]`)     | Alimente le hero et le contact.                       |
| Ajouter un item de menu       | `config.toml` (`[[menu.main]]`) + section dans `layouts/index.html` | |
| Changer les couleurs          | `static/css/style.css`                    | Thème teal `#3a5a52` / rust `#d4604d`.                |

Schémas des fichiers de données :

```yaml
# data/concerts.yaml
- date: "20/06/2026"        # texte libre
  venue: "Nom de la salle"
  location: "Ville, France"
  ticketLink: "https://…"   # ou "#"

# data/social.yaml
- name: "Instagram"
  url: "https://…"
  icon: "fa-brands fa-instagram"
```

## Structure

```
config.toml                  Paramètres Hugo (bandName, genre, location, email) et menus
content/_index.md            Texte de la section À propos
data/                        concerts.yaml, social.yaml, albums.yaml (désactivé)
layouts/_default/baseof.html Squelette HTML (charge style.css, Font Awesome, main.js)
layouts/index.html           Toutes les sections de la page
layouts/partials/            header.html (nav responsive), footer.html
static/css/style.css         Thème actif
static/js/main.js            Menu hamburger + smooth scroll
static/images/hero-band.jpg  Photo du groupe
openspec/                    Specs et configuration OpenSpec
```

## État des sections

| Ancre        | Section  | Statut   | Source                          |
|--------------|----------|----------|---------------------------------|
| `#accueil`   | Hero     | actif    | `config.toml`                   |
| `#apropos`   | À propos | actif    | `content/_index.md`             |
| `#concerts`  | Concerts | actif    | `data/concerts.yaml`            |
| `#contact`   | Contact  | actif    | `config.toml` + `data/social.yaml` |
| `#musique`   | Albums   | commenté | `data/albums.yaml`              |
| `#videos`    | Vidéos   | planifié | à créer (`data/videos.yaml`)    |

## Points d'attention

- Les trois concerts de `data/concerts.yaml` datent de 2025 et juin 2026 : tous sont passés. Il faut les remplacer ou les retirer.
- Le thème CSS est écrit en dur dans `baseof.html`. Les fichiers `style-jaune.css` et `style-vert.css` ne sont chargés nulle part (orphelins).
- La section Albums est entièrement commentée (template, YAML, menu, bouton CTA du hero). La procédure de réactivation est dans `openspec/specs/albums/spec.md`.
- Il n'y a pas de formulaire de contact, seulement l'email et les réseaux sociaux.

## Méthode de travail avec OpenSpec

Le projet utilise [OpenSpec](https://github.com/Fission-AI/OpenSpec) (schéma `spec-driven`) avec Claude Code. Les specs décrivent le comportement actuel de chaque section. Elles ont été écrites par rétro-ingénierie du code existant (commit `446f5a1`).

### Où est quoi

```
openspec/config.yaml      Contexte du projet et règles de génération des propositions
openspec/specs/<section>/spec.md   Une spec par sujet
openspec/changes/         Changements en cours (vide pour l'instant)
openspec/changes/archive/ Changements terminés (vide pour l'instant)
```

Specs disponibles : `architecture`, `hero`, `navigation`, `apropos`, `concerts`, `contact`, `social-links`, `theming`, `albums` (désactivé), `videos` (planifié).

### Cycle de travail

Pour une évolution non triviale (nouvelle section, réactivation des albums, système de thèmes), on passe par ces commandes dans Claude Code :

| Commande                                | Rôle                                                              |
|-----------------------------------------|-------------------------------------------------------------------|
| `/opsx:explore`                         | Réfléchir et clarifier avant de s'engager                         |
| `/opsx:propose`                         | Crée un changement avec proposal, design, specs et tâches         |
| `/opsx:apply`                           | Implémente les tâches du changement                               |
| `/opsx:archive`                         | Archive le changement terminé et met à jour les specs             |

Les équivalents en skills sont `/openspec-explore`, `/openspec-propose`, `/openspec-apply-change` et `/openspec-archive-change`.

`openspec/config.yaml` impose deux règles : une proposition mentionne l'impact sur les data files YAML et précise si la section existe déjà (commentée) ou est absente. Une liste de tâches se termine par « vérifier avec `make serve` » et nomme explicitement les fichiers touchés.

Pour une simple mise à jour de contenu (un concert, un lien), pas besoin d'OpenSpec : on édite le fichier de données directement.

### Chantiers identifiés dans les specs

1. **Section Vidéos** : embed YouTube via `data/videos.yaml` (option A) ou simples liens (option B). Penser au RGPD avec `youtube-nocookie.com`. Le compte `@seableed` est déjà dans `social.yaml`.
2. **Section Albums** : à réactiver quand il y aura de la musique à présenter (4 étapes dans la spec).
3. **Concerts** : tri automatique par date, masquage des concerts passés, `ticketLink` optionnel (aujourd'hui `ticketLink:` vide dans une entrée).
4. **Thèmes CSS** : supprimer les variantes orphelines ou construire un vrai système de thèmes.

## Conventions

- Contenu et commits en français.
- Commits [Conventional Commits](https://www.conventionalcommits.org/) : `feat:`, `fix:`, `chore:`, `content:`, `docs:`.
- Petits commits atomiques.
- On ne versionne pas `public/`, `resources/_gen/`, `.env`, `.idea/`.
- CSS et JS vanilla, sans framework ni bundler.

Le fichier `CLAUDE.md` contient les mêmes informations condensées pour Claude Code.
