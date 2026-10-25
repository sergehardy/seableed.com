# Spec Delta

## ADDED Requirements

### Requirement: Liens du menu relatifs au baseURL
Les liens du menu SHALL tenir compte du chemin du `baseURL`, afin que la navigation (pages dédiées et ancres de l'accueil) fonctionne que le site soit servi à la racine ou dans un sous-répertoire.

#### Scenario: Site servi dans /preprod/
- **WHEN** le site est construit avec le `baseURL` `https://www.seableed.com/preprod/` et le visiteur clique sur « Vidéos »
- **THEN** il arrive sur `/preprod/videos/` et non sur `/videos/`

#### Scenario: Ancre depuis une page dédiée en préprod
- **WHEN** le visiteur est sur `/preprod/videos/` et clique sur « Concerts »
- **THEN** il arrive sur l'accueil de la préprod (`/preprod/#concerts`)
