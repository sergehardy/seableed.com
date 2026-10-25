# Proposal

## Why

Aujourd'hui `make deploy` publie directement en production. Le multisite n'est pas disponible sur l'hébergement OVH (pas de sous-domaine séparé) : il faut pouvoir tester un déploiement réel dans un sous-répertoire du même hébergement, sans risque pour la production ni pour le référencement.

## What Changes

- Le Makefile accepte un argument d'environnement `ENV=prod|preprod` (défaut `prod`) pour `build`, `check`, `deploy`, `deploy-dry` et `ftp` (ex. `make deploy ENV=preprod`).
- La préprod est servie dans le sous-répertoire `www/preprod/`, donc à `https://www.seableed.com/preprod/` : le build préprod utilise ce `baseURL`.
- Les liens du menu (aujourd'hui des chemins absolus `/videos/`, `/#concerts`, …) suivent le `baseURL` pour fonctionner dans un sous-répertoire.
- Le déploiement de production exclut `preprod/` du miroir (sinon `mirror --delete` effacerait la préprod).
- La préprod n'est pas indexée : balise `<meta name="robots" content="noindex, nofollow">` et en-tête HTTP `X-Robots-Tag` via `.htaccess` (ajoutés uniquement au build préprod). Pas de `robots.txt` : il n'aurait d'effet qu'à la racine du domaine, et un `Disallow` empêcherait les robots de lire le `noindex`.
- Nouvelles variables dans `.env` : chemin SFTP et URL de la préprod.
- Documentation (README, CLAUDE.md) de la procédure préprod puis prod.

## Capabilities

### New Capabilities
- `preprod`: construction et déploiement d'une préprod dans `www/preprod/`, non indexable, sans impact sur la production.

### Modified Capabilities
- `navigation`: les liens du menu doivent respecter le `baseURL` (fonctionnement dans un sous-répertoire).

## Impact

- Data files YAML : aucun.
- Code : `Makefile`, `.env.example`, `layouts/partials/header.html` (liens du menu), `layouts/_default/baseof.html` (meta robots conditionnelle), `README.md`, `CLAUDE.md`.
- Hébergement : création du dossier `www/preprod/` (par le premier déploiement préprod). Aucun changement dans l'espace client OVH.
- Les sections et pages existantes ne changent pas pour la production.
