# Design

## Context

Hugo gère nativement sections, listes et pagination. Le site utilise déjà des pages dédiées (`/videos/`) avec `baseof.html` partagé. Voir proposal.md.

## Goals / Non-Goals

**Goals:**
- Blog `/blog/` natif Hugo, articles Markdown, liste paginée.

**Non-Goals:**
- Pas de flux RSS, tags, catégories, commentaires ou recherche dans ce change.

## Decisions

- **Section Hugo** `content/blog/` avec `_index.md` (titre de la page) : `layouts/blog/list.html` et `layouts/blog/single.html`. Alternative écartée : data YAML (le Markdown est demandé).
- **Pagination native** : `{{ $p := .Paginate (.Pages.ByDate.Reverse) }}` et `.Paginator` ; taille via `paginate = 5` dans `config.toml` (Hugo 0.123 : clé `paginate` à la racine). Contrôles Précédent/Suivant + numéros, masqués s'il n'y a qu'une page (`{{ if gt $p.TotalPages 1 }}`).
- **Résumé** : `summary` du front matter, sinon `.Summary` Hugo.
- **Style** : cartes comme `.concerts`/`.about`, réutilisant le thème teal/rust.
- **Menu** : weight 7 (après Radio 6), Contact à 8. Si Radio n'est pas encore implémenté, ajuster les weights au moment de l'apply.

## Risks / Trade-offs

- [Conflit de weights de menu avec le change Radio] → les deux changes fixent Radio 6, Blog 7, Contact 8 ; vérifier l'ordre au moment de l'apply.
- [Articles datés dans le futur non publiés par défaut] → comportement Hugo normal (`buildFuture`), à rappeler dans la doc.
