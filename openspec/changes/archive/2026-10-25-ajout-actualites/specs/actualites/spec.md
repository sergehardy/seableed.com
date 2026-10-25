# Spec Delta

## Purpose

Présenter sur la page d'accueil le dernier article du blog, pour mettre en avant les nouvelles du groupe sans passer par le blog.

## ADDED Requirements

### Requirement: Section Actualités sur l'accueil
La page d'accueil SHALL contenir une section `#actualites`, placée entre « À propos » et « Concerts », qui affiche le dernier article publié du blog : date, titre, résumé et un lien vers l'article.

#### Scenario: Plusieurs articles publiés
- **WHEN** le blog contient plusieurs articles publiés
- **THEN** la section affiche celui dont la date est la plus récente, avec un lien « Lire l'article » vers sa page

#### Scenario: Résumé absent
- **WHEN** l'article n'a pas de `summary`
- **THEN** la section affiche le résumé automatique de l'article

### Requirement: Accès à tous les articles
La section SHALL proposer un lien vers `/blog/` pour consulter tous les articles.

#### Scenario: Lien vers le blog
- **WHEN** le visiteur clique sur « Tous les articles »
- **THEN** il arrive sur la page `/blog/`

### Requirement: Section absente sans article publié
La section MUST NOT apparaître quand le blog n'a aucun article publié ; les brouillons (`draft: true`) et les articles à date future MUST NOT être pris en compte en production.

#### Scenario: Blog sans article publié
- **WHEN** tous les articles sont des brouillons ou n'existent pas
- **THEN** la page d'accueil ne contient pas la section `#actualites`

#### Scenario: Dernier article en brouillon
- **WHEN** l'article le plus récent a `draft: true`
- **THEN** la section affiche le plus récent des articles publiés
