# Spec Delta

## ADDED Requirements

### Requirement: Page dédiée aux vidéos
Le site SHALL fournir une page `/videos/` distincte de la page d'accueil, avec le même en-tête, menu et pied de page que l'accueil.

#### Scenario: Accès par le menu
- **WHEN** le visiteur clique sur « Vidéos » dans le menu
- **THEN** le navigateur charge la page `/videos/` et affiche les vidéos

### Requirement: Contenu piloté par data/videos.yaml
La page SHALL être générée à partir de `data/videos.yaml`, qui décrit la chaîne YouTube (`name`, `url`) et une liste de playlists (`title`, `url`), chacune contenant des vidéos (`title`, `youtubeId`).

#### Scenario: Ajout d'une vidéo
- **WHEN** une entrée `title` + `youtubeId` est ajoutée à une playlist du YAML
- **THEN** la vidéo apparaît dans la rubrique de cette playlist après reconstruction du site

### Requirement: Rubriques par playlist avec liens YouTube
Chaque playlist SHALL être présentée en rubrique avec son titre et un lien vers la playlist YouTube, et la page SHALL proposer un lien visible vers la chaîne YouTube.

#### Scenario: Liens vers YouTube
- **WHEN** la page est affichée
- **THEN** un bouton mène à la chaîne `https://www.youtube.com/@seableed` et chaque rubrique contient un lien vers sa playlist

### Requirement: Intégration respectueuse et performante
Les vidéos SHALL être intégrées via `youtube-nocookie.com` avec chargement différé, et la page d'accueil MUST NOT charger d'iframe YouTube.

#### Scenario: Chargement différé
- **WHEN** la page `/videos/` s'ouvre
- **THEN** les iframes situées hors de l'écran ne se chargent qu'à l'approche du défilement

### Requirement: Mise en page responsive
La grille de vidéos SHALL conserver un ratio 16/9 et s'adapter à la largeur (plusieurs colonnes sur desktop, une colonne sur mobile).

#### Scenario: Affichage mobile
- **WHEN** la largeur d'écran est inférieure à 768 px
- **THEN** les vidéos s'affichent en une colonne pleine largeur sans défilement horizontal
