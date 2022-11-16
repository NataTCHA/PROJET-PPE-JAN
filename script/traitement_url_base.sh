#!/usr/bin/env bash

#===============================================================================
# Ce script est notre premier programme pour traiter les URLs. Il permet de créer un tableau HTML en sortie avec chaque URL, le code de réponse correspondant .
# Il s'utilise dans le dossier avec le fichier à traiter <URL.txt> (avec un URL/ligne) avec la ligne de commande :
# bash traitement_url_base.sh <URL.txt>  <tableauURL.html> 

#<tableauURL.html>  est le fichier de sortie du tableau HTML (ici il n'existe pas avant le lancement du script).
#===============================================================================

# On vérifie que l'on a 2 arguments :
if [ $# -ne 2 ]
then
	echo " ce programme demande deux arguments"
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

# On crée l'architecture HTML du tableau de sortie dans le fichier donné en second argument :
echo "<html>
        <head>
                <meta charset ="utf-8"/>
                <title> tableau </title>
                </header>
                <body>
                <table>
                <tr>
                <th> ligne </th>
                <th>code</th>
                <th>url</th> 
                </tr>" > $fichier_tableau
                
 # On crée un compteur pour les URLs/le nombre de lignes :               
lineno=1;

# On lit chaque ligne :
while read -r line;
do
        # On récupère l'URL (=la ligne)
        URL=$line
        # On récupère le code de réponse :
        CODEHTTP=$(curl -I -s $line | head -n1)
        # On ajoute une ligne avec le code de réponse et l'URL au tableau HTML :
        # Les doubles chevrons permettent de ne pas écraser le fichier de sortie.
	    echo "<tr><td>$lineno</td><td>$CODEHTTP</td><td>$URL</td></tr>" >> $fichier_tableau
	    # On incrément le compteur :
	    lineno=$((lineno+1));
# On clot la boucle et on indique le fichier à parcourir :
done < $fichier_urls           
    
# On clot le tableau HTML :
        echo "</table></body></html>" >> $fichier_tableau
