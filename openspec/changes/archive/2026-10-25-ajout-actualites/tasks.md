# Tasks

## 1. Section Actualités

- [x] 1.1 Ajouter `<section id="actualites">` entre `#apropos` et `#concerts` dans `layouts/index.html` (dernier article du blog : date, titre, résumé, bouton « Lire l'article », lien « Tous les articles » vers `/blog/`) avec `{{ with }}` pour la masquer sans article, et vérifier avec `hugo --minify` que `public/index.html` contient la section avec l'article le plus récent
- [x] 1.2 Vérifier avec les articles du dépôt que les brouillons ne sont pas choisis (`make build`) et que la section disparaît si aucun article n'est publié (test dans une copie temporaire sans articles)
- [x] 1.3 Ajuster les styles dans `static/css/style.css` si besoin (espacement, lien « Tous les articles ») et vérifier le rendu desktop et mobile

## 2. Documentation et specs

- [x] 2.1 Mettre à jour `README.md` et `CLAUDE.md` (nouvelle section, ordre des sections de l'accueil, remarque sur les articles datés dans le futur) et vérifier la cohérence
- [x] 2.2 Créer `openspec/specs/actualites/spec.md` et mettre à jour `openspec/specs/architecture/spec.md` (ordre : hero, apropos, actualites, concerts, contact) et vérifier la cohérence avec le rendu

## 3. Vérification finale

- [x] 3.1 Vérifier avec `make serve` et `make serve DEBUG=true` : section présente entre À propos et Concerts, bon article, liens fonctionnels, rendu mobile, puis `make check` sans erreur
