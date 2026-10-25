# Spec : Préproduction

## Description

Environnement de test dans un sous-répertoire du même hébergement OVH (`www/preprod/`, servi à `https://www.seableed.com/preprod/`), construit et déployé avec le même Makefile via `ENV=preprod`.

## Statut

**Actif**

## Fichiers concernés

- `Makefile` — `ENV ?= prod`, validation, choix du dossier SFTP et des options Hugo, exclusion de `preprod/` en production, masquage du mot de passe
- `.env` / `.env.example` — `PREPROD_FTP_PATH`, `PREPROD_URL`
- `layouts/_default/baseof.html` — meta `robots` si `hugo.Environment` vaut `preprod`
- `layouts/partials/header.html` — liens du menu en `relURL`

## Comportement

- `make <cible> ENV=prod|preprod` (prod par défaut) pour `build`, `check`, `deploy`, `deploy-dry`, `ftp` ; une autre valeur échoue avec un message.
- Build préprod : `hugo --environment preprod --baseURL "$PREPROD_URL"`, plus l'ajout d'un `X-Robots-Tag: noindex, nofollow` (dans `<IfModule mod_headers.c>`) à `public/.htaccess`.
- `make check` : en préprod, chaque page (hors alias Hugo) contient la meta noindex et `.htaccess` l'en-tête ; en production aucun `noindex` ne doit être présent (hors alias).
- Le déploiement de production exclut `preprod/` du miroir `--delete` ; celui de préprod ne cible que `www/preprod/`.
- Variable manquante en préprod : échec explicite nommant la variable.
- Pas de `robots.txt` (inopérant dans un sous-répertoire). Pas de mot de passe sur la préprod.

## Exigences

- Un déploiement de production MUST NOT modifier ni supprimer `www/preprod/`.
- Le build de production MUST NOT contenir de `noindex` ni de `X-Robots-Tag`.
