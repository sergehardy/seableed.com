# Spec : Navigation

## Description

Navigation sticky en haut de page, responsive avec menu hamburger sur mobile.
Les liens pointent vers des ancres de la page d'accueil (`/#section`), sauf « Vidéos » qui pointe vers la page dédiée `/videos/`.

## Fichiers concernés

- `layouts/partials/header.html` — structure HTML de la nav
- `static/js/main.js` — comportement hamburger menu
- `static/css/style.css` — styles nav (header sticky, breakpoint 768px)
- `config.toml` — définition des items de menu

## Menus (config.toml)

```toml
[[menu.main]]
  name = "Accueil"
  url = "/"
  weight = 1
[[menu.main]]
  name = "Concerts"
  url = "/#concerts"
  weight = 3
[[menu.main]]
  name = "À propos"
  url = "/#apropos"
  weight = 4
[[menu.main]]
  name = "Vidéos"
  url = "/videos/"
  weight = 5
[[menu.main]]
  name = "Contact"
  url = "/#contact"
  weight = 6
```

Le menu "Musique" (`/#musique`, weight 2) est commenté dans config.toml.

## Comportement

- Header fixe (sticky) en haut de page
- Logo = nom du groupe (texte, depuis `config.toml` params.bandName)
- Sur mobile (< 768px) : hamburger menu (3 barres horizontales)
  - Toggle via JS sur les classes `.active` de `#mobile-menu` et `#nav-menu`
  - Fermeture automatique au clic sur un lien
- Smooth scroll pour tous les liens d'ancrage (`a[href^="#"]`)
- Depuis `/videos/`, les liens `/#section` ramènent à l'accueil sur la section

## Ajouter un item de menu

1. Ajouter une entrée `[[menu.main]]` dans `config.toml`
2. Créer la section correspondante dans `layouts/index.html`
3. Si besoin, ajouter l'ancre dans la navigation
