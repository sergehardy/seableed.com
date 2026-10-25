# Spec : Pellicule de photos

## Description

Bandeau horizontal de miniatures sous le hero de la page d'accueil, construit automatiquement par Hugo à partir d'un répertoire de photos.

## Statut

**Actif** (le bandeau n'apparaît que si `assets/pellicule/` contient des images)

## Fichiers concernés

- `assets/pellicule/*` — photos sources (≤ 2000 px, nommées `01-…`, `02-…` pour l'ordre)
- `layouts/partials/pellicule.html` — génération des miniatures et HTML
- `layouts/index.html` — appel du partial sous le hero
- `static/css/style.css` — styles `.pellicule`

## Comportement

- Miniatures WebP 400×300 (`Fill`, ancre centre, qualité 80), identiques quelle que soit la taille d'origine.
- Affichées à 180 px de haut (140 px sur mobile), bandeau défilant en CSS (`overflow-x`, scroll-snap), même largeur que le hero.
- `loading="lazy"`, `width`/`height` déclarés, `alt` déduit du nom de fichier.
- Aucun outil externe : miniatures dans `resources/_gen` (non versionné).

## Exigences

- La pellicule SHALL être construite depuis `assets/pellicule/` sans autre liste.
- La photo d'origine MUST NOT être servie dans le bandeau.
