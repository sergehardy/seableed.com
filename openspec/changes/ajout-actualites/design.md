# Design

## Context

Les articles sont des pages Hugo de la section `blog` (`content/blog/*.md`). `layouts/index.html` contient les sections de l'accueil ; les styles `.post-card` (cartes d'articles) existent déjà pour la liste du blog. Voir proposal.md.

## Goals / Non-Goals

**Goals:**
- Afficher le dernier article publié, sans configuration ni data file.

**Non-Goals:**
- Pas de carrousel ni de liste de plusieurs articles.
- Pas d'entrée de menu dédiée.

## Decisions

- **Sélection** : `{{ range first 1 (where .Site.RegularPages "Section" "blog").ByDate.Reverse }}`. Les brouillons et les dates futures sont exclus par Hugo en production, et inclus avec `make serve DEBUG=true`. Alternative écartée : un champ `actualite: true` dans le front matter (travail de rédaction supplémentaire).
- **Section absente** : `{{ with }}` autour de la section pour ne rien rendre quand aucun article n'existe.
- **Affichage** : `<section id="actualites">` avec `<h2>Actualités</h2>` puis une carte `.post-card` (date, titre en lien, résumé `.Params.summary` sinon `.Summary | plainify`, bouton `.btn` « Lire l'article »), et un lien « Tous les articles » vers `{{ "blog/" | relURL }}`.
- **Placement** : entre `#apropos` et `#concerts` dans `layouts/index.html`.
- **Style** : réutilise `.post-card` ; la section héritant de `section { max-width: 1200px }`, aucune largeur à définir.
- **Menu** : inchangé, « Blog » reste l'entrée de navigation.

## Risks / Trade-offs

- [Aucun article publié] → la section disparaît (pas de bloc vide).
- [Date d'article à venir] → non affiché tant que la date n'est pas atteinte ; c'est le comportement Hugo, à garder en tête quand on prépare un article.
