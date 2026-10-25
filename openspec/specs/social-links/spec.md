# Spec : Réseaux sociaux

## Description

Les liens vers les réseaux sociaux sont définis dans `data/social.yaml` et
affichés dans le pied de page de toutes les pages. Ils utilisent Font Awesome pour les icônes.

## Fichiers concernés

- `data/social.yaml` — liste des réseaux
- `layouts/partials/footer.html` — rendu dans le pied de page
- `layouts/_default/baseof.html` — chargement de Font Awesome (CDN)
- `static/css/style.css` — styles `.social-links`, `.social-links a`, `footer .social-links`

## Schéma YAML

```yaml
- name: string    # Nom affiché (attribut title sur le lien)
  url: string     # URL complète vers le profil
  icon: string    # Classe Font Awesome complète
```

## Réseaux actuels

| Réseau    | URL                                          | Icône                    | Statut  |
|-----------|----------------------------------------------|--------------------------|---------|
| Instagram | https://www.instagram.com/_seableed/          | `fa-brands fa-instagram` | actif   |
| Facebook  | https://www.facebook.com/profile.php?id=...  | `fa-brands fa-facebook`  | actif   |
| Spotify   | https://open.spotify.com/playlist/...        | `fa-brands fa-spotify`   | actif   |
| YouTube   | https://www.youtube.com/@seableed            | `fa-brands fa-youtube`   | actif   |
| Bandcamp  | —                                            | `fa-brands fa-bandcamp`  | commenté |

## Font Awesome

Version 6.5.1 chargée via CDN dans `baseof.html` :
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
```

Pour trouver le nom d'une icône : https://fontawesome.com/icons?f=brands

## Ajouter un réseau social

Ajouter une entrée dans `data/social.yaml`. L'ordre dans le YAML
détermine l'ordre d'affichage.

## Lien YouTube et future section Vidéos

Le compte YouTube (@seableed) est déjà dans `data/social.yaml`.
Quand la section Vidéos sera créée, elle utilisera ce même compte
pour l'embed YouTube (pas de duplication de la configuration).
