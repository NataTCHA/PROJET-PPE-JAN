#!/usr/bin/env bash

#===============================================================================
# Ce script est notre programme pour traiter les URLs. Il permet de créer un tableau HTML en sortie avec chaque URL, le code de réponse correspondant .
# Il s'utilise dans le dossier avec le fichier à traiter <URL.txt> (avec un URL/ligne) avec la ligne de commande :
# bash traitement_url_base.sh <URL.txt>  <tableauURL.html> "<motif recherché>"

#<tableauURL.html>  est le fichier de sortie du tableau HTML (ici il n'existe pas avant le lancement du script).
#Il est nécéssaire d'avoir créer un dossier 'aspirations' dans le dossier d'utilisation du script.
#===============================================================================
if [ $# -ne 3 ]
then
	echo " Ce programme demande trois arguments."
	exit
fi

# On vérifie que le fichier d'URLs existe :
if [ -f $1 ]
	then
		echo "Fichier OK"
	else
		echo "Ceci n'est pas un fichier valide."
		exit
fi

# On attribue les fichiers en argument à des variables :

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie
motif=$3 # le motif recherché

echo $fichier_urls;
basename=$(basename -s .txt $fichier_urls)

# On crée l'architecture HTML du tableau de sortie dans le fichier donné en second argument :
echo "<!DOCTYPE html><html><head><meta charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css" /></head><body>" > $fichier_tableau
echo "<h2>Tableau $basename :</h2>" >> $fichier_tableau
echo "<br/>" >> $fichier_tableau
echo "<table>" >> $fichier_tableau
echo "<tr><th>N°</th><th>Code</th><th>URL</th><th>Encodage</th><th>Nb occurences</th></tr>" >> $fichier_tableau
# On crée un compteur pour les URLs/le nombre de lignes :               
lineno=1;
#
while read -r line;
do
# On récupère l'URL (=la ligne)
    URL=$line
	# On récupère le code :
    CODEHTTP=$(curl -I -s $line | grep -e "^HTTP/" | grep -Eo "[0-9]{3}" | head -n1)	
	# On récupère l'encodage :
    ENC=$(curl -I -s $line | grep -Po "charset=[\w-]+"| cut -d= -f2)
	# On récupère le contenu de la page HTML
	aspiration=$(curl $URL)
	# On met le contenu dans un document HTML dédié
	echo "$aspiration" > "aspirations/$basename-$lineno.html"

	# On affiche les informations importantes dans le terminal
	#echo -e "\tURL : $URL";
	echo -e "\tURL N°: $lineno";
    echo -e "\tCode : $CODEHTTP";

	# Si ENC n'existe pas :
	if [[ ! $ENC ]]
	then
		# On définit l'encodage en UTF-8
		echo -e "\tEncodage non détecté, on prend UTF-8 par défaut.";
		ENC="UTF-8";
	# Sinon on garde l'encodage détécté
	else
		echo -e "\tEncodage : $ENC";
	fi

	# Si le code est égal à 200 :
	if [[ $CODEHTTP -eq 200 ]]                                                                                                                                         
	then 
		dump=$(lynx -dump -nolist -assume_charset=$ENC -display_charset=$ENC $URL)
		echo "$dump" > "dumps-text/$basename-$lineno.txt" 
		if [[ $ENC -ne "UTF-8" && -n "$dump" ]]
		# On vient convertir le fichier en UTF-8 grâce à iconv
			then
				dump=$(echo $dump | iconv -f $ENC -t UTF-8//IGNORE)
				
		fi
	# Si le code n'est pas 200, on ne récupère pas le contenu :	
	else
		echo -e "\tCode différent de 200, utilisation d'un dump vide."
		dump=""
		ENC=""
	fi


echo "$dump" > "./dumps-text/fich-$lineno.txt"

count=$(echo $dump | grep -o -i -P "$motif"| wc -l)
grep -E -A2 -B2 $motif ./dumps-text/fich-$lineno.txt > ./contextes/fich-$lineno.txt
bash programmes/concordance.sh ./dumps-text/fich-$lineno.txt $motif > ./concordances/fich-$lineno.html
echo "<tr><td>$lineno</td><td>$CODEHTTP</td><td><a href=\"$URL\">$URL</a></td><td>$ENC</td><td><a href="../aspirations/fich-$lineno.html">html</a></td><td><a href="../dumps-text/fich-$lineno.txt">text</a></td><td>$count</td><td><a href="../contextes/fich-$lineno.txt">contextes</a></td><td><a href="../concordances/fich-$lineno.html">concordance</a></td></tr>" >> $fichier_tableau
lineno=$((lineno+1));

done < $fichier_urls               
# On ferme le fichier HTML :
echo "</table></body></html>" >> $fichier_tableau
