# Spec : Section Albums / Musique (#musique) — désactivée

## Description

Section pour afficher la discographie du groupe. Entièrement commentée dans
le code et les données. La structure est en place et prête à être réactivée.

## Statut

**Désactivé** — tout est commenté dans `layouts/index.html` et `data/albums.yaml`.

## Fichiers concernés

- `layouts/index.html` — template commenté
- `data/albums.yaml` — données commentées
- `config.toml` — entrée de menu commentée (`weight = 2`)

## Schéma YAML (albums.yaml)

```yaml
- title: string    # Titre de l'album / EP
  year: number     # Année de sortie
  cover: string    # Texte descriptif (pas d'image pour l'instant)
  link: string     # URL ou "#"
```

## Template Hugo (commenté dans index.html)

```html
<section id="musique">
    <h2>Notre Musique</h2>
    <div class="albums">
        {{ range .Site.Data.albums }}
        <div class="album">
            <div class="album-cover">{{ .cover }}</div>
            <h3>{{ .title }}</h3>
            <p>{{ .year }}</p>
            <a href="{{ .link }}" class="btn">Écouter</a>
        </div>
        {{ end }}
    </div>
</section>
```

## Pour réactiver la section

1. Décommenter le bloc `<section id="musique">` dans `layouts/index.html`
2. Décommenter les entrées dans `data/albums.yaml`
3. Décommenter l'entrée menu dans `config.toml` (`name = "Musique"`)
4. Réactiver le bouton CTA dans la section hero (lien vers `#musique`)

## Images de couverture

Le champ `cover` est actuellement un texte descriptif. Pour de vraies images,
il faudrait :
- Ajouter les images dans `static/images/albums/`
- Modifier le champ `cover` pour devenir un chemin d'image
- Mettre à jour le template pour utiliser `<img>` au lieu du texte
