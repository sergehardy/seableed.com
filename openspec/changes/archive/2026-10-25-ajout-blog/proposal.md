# Proposal

## Why

Le groupe veut partager des nouvelles (concerts, répétitions, sorties) sans éditer du HTML. Un blog en Markdown, paginé, permet de publier simplement en ajoutant un fichier.

## What Changes

- Nouvelle section native Hugo `/blog/` (totalement absente aujourd'hui) : liste paginée des articles et page par article.
- Articles écrits en Markdown dans `content/blog/` (titre, date, résumé, brouillon).
- Pagination native Hugo, taille de page configurable (5 par défaut).
- Nouvelle entrée « Blog » dans le menu principal.
- Un premier article d'exemple.

## Capabilities

### New Capabilities
- `blog`: liste paginée et pages d'articles Markdown sous `/blog/`.

### Modified Capabilities
- `navigation`: ajout d'une entrée de menu « Blog » vers `/blog/`.

## Impact

- Data files YAML : aucun (le contenu est en Markdown dans `content/blog/`, pas dans `data/`).
- Code : `content/blog/*.md`, `layouts/blog/list.html`, `layouts/blog/single.html`, `config.toml` (menu, `paginate`), `static/css/style.css`.
- Docs/specs : `CLAUDE.md`, `openspec/config.yaml`, specs `blog` et `navigation`.
