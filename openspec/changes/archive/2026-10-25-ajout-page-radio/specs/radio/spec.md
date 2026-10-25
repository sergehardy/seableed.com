# Spec Delta

## Purpose

Permettre d'écouter une playlist Spotify du groupe directement sur le site, depuis une page dédiée alimentée par un fichier de données.

## ADDED Requirements

### Requirement: Page Radio dédiée
Le site SHALL fournir une page `/radio/` distincte de l'accueil, avec le même en-tête, menu et pied de page.

#### Scenario: Accès par le menu
- **WHEN** le visiteur clique sur « Radio » dans le menu
- **THEN** la page `/radio/` se charge et affiche le lecteur

### Requirement: Lecteur Spotify piloté par data/radio.yaml
La page SHALL afficher un lecteur Spotify intégré pour la playlist décrite dans `data/radio.yaml` (`title`, `intro`, `playlist.id`, `playlist.url`), chargé en différé.

#### Scenario: Changement de playlist
- **WHEN** `playlist.id` est modifié dans le YAML
- **THEN** après reconstruction, le lecteur présente la nouvelle playlist

### Requirement: Lien de repli vers Spotify
La page SHALL proposer un lien visible vers la playlist sur Spotify (`playlist.url`).

#### Scenario: Lecteur indisponible
- **WHEN** le lecteur intégré ne s'affiche pas (bloqueur de contenu)
- **THEN** le visiteur peut toujours ouvrir la playlist via le lien

### Requirement: Pas d'iframe sur l'accueil
La page d'accueil MUST NOT charger d'iframe Spotify.

#### Scenario: Chargement de l'accueil
- **WHEN** l'accueil est ouvert
- **THEN** aucune requête vers `open.spotify.com` n'est émise
