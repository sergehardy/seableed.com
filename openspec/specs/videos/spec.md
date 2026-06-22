# Spec : Section Vidéos (#videos) — planifiée

## Description

Section pour intégrer des vidéos YouTube du groupe. N'existe pas encore.
Le compte YouTube est déjà référencé dans `data/social.yaml`.

## Statut

**Planifié** — rien n'existe dans le code.

## Compte YouTube

```
URL : https://www.youtube.com/@seableed
```

Déjà présent dans `data/social.yaml` comme lien de réseau social.

## Options d'implémentation

### Option A : Data file YAML + embed iframe

```yaml
# data/videos.yaml
- title: string      # Titre de la vidéo
  youtubeId: string  # ID YouTube (ex: "dQw4w9WgXcQ")
  description: string # Description courte (optionnel)
```

Template Hugo :
```html
<section id="videos">
    <h2>Nos Vidéos</h2>
    <div class="videos">
        {{ range .Site.Data.videos }}
        <div class="video">
            <h3>{{ .title }}</h3>
            <div class="video-embed">
                <iframe
                    src="https://www.youtube.com/embed/{{ .youtubeId }}"
                    allowfullscreen
                    loading="lazy">
                </iframe>
            </div>
        </div>
        {{ end }}
    </div>
</section>
```

### Option B : Lien simple vers la playlist/chaîne

Sans embed, juste des vignettes cliquables renvoyant vers YouTube.
Plus simple, pas de consentement cookies tiers à gérer.

## Considérations

- **RGPD** : l'embed YouTube dépose des cookies tiers. En France, il faut
  informer l'utilisateur ou utiliser `youtube-nocookie.com` comme domaine d'embed.
- **Performance** : les iframes YouTube peuvent alourdir le chargement initial.
  L'attribut `loading="lazy"` est recommandé.
- **Navigation** : ajouter `#videos` dans `config.toml` et l'ordre dans `index.html`
  (logiquement entre `#apropos` et `#concerts`, ou après `#contact`).

## Fichiers à créer lors de l'implémentation

- `data/videos.yaml`
- Bloc `<section id="videos">` dans `layouts/index.html`
- Entrée `[[menu.main]]` dans `config.toml`
- Styles `.videos`, `.video`, `.video-embed` dans `static/css/style.css`
