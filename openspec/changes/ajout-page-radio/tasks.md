# Tasks

## 1. Données

- [x] 1.1 Créer `data/radio.yaml` (title, intro, playlist.id, playlist.url) avec l'ID réel fourni par l'utilisateur et vérifier avec `hugo --minify` l'absence d'erreur
- [x] 1.2 Documenter le schéma de `data/radio.yaml` dans `CLAUDE.md` et `openspec/config.yaml` et vérifier que les deux décrivent les mêmes champs

## 2. Page /radio/

- [x] 2.1 Créer `content/radio.md` (`title: "Radio"`, `type: radio`) et `layouts/radio/single.html` (titre, intro, iframe Spotify lazy, lien de repli) et vérifier que `public/radio/index.html` contient l'iframe
- [ ] 2.2 Ajouter dans `static/css/style.css` les styles de la page Radio (carte, iframe pleine largeur, responsive) et vérifier le rendu desktop et mobile

## 3. Navigation

- [x] 3.1 Ajouter l'entrée `[[menu.main]]` « Radio » (`/radio/`, weight 6) et ajuster le weight de Contact dans `config.toml`, puis vérifier l'ordre du menu
- [x] 3.2 Mettre à jour `openspec/specs/navigation/spec.md` et créer `openspec/specs/radio/spec.md` et vérifier que les deux décrivent la page

## 4. Vérification finale

- [ ] 4.1 Vérifier avec `make serve` : lecteur fonctionnel, lien de repli, accueil sans iframe Spotify, rendu mobile
