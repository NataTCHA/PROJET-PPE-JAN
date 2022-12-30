echo "<file=$compteur>" >> dump_fr_concat.txt
	echo "$paragraphes" >> dump_fr_concat.txt
	echo "</file>" >> dump_fr_concat.txt

	echo "<file=$compteur>" >> contexte_fr_concat.txt
	cat $CONTEXTES/contexte--"$cptableau--$compteur".txt >>contextes_FRcontexte_fr_concat.txt
	echo "</file>" >> ./contextes_FR_concat.txt
