# Spec : Actualités (#actualites)

## Description

Section de la page d'accueil, entre « À propos » et « Concerts », qui présente le dernier article publié du blog.

## Statut

**Actif**

## Fichiers concernés

- `layouts/index.html` — `<section id="actualites">`
- `static/css/style.css` — réutilise `.post-card` ; styles `#actualites .post-card`, `.all-posts`
- `content/blog/*.md` — source (aucun data file)

## Comportement

- Article choisi : celui dont la date est la plus récente parmi les articles publiés (`first 1` de `.ByDate.Reverse` de la section `blog`).
- Affichage : date, titre (lien), résumé (`summary`, sinon résumé automatique), bouton « Lire l'article », et lien « Tous les articles » vers `/blog/`.
- Pas de section s'il n'y a aucun article publié. Les brouillons et les articles à date future sont exclus, sauf avec `make serve DEBUG=true`.
- Aucune entrée de menu : « Blog » est l'entrée de navigation.

## Exigences

- La section SHALL afficher le dernier article publié et un lien vers `/blog/`.
- La section MUST NOT apparaître sans article publié.
