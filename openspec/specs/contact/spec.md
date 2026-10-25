# Spec : Section Contact (#contact)

## Description

Section de contact avec l'adresse email du groupe. Les icônes des réseaux sociaux ne sont plus ici :
elles sont dans le pied de page (voir spec social-links). Une page contact dédiée est prévue.

## Fichiers concernés

- `layouts/index.html` — template de la section (`<section id="contact">`)
- `config.toml` — source de l'email (`params.email`)
- `static/css/style.css` — styles `.contact`

## Template Hugo

```html
<section id="contact">
    <h2>Contact</h2>
    <div class="contact">
        <p>Pour toute demande de booking ou d'information :</p>
        <br/>
        <p><strong>Email :</strong> {{ .Site.Params.email }}</p>
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
