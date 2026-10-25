# Tasks

## 1. Métadonnées par page et aperçus de partage

- [ ] 1.1 Créer `layouts/partials/seo.html` (title, description par page, canonical, Open Graph, Twitter Card, lien RSS) et l'inclure dans `layouts/_default/baseof.html` à la place du `title`/`description` actuels, puis vérifier avec `hugo --minify` le `<head>` de l'accueil, de `/videos/`, de `/radio/`, de `/blog/` et d'un article
- [ ] 1.2 Ajouter `params.homeTitle` (« Seableed – groupe de rock à Rennes ») et une description par défaut dans `config.toml`, plus `description` dans le front matter de `content/videos.md`, `content/radio.md`, `content/blog/_index.md`, et vérifier que chaque page a une description différente
- [ ] 1.3 Déplacer `static/images/hero-band-2026.jpeg` vers `assets/images/`, générer l'image de partage 1200×630 (`.Fill "1200x630 Smart"`) et publier aussi le hero pour le CSS, puis vérifier que le hero s'affiche toujours et que `og:image` pointe vers un fichier de 1200×630 présent dans `public/`

## 2. Données structurées

- [ ] 2.1 Ajouter le JSON-LD `MusicGroup` + `Event` (dates `jj/mm/aaaa` lues dans `data/concerts.yaml`, dates illisibles ignorées) à l'accueil dans `seo.html` et vérifier que le JSON est valide (`python3 -m json.tool`) avec le nombre d'`Event` attendu et qu'un concert sans date lisible ne casse pas le build

## 3. robots.txt, sitemap et RSS

- [ ] 3.1 Activer `enableRobotsTXT` dans `config.toml`, créer `layouts/robots.txt` (sitemap, sans `Disallow`), faire supprimer `public/robots.txt` en préprod par le `Makefile` et étendre `make check` (présent en prod avec l'URL du sitemap, absent en préprod) puis vérifier les deux environnements
- [ ] 3.2 Vérifier que `<link rel="alternate" type="application/rss+xml">` est présent sur toutes les pages et que `/blog/index.xml` existe dans `public/`

## 4. Favicon

- [ ] 4.1 Demander l'image du favicon à l'utilisateur, l'ajouter dans `static/` (`favicon.ico`) avec le `<link rel="icon">` et vérifier l'onglet en `make serve` (tâche reportée si aucune image n'est fournie)

## 5. Documentation et specs

- [ ] 5.1 Documenter dans `README.md` la section « Visibilité » (champs `description` du front matter, image de partage, JSON-LD des concerts et format de date `jj/mm/aaaa`) et les actions manuelles (Google Search Console, Bing Webmaster Tools, URL du site dans les bios Instagram, Facebook, YouTube et Spotify, débogueur de partage Facebook), et mettre à jour `CLAUDE.md`
- [ ] 5.2 Créer `openspec/specs/seo/spec.md` et mettre à jour `openspec/specs/architecture/spec.md` et vérifier la cohérence avec le build

## 6. Vérification finale

- [ ] 6.1 Vérifier avec `make serve` et `make check` (prod et `ENV=preprod`) : aperçus corrects dans `view-source`, `noindex` conservé en préprod, `robots.txt` seulement en prod, hero inchangé ; puis `make deploy-dry` relu avec l'utilisateur
