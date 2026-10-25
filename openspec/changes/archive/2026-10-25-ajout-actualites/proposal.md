# Proposal

## Why

Le blog n'est visible que par son entrée de menu. Montrer le dernier article sur la page d'accueil met la nouveauté devant les visiteurs et organisateurs, sans qu'ils aient à ouvrir le blog, et donne une raison de revenir sur le site.

## What Changes

- Nouvelle section « Actualités » sur la page d'accueil (absente aujourd'hui du HTML), placée entre « À propos » et « Concerts », avec l'ancre `#actualites`.
- Elle affiche le dernier article publié du blog (date, titre, résumé, bouton « Lire l'article ») et un lien « Tous les articles » vers `/blog/`.
- La section n'apparaît pas s'il n'y a aucun article publié. Les brouillons et les articles datés dans le futur ne sont pas pris en compte.
- Pas de nouvelle entrée dans le menu : « Blog » y est déjà.

## Capabilities

### New Capabilities
- `actualites`: section d'accueil présentant le dernier article du blog.

### Modified Capabilities

## Impact

- Data files YAML : aucun (la source est `content/blog/*.md`, pas un data file).
- Code : `layouts/index.html` (nouvelle section), `static/css/style.css` (réutilise les styles `.post-card`, ajustements éventuels).
- Docs/specs : `README.md`, `CLAUDE.md`, spec `actualites` (nouvelle), spec `architecture` (ordre des sections).
