# Tasks

## 1. Liens du menu relatifs au baseURL

- [ ] 1.1 Passer `.URL` dans `relURL` dans `layouts/partials/header.html` et vérifier qu'un build avec `--baseURL https://www.seableed.com/preprod/` donne `/preprod/videos/`, `/preprod/#concerts` (grep dans `public/videos/index.html`) et que le build de production garde `/videos/`, `/#concerts`
- [ ] 1.2 Contrôler le reste des gabarits (`baseof.html`, `blog/`, `pellicule`) avec le même build `--baseURL …/preprod/` et vérifier qu'aucun lien ou ressource ne pointe vers la racine du domaine (grep `href=/` et `src=/` hors `/preprod/`)

## 2. Makefile : argument ENV

- [ ] 2.1 Ajouter `ENV ?= prod`, la validation (`prod` ou `preprod`, message clair sinon) et la sélection de `DEST_PATH` et `BASE_URL` dans `Makefile` et vérifier `make build ENV=test` échoue et `make build` fonctionne comme avant
- [ ] 2.2 Appliquer `ENV` à `build`, `check`, `deploy`, `deploy-dry` et `ftp` (build préprod avec `--environment preprod --baseURL $(PREPROD_URL)`, `--exclude preprod/` dans le miroir de production, affichage de l'environnement et du chemin distant) et vérifier avec `make deploy-dry` et `make deploy-dry ENV=preprod` que le premier ne touche pas `preprod/` et que le second ne cible que `www/preprod/`
- [ ] 2.3 Ajouter `PREPROD_FTP_PATH` et `PREPROD_URL` à `.env.example` (et à `.env` de l'utilisateur) avec échec explicite si absents en préprod, et vérifier le message en les retirant temporairement

## 3. Non-indexation de la préprod

- [ ] 3.1 Ajouter dans `layouts/_default/baseof.html` la balise `<meta name="robots" content="noindex, nofollow">` quand `hugo.Environment` vaut `preprod` et vérifier qu'elle est présente dans le build préprod et absente du build de production
- [ ] 3.2 Faire ajouter par le Makefile l'en-tête `X-Robots-Tag` (dans `<IfModule mod_headers.c>`) au `public/.htaccess` du build préprod, étendre `make check` pour contrôler sa présence en préprod et son absence en production, et vérifier les deux cas

## 4. Documentation et specs

- [ ] 4.1 Documenter la procédure (préprod puis prod, variables `.env`, `ENV=preprod`, vérification `curl -I`) dans `README.md` et `CLAUDE.md`
- [ ] 4.2 Créer `openspec/specs/preprod/spec.md` et mettre à jour `openspec/specs/navigation/spec.md` et `openspec/specs/architecture/spec.md` et vérifier la cohérence avec le comportement

## 5. Vérification finale

- [ ] 5.1 Faire un déploiement réel de préprod (`make deploy-dry ENV=preprod` relu avec l'utilisateur, puis `make deploy ENV=preprod`) et vérifier : navigation complète sous `/preprod/`, `curl -I` montre `X-Robots-Tag`, la production reste inchangée, puis `make deploy-dry` de production relu pour confirmer que `preprod/` est exclu
