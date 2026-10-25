# Mémo : ce qu'il reste à faire

Dernière mise à jour : 25/10/2026.

## Référencement et visibilité (à faire à la main)

- [ ] Ajouter le site dans [Google Search Console](https://search.google.com/search-console) (propriété `https://www.seableed.com/`) puis soumettre `https://www.seableed.com/sitemap.xml`.
- [ ] Faire de même dans [Bing Webmaster Tools](https://www.bing.com/webmasters).
- [ ] Mettre l'adresse du site dans les bios Instagram, Facebook, YouTube et Spotify : ces liens vers le site sont le meilleur levier de référencement.
- [ ] Tester l'aperçu d'une page dans le [débogueur de partage Facebook](https://developers.facebook.com/tools/debug/) (il force aussi le rafraîchissement de l'image en cache).
- [ ] Vérifier le favicon dans l'onglet du navigateur : `assets/favicon.ico` fait 150×72 px, donc il n'est pas carré. Si le rendu est mauvais, fournir une image carrée (logo ou initiale).

## Contenu à tenir à jour

- [ ] `data/concerts.yaml` : les concerts de la liste sont tous passés. Ajouter les prochaines dates (format `jj/mm/aaaa` pour qu'elles apparaissent dans les données structurées de Google) et retirer ou commenter les anciennes.
- [ ] Blog : `content/blog/instagram.md` et `youtube.md` sont des brouillons (`draft: true`). Les rédiger puis passer `draft: false`. Les brouillons ne sont pas publiés ; `make serve DEBUG=true` permet de les voir en local.
- [ ] Blog : les articles récents dans `content/blog/` ne sont pas encore committés. Les relire, puis `git add` et commit.
- [ ] Vérifier le titre et l'adresse de l'article `content/blog/concert-barzouges.md` (le titre parle des vidéos de la fête de la musique à Cesson).
- [ ] Photos de la pellicule : remplacer ou compléter `assets/pellicule/` quand il y en a de nouvelles (voir README).

## Sécurité et hébergement

- [ ] Changer le mot de passe SFTP chez OVH : l'ancien a été affiché dans des sorties de terminal pendant une session de travail. Mettre à jour `.env`.
- [ ] Supprimer la sauvegarde de l'ancien historique Git (fichier `seableed-avant-reecriture.bundle`, dans le dossier temporaire de la session) quand tout est vérifié : elle contient d'anciennes adresses e-mail.
- [ ] Décider si la préprod (`/preprod/`) doit être protégée par mot de passe (`.htpasswd`). Aujourd'hui elle est seulement non indexée.
- [ ] Récupérer, si besoin, la copie de `images/WhatsApp Image 2026-09-27 at 19.14.23(1).jpeg`, supprimée du serveur lors du déploiement de production (copie dans le dossier temporaire de la session).

## Idées de suite

- [ ] Albums : réactiver la section quand il y aura de la musique à présenter (voir `openspec/specs/albums/spec.md`).
- [ ] Concerts : tri automatique par date et masquage des concerts passés.
- [ ] Image de partage : une image dédiée de 1200×630 px au lieu du recadrage de la photo du hero.
- [ ] Thèmes CSS : supprimer les variantes de `themes-alternatifs/` ou construire un vrai système de thèmes.

## Procédure de mise en ligne (rappel)

1. Arrêter `make serve` (un serveur Hugo en marche peut réécrire `public/`).
2. `make deploy-dry ENV=preprod`, relire, puis `make deploy ENV=preprod`.
3. Contrôler `https://www.seableed.com/preprod/` (pages, menu, mobile).
4. `make deploy-dry`, relire les suppressions, puis `make deploy` pour la production.
5. `git push`.

Détails dans `README.md`.
