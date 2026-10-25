# Spec : Pellicule de photos

## Description

Bande de miniatures en noir et blanc sous le menu, sur toutes les pages, assemblée **en une seule image** par Hugo au build à partir des photos de `assets/pellicule/`. Le menu et la pellicule sont collés ensemble en haut de l'écran.

## Statut

**Actif** (la pellicule n'apparaît que si `assets/pellicule/` contient des images)

## Fichiers concernés

- `assets/pellicule/*` — photos sources (JPG/PNG, ≥ 800 px de large conseillé ; l'ordre est alphabétique : préfixer `01-`, `02-`…)
- `layouts/partials/pellicule.html` — appelle la bande bureau et la bande mobile et écrit le `<picture>`
- `layouts/partials/pellicule-bande.html` — assemble une bande (tuiles recadrées, presque noir et blanc, séparées par un trait blanc)
- `layouts/_default/baseof.html` — bloc `.site-top` (menu + pellicule) collant, présent sur toutes les pages
- `static/css/style.css` — `.site-top`, `.pellicule`, `scroll-padding-top` (les ancres ne passent pas sous le bloc collant)

## Comportement

- Deux images WebP sont générées : bande bureau (une tuile par photo, 2880×112, affichée à 56 px de haut) et bande mobile (les 6 premières photos, 780×80, affichée à 40 px de haut, sous 768 px).
- Chaque tuile est recadrée sur la zone d'intérêt (recadrage intelligent), réduite en Lanczos, passée en presque noir et blanc (saturation −75 %) avec plus de contraste (+20) ; un trait blanc sépare les tuiles ; deux bandes blanches de 3 px encadrent la pellicule.
- Le montage se fait en PNG (sans perte) et n'est converti en WebP qu'à la fin : empiler les tuiles directement en WebP les dégrade (bruit, gris).
- L'image occupe toute la largeur de l'écran (`width: 100%`, `object-fit: fill`) : aucune photo coupée à droite, avec une légère variation du ratio des tuiles selon la largeur de la fenêtre.
- `alt` vide (bandeau décoratif) et `role="img"` avec un `aria-label` sur le conteneur.
- Les photos d'origine MUST NOT être publiées : seules les deux bandes sortent dans `public/pellicule/` (noms `bande-bureau.<hash>.webp` et `bande-mobile.<hash>.webp`).

## Changer les photos

1. Remplacer ou ajouter des photos dans `assets/pellicule/` (l'ordre suit l'ordre alphabétique).
2. `make serve` pour contrôler le rendu ; si une ancienne bande reste en cache, `make clean`.
3. `make check` (vérifie `public/`), puis `make deploy-dry` et `make deploy`.

## Exigences

- La pellicule SHALL être construite depuis `assets/pellicule/` sans autre liste à maintenir.
- Le menu et la pellicule SHALL rester visibles en haut lors du défilement, sur toutes les pages.
