# Spec Delta

## Purpose

Publier des articles du groupe écrits en Markdown, présentés dans une liste paginée et sur des pages dédiées.

## ADDED Requirements

### Requirement: Articles en Markdown
Chaque fichier `content/blog/*.md` SHALL produire une page d'article `/blog/<slug>/` à partir de son front matter (`title`, `date`, `summary`) et de son corps Markdown ; un article marqué `draft: true` MUST NOT être publié en production.

#### Scenario: Nouvel article
- **WHEN** un fichier Markdown est ajouté dans `content/blog/` puis le site reconstruit
- **THEN** l'article apparaît dans la liste et sur sa propre page

### Requirement: Liste paginée
La page `/blog/` SHALL lister les articles du plus récent au plus ancien, avec titre, date et résumé, et les répartir sur plusieurs pages selon la taille de pagination configurée.

#### Scenario: Plus d'articles que la taille de page
- **WHEN** le nombre d'articles dépasse la taille de page
- **THEN** la liste est coupée en pages avec des liens Précédent/Suivant et les numéros de pages

#### Scenario: Une seule page d'articles
- **WHEN** tous les articles tiennent sur une page
- **THEN** aucun contrôle de pagination n'est affiché

### Requirement: Navigation depuis l'article
Une page d'article SHALL afficher titre, date et contenu, avec un lien de retour vers `/blog/`.

#### Scenario: Retour à la liste
- **WHEN** le visiteur clique sur le lien de retour
- **THEN** il revient sur la liste du blog
