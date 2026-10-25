# Spec Delta

## Purpose

Rendre le site plus facile à trouver et à partager : métadonnées par page, aperçus de lien soignés, données structurées pour les moteurs et signalement du sitemap et du flux RSS.

## ADDED Requirements

### Requirement: Titre et description propres à chaque page
Chaque page SHALL avoir un `<title>` et une `meta description` propres, issus de son front matter (`title`, `description`) ou, à défaut, de valeurs par défaut du site, et une balise `canonical` vers sa propre URL.

#### Scenario: Page d'accueil
- **WHEN** la page d'accueil est affichée
- **THEN** son titre est « Seableed – groupe de rock à Rennes » et sa description décrit le groupe

#### Scenario: Article de blog
- **WHEN** un article de blog est affiché
- **THEN** sa description est son `summary` (ou `description`) et son `canonical` pointe vers l'URL de l'article

### Requirement: Aperçus de partage
Chaque page SHALL fournir les balises Open Graph et Twitter Card (titre, description, URL, image), avec une image de partage de 1200×630 px générée à partir de la photo du groupe.

#### Scenario: Partage d'un lien
- **WHEN** l'adresse d'une page est collée dans Facebook, WhatsApp ou un e-mail
- **THEN** l'aperçu affiche le titre, la description et l'image du groupe

### Requirement: Données structurées du groupe et des concerts
La page d'accueil SHALL contenir des données JSON-LD décrivant le groupe (`MusicGroup`, avec les liens de `data/social.yaml`) et un `Event` par concert dont la date est lisible au format `jj/mm/aaaa`.

#### Scenario: Concert avec une date lisible
- **WHEN** `data/concerts.yaml` contient un concert daté `20/06/2026`
- **THEN** le JSON-LD contient un `Event` à cette date, avec son lieu

#### Scenario: Concert sans date lisible
- **WHEN** la date d'un concert n'est pas au format `jj/mm/aaaa`
- **THEN** aucun `Event` n'est généré pour lui et le build ne produit pas d'erreur

### Requirement: robots.txt et sitemap
Le build de production SHALL publier `robots.txt` avec l'adresse du sitemap et sans règle `Disallow`, et le build de préproduction MUST NOT publier de `robots.txt` ; le `noindex` de la préproduction est conservé.

#### Scenario: Production
- **WHEN** le site est construit avec `ENV=prod`
- **THEN** `public/robots.txt` contient `Sitemap: https://www.seableed.com/sitemap.xml`

#### Scenario: Préproduction
- **WHEN** le site est construit avec `ENV=preprod`
- **THEN** il n'y a pas de `robots.txt` dans `public/` et chaque page garde la meta `noindex`

### Requirement: Découverte du flux RSS du blog
Les pages SHALL déclarer le flux RSS du blog par `<link rel="alternate" type="application/rss+xml">`.

#### Scenario: Détection par un lecteur RSS
- **WHEN** un lecteur RSS analyse une page du site
- **THEN** il trouve l'adresse du flux `/blog/index.xml`

### Requirement: Favicon
Le site SHALL déclarer un favicon dans le `<head>` de toutes les pages.

#### Scenario: Onglet du navigateur
- **WHEN** une page est ouverte
- **THEN** l'onglet affiche l'icône du groupe
