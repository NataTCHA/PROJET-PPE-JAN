#!/usr/bin/env bash

# Attention : ce script doit être lancé depuis la racine du projet.
# Cela lui permet de récupérer les fichiers dans les bons dossiers.
# Se lancera donc comme ça :
# $ ./programmes/correction_itrameur.sh


if [[ $# -ne 2 ]]
then
	echo "Deux arguments attendus: <dossier> <langue>"  # si on a pas deux arguments alors on sort car deux arguments sont attendus.
	exit
fi

#On attribue des noms de variables aux arguments
folder=$1 # dumps-text OU contextes
basename=$2 # en, fr, ru, pl, it, jp, etc... # le basename correspnd à la langue qu'on étudie

echo "<lang=\"$basename\">" > "./itrameur/$folder-$basename.txt" #On commence à créer la structure XML dans le fichier de sortie avec une valeur de balise lang égale à basename.


for filepath in $(ls $folder/$basename-*.txt) #on va itérer avec commande ls, on va rechercher tous les fichiers txt ayant dans leur nom la valeur de basename
do
	# filepath == dumps-texts/fr-1.txt
	# 	==> pagename = fr-1
	pagename=$(basename -s .txt $filepath)
	
    
	#On complète la page XML :
	echo "<page=\"$pagename\">" >> "./itrameur/$folder-$basename.txt"
	echo "<text>" >> "./itrameur/$folder-$basename.txt"
	
	# on récupère les dumps/contextes
	# et on écrit à l'intérieur de la balise text
	
	content=$(cat $filepath)
	# ordre important : & en premier
	# sinon : < => &lt; => &amp;lt;
	
	# on récupère le contenu et on fait des modifications dessus : on fait deux groupes grâce à /g, grâce à /'s on détermine ce que l'on veut substituer et avec &amp, on détermine ce qu'on veut remplacer.

	content=$(echo "$content" | sed 's/&/&amp;/g')
	content=$(echo "$content" | sed 's/</&lt;/g')
	content=$(echo "$content" | sed 's/>/&gt;/g')

	echo "$content" >> "./itrameur/$folder-$basename.txt"
	#affichage du contenu dans le fichier de sortie

	echo "</text>" >> "./itrameur/$folder-$basename.txt"
	echo "</page> §" >> "./itrameur/$folder-$basename.txt"
done
# On cloture la structure XML
echo "</lang>" >> "./itrameur/$folder-$basename.txt"
