# Spec : Section Hero (#accueil)

## Description

Première section visible de la page. Affiche le nom du groupe, le genre musical
et la ville. Point d'entrée visuel du site.

## Fichiers concernés

- `layouts/index.html` — template de la section (`<section class="hero" id="accueil">`)
- `config.toml` — source des données affichées
- `static/css/style.css` — styles `.hero`
- `static/images/hero-band.jpg` — photo de fond (ou décoration)

## Template Hugo

```html
<section class="hero" id="accueil">
    <h1>{{ .Site.Params.bandName }}</h1>
    <p>{{ .Site.Params.genre }} - {{ .Site.Params.location }}</p>
</section>
```

## Données (config.toml)

```toml
[params]
  bandName = "Seableed"
  genre    = "Rock & co."
  location = "Rennes, France"
```

## Comportement visuel

- Fond sombre (teal `#3a5a52`) avec texte clair
- Pleine hauteur d'écran (`min-height: 100vh`)
- Centré verticalement et horizontalement
- `hero-band.jpg` utilisé comme image (présent dans `static/images/`)

## Bouton CTA désactivé

Un lien "Écouter notre musique" vers `#musique` est commenté dans le template.
À réactiver si la section Albums est remise en service.
