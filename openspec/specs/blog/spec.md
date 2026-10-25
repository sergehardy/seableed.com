# Spec : Blog (/blog/)

## Description

Section Hugo native : articles en Markdown, liste paginée et page par article.

## Statut

**Actif**

## Fichiers concernés

- `content/blog/_index.md` — titre et intro de la liste
- `content/blog/*.md` — articles
- `layouts/blog/list.html` — liste paginée
- `layouts/blog/single.html` — page d'article
- `config.toml` — `paginate = 5` et entrée de menu « Blog » (`/blog/`, weight 7)
- `static/css/style.css` — styles `.blog-hero`, `.post-card`, `.post`, `.pagination`

## Front matter d'un article

```yaml
title: string
date: YYYY-MM-DD
summary: string   # optionnel (sinon résumé automatique de Hugo)
draft: bool       # true : non publié par make build
```

## Comportement

- Liste du plus récent au plus ancien : date, titre, résumé, bouton « Lire ».
- Pagination native (Précédent / numéros / Suivant), masquée s'il n'y a qu'une page.
- Page d'article : date, titre, contenu, lien « Retour au blog ».
- Les articles datés dans le futur ne sont pas publiés par défaut (comportement Hugo).

## Images et vidéos

- Article avec photos : dossier `content/blog/<nom>/index.md` avec les photos à côté. `layouts/_default/_markup/render-image.html` réduit chaque photo à 1200 px de large maximum (WebP, qualité 85), ajoute `loading="lazy"` et `width`/`height`, et affiche une légende si un titre est donné (`![alt](photo.jpg "légende")`).
- Les photos d'origine ne sont pas publiées (`cascade.build.publishResources: false` dans `content/blog/_index.md`) ; `make check` refuse un jpg/png dans `public/`.
- Vidéo YouTube : shortcode `{{< youtube ID >}}`, servie par `youtube-nocookie.com` (`[privacy.youtube] privacyEnhanced = true`). Le HTML brut n'est pas rendu (comportement par défaut de Hugo).
- `archetypes/blog/index.md` crée un article-dossier en brouillon (`hugo new content blog/<nom>`).

## Exigences

- Chaque `content/blog/*.md` SHALL produire `/blog/<slug>/`.
- Un article `draft: true` MUST NOT être publié par `make build`.
