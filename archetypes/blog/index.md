---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ now.Format "2006-01-02" }}
summary: "Une phrase pour la liste des articles."
draft: true   # passer à false pour publier
---

Texte de l'article.
