# Proposal

## Why

La page d'accueil manque de vie : une pellicule de photos du groupe (photos de groupe, extraits de vidéos) donne tout de suite une idée de l'énergie du groupe, sans alourdir la page avec des images pleine taille.

## What Changes

- Nouveau bandeau « pellicule » sur la page d'accueil, juste sous le hero (absent aujourd'hui du HTML).
- Les photos sont déposées dans un répertoire d'entrée `assets/pellicule/` ; les miniatures sont générées automatiquement par Hugo au build (aucun outil externe, aucune cible Makefile).
- Photos de tailles et formats variables, recadrées en miniatures homogènes, chargées en différé.
- Au moins une dizaine de photos visées ; les photos sont fournies par l'utilisateur.

## Capabilities

### New Capabilities
- `pellicule`: bandeau de miniatures généré depuis un répertoire de photos, sur l'accueil.

### Modified Capabilities
- `hero`: la pellicule s'affiche immédiatement sous le hero.

## Impact

- Data files YAML : aucun (la liste est le contenu du répertoire `assets/pellicule/`).
- Code : `layouts/index.html` (ou un partial `layouts/partials/pellicule.html`), `assets/pellicule/*`, `static/css/style.css`.
- Build : utilise Hugo extended (déjà requis) ; `resources/_gen/` reste non versionné. Les photos sources sont versionnées dans `assets/pellicule/`.
- Docs/specs : `CLAUDE.md`, `openspec/config.yaml`, specs `pellicule` et `hero`.
