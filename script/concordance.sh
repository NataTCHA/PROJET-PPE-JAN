#!/usr/bin/bash


fichier_text=$1
motif=$2

if [[ $# -ne 2 ]]
then
	echo "Ce programme demande exactement deux arguments."
	exit
fi

if [[ ! -f $fichier_text ]]
then
  echo "le fichier $fichier_text n'existe pas"
  exit
fi

if [[ -z $motif ]]
then
  echo "le motif est vide"
  exit
fi

echo "

<!DOCTYPE html><html><head><meta charset=UTF-8 /><meta name=viewport content=width=device-width, initial-scale=1>
<link rel=stylesheet href=https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css /></head><body>
    <div class="table-container">
    <table class="table is-striped is-narrow is-hoverable is-fullwidth">
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <title>Concordance</title>
</head>
<body>

<thead>
  <tr>
    <th class=\"has-text-right\">Contexte droit</th>
    <th>Cible</th>
    <th class=\"has-text-left\">Contexte gauche</th>
  </tr>
</thead>
<tbody>
"

grep -E -o "(\w+\W+){0,5}\b$motif\b(\W+\w+){0,5}" $fichier_text | sed -E "s/(.*)($motif)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/"

echo "
</tbody>
</table>
</body>
</html>
"
