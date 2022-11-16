#!/usr/bin/env bash

#===============================================================================
# VOUS DEVEZ MODIFIER CE BLOC DE COMMENTAIRES.
# Ici, on décrit le comportement du programme.
# Indiquez, entre autres, comment on lance le programme et quels sont
if [ $# -ne 2 ]
then
	echo " ce programme demande deux arguments"
	exit
fi
# les paramètres.
# La forme est indicative, sentez-vous libres d'en changer !
# Notamment pour quelque chose de plus léger, il n'y a pas de norme en bash.
#===============================================================================

fichier_urls=$1 # le fichier d'URL en entrée
fichier_tableau=$2 # le fichier HTML en sortie
# !!!!!!
# ici on doit vérifier que nos deux paramètres existent, sinon on ferme!
# !!!!!!

# modifier la ligne suivante pour créer effectivement du HTML



   
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
                </tr>" >$fichier_tableau
                lineno=1;
                while read -r line;
do
        URL=$line
        CODEHTTP=$(curl -I -s $line | head -n1)	
	echo "<tr><td>$lineno</td><td>$CODEHTTP</td><td>$URL</td></tr>" >> $fichier_tableau
	lineno=$((lineno+1));
                
       done < $fichier_urls               

        echo "</table></body></html>" >> $fichier_tableau
