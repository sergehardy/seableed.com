# Spec Delta

## Purpose

Permettre de construire et de déployer le site dans un environnement de préproduction, dans un sous-répertoire du même hébergement, pour le tester sans toucher à la production ni au référencement.

## ADDED Requirements

### Requirement: Choix de l'environnement dans le Makefile
Les cibles `build`, `check`, `deploy`, `deploy-dry` et `ftp` SHALL accepter `ENV=prod` ou `ENV=preprod`, avec `prod` par défaut ; toute autre valeur MUST faire échouer la commande avec un message clair.

#### Scenario: Déploiement de préprod
- **WHEN** l'utilisateur lance `make deploy ENV=preprod`
- **THEN** le site est construit avec le `baseURL` de la préprod et envoyé uniquement dans le dossier SFTP de la préprod

#### Scenario: Valeur invalide
- **WHEN** l'utilisateur lance `make build ENV=test`
- **THEN** la commande s'arrête avec un message indiquant les valeurs `prod` ou `preprod`

### Requirement: Préprod isolée de la production
Le déploiement de production SHALL exclure le dossier `preprod/` du miroir, et le déploiement de préprod MUST NOT modifier un fichier hors du dossier `preprod/`.

#### Scenario: Déploiement de production
- **WHEN** l'utilisateur lance `make deploy` (production)
- **THEN** le dossier `www/preprod/` n'est ni modifié ni supprimé

### Requirement: Préprod non indexable
Le build de préprod SHALL ajouter `<meta name="robots" content="noindex, nofollow">` à chaque page et l'en-tête `X-Robots-Tag: noindex, nofollow` dans son `.htaccess` ; le build de production MUST NOT contenir ces éléments.

#### Scenario: Contrôle du build de préprod
- **WHEN** le site est construit avec `ENV=preprod`
- **THEN** chaque page contient la balise meta robots et `public/.htaccess` contient l'en-tête `X-Robots-Tag`

#### Scenario: Contrôle du build de production
- **WHEN** le site est construit avec `ENV=prod`
- **THEN** aucune page ne contient `noindex` et `.htaccess` ne contient pas `X-Robots-Tag`

### Requirement: Configuration de la préprod dans .env
Le chemin SFTP et l'URL de la préprod SHALL être lus dans `.env` (`PREPROD_FTP_PATH`, `PREPROD_URL`) et documentés dans `.env.example` ; une valeur manquante MUST faire échouer la commande préprod.

#### Scenario: Variable manquante
- **WHEN** `PREPROD_FTP_PATH` est absent de `.env` et l'utilisateur lance `make deploy ENV=preprod`
- **THEN** la commande s'arrête avec un message nommant la variable manquante, sans rien envoyer
