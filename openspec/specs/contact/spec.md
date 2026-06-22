# Spec : Section Contact (#contact)

## Description

Section de contact avec l'adresse email du groupe et les icônes des réseaux sociaux.
Deux sources de données : l'email vient de `config.toml`, les réseaux de `data/social.yaml`.

## Fichiers concernés

- `layouts/index.html` — template de la section (`<section id="contact">`)
- `config.toml` — source de l'email (`params.email`)
- `data/social.yaml` — liste des réseaux sociaux (voir spec social-links)
- `static/css/style.css` — styles `.contact`, `.social-links`

## Template Hugo

```html
<section id="contact">
    <h2>Contact</h2>
    <div class="contact">
        <p>Pour toute demande de booking ou d'information :</p>
        <br/>
        <p><strong>Email :</strong> {{ .Site.Params.email }}</p>
        <div class="social-links">
            {{ range .Site.Data.social }}
            <a href="{{ .url }}" title="{{ .name }}" target="_blank" rel="noopener">
                <i class="{{ .icon }}"></i>
            </a>
            {{ end }}
        </div>
    </div>
</section>
```

## Données (config.toml)

```toml
[params]
  email = "contact@seableed.com"
```

## Formulaire de contact

Il n'existe pas de formulaire de contact. Hugo étant un générateur statique,
un formulaire nécessiterait un service tiers (Formspree, Netlify Forms, etc.).
