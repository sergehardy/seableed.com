# Design

## Context

Le Makefile construit avec `hugo --minify --cleanDestinationDir` et déploie `public/` par `lftp mirror --reverse --delete` vers `FTP_PATH` (`www/`), en excluant `__hidden/`. Le multisite OVH n'est pas disponible : la préprod ne peut être qu'un sous-répertoire de `www/`. `config.toml` a `baseURL = 'https://www.seableed.com/'` et des liens de menu absolus à la racine. Voir proposal.md.

## Goals / Non-Goals

**Goals:**
- Un seul paramètre, `ENV=prod|preprod`, pilote build, vérification et déploiement.
- Tester le site réel (SFTP, HTTPS, liens) sans risque pour la production.

**Non-Goals:**
- Pas de protection par mot de passe (`.htpasswd`) dans ce change (possible plus tard).
- Pas de pipeline CI, pas de second hébergement.

## Decisions

- **Argument `ENV`** : `ENV ?= prod` en tête du Makefile, validé par un test `ifneq` qui échoue sinon. Usage : `make deploy-dry ENV=preprod`. Alternative écartée : cibles dupliquées (`deploy-preprod`, `build-preprod`…) : plus de code et d'oubli possibles.
- **Variables** : `.env` ajoute `PREPROD_FTP_PATH=www/preprod/` et `PREPROD_URL=https://www.seableed.com/preprod/` ; la production garde `FTP_PATH` et son `baseURL` du `config.toml`. Le Makefile choisit `DEST_PATH` et `BASE_URL` selon `ENV`.
- **Build préprod** : `hugo --minify --cleanDestinationDir --environment preprod --baseURL $(PREPROD_URL)`. Les gabarits testent `hugo.Environment` (`preprod`) pour la balise `<meta name="robots" content="noindex, nofollow">` dans `baseof.html`. Alternative écartée : une seconde config Hugo (`config/preprod/`) : inutile pour deux valeurs.
- **En-tête X-Robots-Tag** : après le build préprod, le Makefile ajoute `Header set X-Robots-Tag "noindex, nofollow"` à `public/.htaccess` (celui de `static/.htaccess` garde la redirection HTTPS). Il dépend de `mod_headers`, généralement actif chez OVH ; à vérifier au premier déploiement (`curl -I`).
- **Pas de robots.txt** : un `robots.txt` n'est lu qu'à la racine du domaine, donc `www/preprod/robots.txt` serait ignoré ; et un `Disallow` à la racine empêcherait les robots de voir le `noindex`. Les deux mécanismes noindex (balise + en-tête) sont la bonne solution pour un sous-répertoire.
- **Isolation** : le miroir de production ajoute `--exclude preprod/` (comme `__hidden/`). Le miroir de préprod cible uniquement `www/preprod/`, `--delete` ne touche donc que ce dossier.
- **Liens de menu** : `layouts/partials/header.html` passe `{{ .URL | relURL }}` pour que `/videos/` devienne `/preprod/videos/` quand le `baseURL` contient un chemin ; `config.toml` n'est pas modifié. À vérifier à l'implémentation que `relURL` préfixe bien les chemins `/…` et que les ancres `/#concerts` restent correctes ; sinon utiliser `absURL`.
- **Garde-fous** : `make check` contrôle en plus la présence/l'absence de `noindex` selon `ENV` ; `deploy` et `deploy-dry` affichent l'environnement ciblé et le chemin distant avant d'agir.

## Risks / Trade-offs

- [Un `make deploy` de production oublié d'exclure `preprod/` effacerait la préprod] → exclusion dans les deux cibles de production et test en `deploy-dry`.
- [`mod_headers` indisponible, `.htaccess` provoquant une erreur 500] → entourer la directive de `<IfModule mod_headers.c>` ; la balise meta reste en secours.
- [La préprod publique reste accessible par URL] → noindex seulement ; protection par mot de passe envisageable plus tard.
- [`relURL` change des liens de production] → vérifier que le build de production produit les mêmes liens qu'avant (`/videos/`, `/#concerts`…).

## Open Questions

- Souhaites-tu à terme un mot de passe (`.htpasswd`) sur la préprod ? Sans impact sur le reste du change.
