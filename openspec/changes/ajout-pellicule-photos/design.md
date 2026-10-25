# Design

## Context

Hugo extended v0.123.7 est installé (`hugo version`) : il sait redimensionner, recadrer et convertir en WebP les images des répertoires `assets/` pendant le build. Les miniatures vont dans `resources/_gen/` (non versionné) puis dans `public/`. Voir proposal.md.

## Goals / Non-Goals

**Goals:**
- Aucune étape manuelle : déposer des photos dans `assets/pellicule/` suffit.
- Pellicule légère, native (HTML/CSS), accessible.

**Non-Goals:**
- Pas de lightbox ni d'agrandissement au clic dans ce change.
- Pas de script Makefile ni d'outil externe (ImageMagick) : décision de l'utilisateur.

## Decisions

- **Génération native** : partial `layouts/partials/pellicule.html` : `{{ range resources.Match "pellicule/*" }}` puis `.Fill "400x300 webp q80 Center"` (hauteur fixe, largeur homogène) ; l'ordre est l'ordre alphabétique des noms de fichiers (préfixer `01-`, `02-` pour l'imposer). Alternative écartée : cible Makefile + ImageMagick (miniatures versionnées, dépendance).
- **Recadrage** : `Fill` avec ancre `Center` (valeur par défaut, ajustable) ; si une photo est mal cadrée, on peut la renommer ou pré-cadrer à la source.
- **Rendu** : conteneur `display: flex; overflow-x: auto; scroll-snap-type: x mandatory; gap`, images `loading="lazy"`, `width`/`height` issus de la ressource, `alt` dérivé du nom de fichier.
- **Emplacement** : directement sous `.hero` dans `layouts/index.html`, avec sa propre classe `.pellicule` (pas un `section` max-width 1200 : même largeur que le hero, 1136 px).
- **Photos d'exemple** : pour tester, au moins 10 photos fournies par l'utilisateur ; sinon un jeu d'images générées temporaires, non commitées.

## Risks / Trade-offs

- [Temps de build augmenté avec beaucoup de photos] → le cache `resources/_gen` évite de régénérer ; `make clean` le supprime.
- [Photos trop petites que la miniature] → `Fill` ne les agrandit pas indéfiniment ; fournir des sources d'au moins 800 px de large.
- [Dépôt qui grossit avec les sources] → photos sources à compresser (≤ 2000 px de large) avant commit.
- [Droits sur les extraits de vidéos] → photos fournies par le groupe.
