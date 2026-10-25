# Proposal

## Why

Le groupe veut une « Radio » : un endroit où les organisateurs et le public écoutent une sélection de titres, sans quitter le site. Une playlist Spotify intégrée remplit ce rôle sans héberger d'audio.

## What Changes

- Nouvelle page native Hugo `/radio/` (totalement absente aujourd'hui), avec le même en-tête et pied de page que le reste du site.
- Lecteur Spotify intégré (iframe) pour une playlist, avec un lien direct vers la playlist comme repli.
- Contenu piloté par un nouveau data file `data/radio.yaml` (titre, texte d'intro, identifiant et URL de la playlist).
- Nouvelle entrée « Radio » dans le menu principal.

## Capabilities

### New Capabilities
- `radio`: page `/radio/` avec lecteur Spotify intégré et lien vers la playlist, pilotée par `data/radio.yaml`.

### Modified Capabilities
- `navigation`: ajout d'une entrée de menu « Radio » vers `/radio/`.

## Impact

- Data files YAML : nouveau `data/radio.yaml`.
- Code : `content/radio.md`, `layouts/radio/single.html`, `config.toml` (menu), `static/css/style.css`.
- Docs/specs : `CLAUDE.md`, `openspec/config.yaml`, specs `radio` et `navigation`.
- Dépendance externe : iframe `open.spotify.com` (cookies tiers de Spotify).
