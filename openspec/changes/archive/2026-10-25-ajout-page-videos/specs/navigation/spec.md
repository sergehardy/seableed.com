# Spec Delta

## ADDED Requirements

### Requirement: Lien de menu vers la page Vidéos
Le menu principal SHALL contenir une entrée « Vidéos » pointant vers `/videos/`, placée entre « À propos » et « Contact », et les liens d'ancres (`/#concerts`, etc.) SHALL fonctionner depuis `/videos/`.

#### Scenario: Retour à l'accueil depuis Vidéos
- **WHEN** le visiteur est sur `/videos/` et clique sur « Concerts »
- **THEN** il arrive sur l'accueil, positionné sur la section Concerts

#### Scenario: Menu mobile sur Vidéos
- **WHEN** le visiteur ouvre le menu hamburger sur `/videos/`
- **THEN** le menu s'ouvre et se ferme comme sur l'accueil
