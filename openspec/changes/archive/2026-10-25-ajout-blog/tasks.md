# Tasks

## 1. Contenu

- [x] 1.1 Créer `content/blog/_index.md` (titre « Blog ») et un article d'exemple `content/blog/premier-article.md` (title, date, summary) et vérifier avec `hugo --minify` qu'ils sont générés
- [x] 1.2 Documenter le front matter des articles (title, date, summary, draft) dans `CLAUDE.md` et `openspec/config.yaml`

## 2. Templates et pagination

- [x] 2.1 Ajouter `paginate = 5` à `config.toml` et créer `layouts/blog/list.html` (liste du plus récent au plus ancien, `.Paginate`, liens Précédent/Suivant) et vérifier avec 6 articles de test que `public/blog/page/2/` existe
- [x] 2.2 Créer `layouts/blog/single.html` (titre, date, contenu, lien retour) et vérifier que la page d'article est générée
- [x] 2.3 Ajouter les styles du blog dans `static/css/style.css` (cartes d'articles, pagination, typographie de l'article) et vérifier le rendu desktop et mobile

## 3. Navigation

- [x] 3.1 Ajouter l'entrée `[[menu.main]]` « Blog » (`/blog/`, weight 7, Contact 8) dans `config.toml` et vérifier l'ordre du menu
- [x] 3.2 Mettre à jour `openspec/specs/navigation/spec.md` et créer `openspec/specs/blog/spec.md` et vérifier qu'ils décrivent la page

## 4. Vérification finale

- [x] 4.1 Vérifier avec `make serve` : liste, pagination (avec plus de 5 articles de test, à supprimer ensuite), page d'article, brouillons absents en `make build`, rendu mobile
