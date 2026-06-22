# Spec : Section Concerts (#concerts)

## Description

Liste des prochains concerts, pilotée par un data file YAML.
Chaque concert affiche la date, le lieu et un bouton vers la billetterie.

## Fichiers concernés

- `layouts/index.html` — template de la section (`<section id="concerts">`)
- `data/concerts.yaml` — liste des concerts
- `static/css/style.css` — styles `.concerts`, `.concert`, `.concert-date`, `.concert-venue`

## Schéma YAML

```yaml
- date: string        # Format libre, ex: "15 Nov 2025"
  venue: string       # Nom de la salle
  location: string    # Ville, Pays
  ticketLink: string  # URL complète ou "#" si pas de lien
```

## Template Hugo

```html
<section id="concerts">
    <h2>Prochains Concerts</h2>
    <div class="concerts">
        {{ range .Site.Data.concerts }}
        <div class="concert">
            <div class="concert-date">{{ .date }}</div>
            <div class="concert-venue">
                <strong>{{ .venue }}</strong><br>
                {{ .location }}
            </div>
            <a href="{{ .ticketLink }}" class="btn">Billets</a>
        </div>
        {{ end }}
    </div>
</section>
```

## Ajouter un concert

Éditer `data/concerts.yaml` et ajouter une entrée. L'ordre dans le YAML
détermine l'ordre d'affichage (pas de tri automatique par date).

## Concert passé

Il n'y a pas de gestion de concerts passés. Supprimer ou commenter les entrées
passées dans `data/concerts.yaml` pour ne pas les afficher.

## Concert sans lien billetterie

Utiliser `ticketLink: "#"`. Le bouton s'affiche mais ne redirige nulle part.
On pourrait envisager un champ `ticketLink` optionnel avec conditionnel Hugo.
