# Spec : Section À propos (#apropos)

## Description

Section de présentation du groupe. Contrairement aux autres sections,
le contenu est rédigé en Markdown (pas en YAML), ce qui permet une mise
en forme riche sans modifier les templates.

## Fichiers concernés

- `layouts/index.html` — template de la section (`<section id="apropos">`)
- `content/_index.md` — contenu Markdown affiché via `{{ .Content }}`
- `static/css/style.css` — styles `.about`

## Template Hugo

```html
<section id="apropos">
    <h2>À Propos</h2>
    <div class="about">
        {{ .Content }}
    </div>
</section>
```

## Contenu actuel (content/_index.md)

```markdown
---
title: "Accueil"
---

### Seableed
est un groupe rennais fraîchement crée, né de l'envie de reprendre des titres rock
et pop mêlant guitare et claviers.

### Rock
indé, grunge, new-wave, brit-pop, mais aussi "bon vieux rock"...

### En construction
donc mais déjà sur scène !
```

## Membres mentionnés

Serge, Sébastien et Jean-Marie.

## Particularité

C'est la **seule section non pilotée par un data file YAML**.
Pour modifier le texte "À propos" : éditer `content/_index.md`.
Pour ajouter des photos de membres ou des données structurées, il faudrait
soit passer à un data file, soit enrichir le front matter de `_index.md`.
