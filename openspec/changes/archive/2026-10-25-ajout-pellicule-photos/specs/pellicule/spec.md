# Spec Delta

## Purpose

Agrémenter la page d'accueil d'une pellicule de miniatures de photos du groupe, construite automatiquement à partir d'un répertoire de photos.

## ADDED Requirements

### Requirement: Pellicule construite depuis un répertoire
Le site SHALL générer la pellicule à partir de toutes les images présentes dans `assets/pellicule/`, sans autre liste à maintenir.

#### Scenario: Ajout d'une photo
- **WHEN** une image est ajoutée dans `assets/pellicule/` puis le site reconstruit
- **THEN** sa miniature apparaît dans la pellicule

### Requirement: Miniatures homogènes
Chaque photo SHALL être convertie en miniature de dimensions homogènes quelle que soit la taille d'origine, et la photo d'origine MUST NOT être servie telle quelle dans la pellicule.

#### Scenario: Photos de tailles variables
- **WHEN** le répertoire contient des photos de tailles et de ratios différents
- **THEN** les miniatures affichées ont toutes la même hauteur et un poids réduit

### Requirement: Affichage en bandeau défilant
La pellicule SHALL s'afficher en bandeau horizontal sous le hero, défilable au doigt, à la molette ou au clavier, sans JavaScript indispensable.

#### Scenario: Écran étroit
- **WHEN** la largeur d'écran est inférieure à 768 px
- **THEN** le bandeau reste sur une ligne et défile horizontalement sans faire défiler la page

### Requirement: Chargement différé et accessible
Les miniatures SHALL être chargées en différé avec dimensions déclarées et un texte alternatif.

#### Scenario: Chargement de l'accueil
- **WHEN** l'accueil s'ouvre
- **THEN** les miniatures hors écran ne sont chargées qu'à l'approche du défilement et ne provoquent pas de saut de mise en page
