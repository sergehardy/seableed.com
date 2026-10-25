# Tasks

## 1. Données

- [x] 1.1 Créer `assets/pellicule/` et y déposer au moins 10 photos fournies par l'utilisateur (sources ≤ 2000 px, nommées `01-…`, `02-…`) et vérifier que `ls assets/pellicule | wc -l` donne 10 ou plus
- [x] 1.2 Documenter le répertoire d'entrée et la convention de nommage dans `CLAUDE.md` et `openspec/config.yaml`

## 2. Génération et rendu

- [x] 2.1 Créer `layouts/partials/pellicule.html` (`resources.Match`, `.Fill` WebP, `loading="lazy"`, `width`/`height`, `alt`) et vérifier avec `hugo --minify` que les miniatures sont générées (`public/` et `resources/_gen/`)
- [x] 2.2 Appeler le partial sous le hero dans `layouts/index.html` et vérifier que `public/index.html` contient autant d'`<img>` que de photos
- [x] 2.3 Ajouter les styles `.pellicule` (flex, `overflow-x: auto`, scroll-snap, hauteur homogène, largeur alignée sur le hero) dans `static/css/style.css` et vérifier le rendu desktop et mobile

## 3. Specs

- [x] 3.1 Créer `openspec/specs/pellicule/spec.md` et compléter `openspec/specs/hero/spec.md` (ordre des sections) et `openspec/specs/architecture/spec.md` et vérifier la cohérence avec le rendu

## 4. Vérification finale

- [x] 4.1 Vérifier avec `make serve` : bandeau défilant, miniatures légères (onglet réseau), lazy loading, `make build` sans erreur, `resources/_gen` non versionné

## 5. Évolution : bande unique

- [x] 5.1 Assembler les photos en une bande unique (bureau et mobile) dans `layouts/partials/pellicule-bande.html` et vérifier que `public/pellicule/` ne contient que 2 fichiers WebP (`make check`)
- [x] 5.2 Documenter la procédure « changer les photos » dans `README.md` et la spec `pellicule` et vérifier que les étapes sont identiques
