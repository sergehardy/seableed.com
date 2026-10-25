# Tasks

## 1. Données

- [x] 1.1 Créer `data/videos.yaml` (channel `https://www.youtube.com/@seableed`, playlist « Fête de la musique 2026 » `PLF4EOYR9fg2whpQl0ImqItlzflPx_BGRk`, vidéos « Fortunate son » `vudTL8M3hqk` et « Lonely boy » `f5XM0AnTaKU`) et vérifier avec `hugo --minify` qu'aucune erreur de parsing n'apparaît
- [x] 1.2 Documenter le schéma de `data/videos.yaml` dans `CLAUDE.md` et `openspec/config.yaml` et vérifier que les deux fichiers décrivent les mêmes champs

## 2. Page /videos/

- [x] 2.1 Créer `content/videos.md` (`title: "Vidéos"`) et `layouts/videos/single.html` (bandeau + bouton chaîne, une rubrique par playlist avec lien, grille d'embeds `youtube-nocookie.com`, `loading="lazy"`) et vérifier que `public/videos/index.html` est généré avec les 2 iframes
- [x] 2.2 Ajouter dans `static/css/style.css` les styles `.videos-hero`, `.playlist`, `.videos`, `.video`, `.video-embed` (16/9, grille responsive, 1 colonne < 768 px) et vérifier visuellement desktop et mobile

## 3. Navigation

- [x] 3.1 Ajouter l'entrée `[[menu.main]]` « Vidéos » (`/videos/`, placé entre À propos et Contact, weight 5, Contact passe à 6) dans `config.toml` et vérifier l'ordre du menu
- [x] 3.2 Vérifier depuis `/videos/` que les liens `/#concerts`, `/#apropos`, `/#contact` ramènent à l'accueil et que le menu burger fonctionne (`static/js/main.js` inchangé sauf si nécessaire)

## 4. Specs et vérification finale

- [x] 4.1 Mettre à jour `openspec/specs/architecture/spec.md` (site plus strictement mono-page) et le tableau des ancres de `CLAUDE.md`
- [x] 4.2 Vérifier avec `make serve` : page `/videos/` complète, lecture des deux vidéos, liens chaîne et playlist, rendu mobile, accueil sans iframe
