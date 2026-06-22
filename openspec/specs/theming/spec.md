# Spec : Thème CSS

## Description

Le site utilise un thème CSS vanilla. Trois fichiers CSS existent mais un seul
est chargé. Les deux autres sont des variantes expérimentales non actives.

## Fichiers concernés

- `static/css/style.css` — thème actif (teal/rust)
- `static/css/style-jaune.css` — variante jaune (orpheline)
- `static/css/style-vert.css` — doublon du thème principal (orpheline)
- `layouts/_default/baseof.html` — chargement du CSS (hardcodé)

## Thème actif (style.css)

| Rôle               | Variable / usage       | Valeur     |
|--------------------|------------------------|------------|
| Header / Footer    | background             | `#3a5a52`  |
| Couleur principale | texte header, titres   | `#2c3e3a`  |
| Fond de page       | background body        | `#f5f0e8`  |
| Boutons CTA        | background `.btn`      | `#d4604d`  |
| Texte bouton hover | color `.btn:hover`     | `#fff`     |
| Fond sections pair | background sections    | `#fff`     |

## Charger le CSS dans baseof.html

```html
<link rel="stylesheet" href="{{ "css/style.css" | relURL }}">
```

Le fichier est hardcodé. Pour switcher de thème, modifier cette ligne.
Il n'y a pas de sélection dynamique de thème.

## Variantes orphelines

- `style-jaune.css` : thème avec header jaune (`#f4e5a5`), texte brun
- `style-vert.css` : copie quasi-identique de `style.css` (teal)

Ces fichiers ne sont référencés nulle part et n'ont pas d'effet sur le site.
Ils peuvent servir de base pour un futur système de thèmes, ou être supprimés.

## Responsive

Breakpoint principal à `768px` :
- Navigation : hamburger menu en dessous de 768px
- Sections : passage de grille/flex à colonne unique

## Conventions CSS

- Pas de préprocesseur (pas de Sass/Less)
- Pas de framework (pas de Tailwind, Bootstrap)
- Classes BEM-lite : `.concert`, `.concert-date`, `.concert-venue`, etc.
