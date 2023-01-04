#!/usr/bin/env bash

# Cela lui permet de récupérer les fichiers dans les bons dossiers.
# Se lancera donc comme ça :
# $ ./script/iotrameurscript.sh


if [[ $# -ne 2 ]]
then
	echo "Deux arguments attendus: <dossier> <langue>"  # si on a pas deux arguments alors on sort car deux arguments sont attendus.
	exit
fi

#On attribue des noms de variables aux arguments
folder=$1 # dumps-text OU contextes
basename=$2 # en, fr, ru, pl, it, jp, etc... # le basename correspnd à la langue qu'on étudie

#On commence à créer la structure XML dans le fichier de sortie avec une valeur de balise lang égale à basename.
echo "<lang=\"$basename\">" > "./itrameur/$folder-$basename.txt" 


for filepath in $(ls $folder/$basename-*.txt) #on va itérer avec commande ls, on va rechercher tous les fichiers txt ayant dans leur nom la valeur de basename
do
	# filepath == dumps-texts/fr-1.txt
	# 	==> pagename = fr-1
	pagename=$(basename -s .txt $filepath)
	
    
	#On complète la page XML :
	echo "<page=\"$pagename\">" >> "./itrameur/$folder-$basename.txt"
	echo "<text>" >> "./itrameur/$folder-$basename.txt"
	
	# On récupère les dumps/contextes
	# et on écrit à l'intérieur de la balise text
	
	content=$(cat $filepath)
	# ordre important : & en premier
	# sinon : < => &lt; => &amp;lt;
	
	# On vient nettoyer le corpus de texte des éléments qui pourraient être présents et fausser l'arborescence XML
	content=$(echo "$content" | sed 's/&/\&amp;/g')
	content=$(echo "$content" | sed 's/</\&lt;/g')
	content=$(echo "$content" | sed 's/>/\&gt;/g')

	#On affiche le contenu dans le fichier de sortie
	echo "$content" >> "./itrameur/$folder-$basename.txt"

	# On insère pour chaque page les balises fermantes correspondantes
	echo "</text>" >> "./itrameur/$folder-$basename.txt"
	echo "</page> §" >> "./itrameur/$folder-$basename.txt"
done

# On clôture la structure XML
echo "</lang>" >> "./itrameur/$folder-$basename.txt"

