### Journal de bord :

12/10/2022 : 

Nous avons procédé au choix de notre sujet. Nous avons décidé de nous intéresser au mot "étranger" en français, anglais ('outsider', 'foreigner', 'stranger'), allemand, "Fremder" et "Ausländer", espagnol. 
Il nous a semblé intéressant de nous pencher sur la pluralité des équivalents traductionnels du mot par rapport au français. Il y a en effet une dissymétrie entre le nombre de mot désignant les mêmes concepts dans plusieurs langues. 
En effet, en français la forme "étranger" est polysémique : elle désigne à la fois une personne extérieure à une communauté géographique, une personne extérieure à une communauté sociale ou encore quelqu'un qui n'est pas familière avec une autre, qui lui est étrangère. 
Dans les autres langues choisies, ces concepts sont désignés par plusieurs mots différents.
             
09/11/2022 : 

Nous avons ajouté des fichiers textes pour les URLs anglais, l'allemand et le français. Après réflexion, nous avons décidé de ne pas garder l'espagnol comme langue afin de nous concenctrer uniquement sur le français, l'anglais et l'allemand.

16/11/2022 :

Nous avons ajouté le premier script qui nous a servi à tester les URLs et à créer un tableau HTML récapitulatif avec l'URL et le code de réponse. Après un premier test, nous avons pu voir qu'une majeure partie des URLs sont valides mais qu'il existe des URLs qui renvoient un code d'erreur (404 et 303 notamment). 


 30/11/2022:
 
Nous avons élaboré le script pour le TD 2: scriptaspi.sh. Cependant un problème reste à résoudre en ce qui concerne notre tableau html. En effet le chemin des fichiers est errroné; par conséquent il ne débouche sur rien. 
 
 06/12/2022 : 
 
 Nous avons complété les URLs anglais (pour atteindre environ 40 URL pour chaque mot).
 Nous avons également complété les URL pour l'allemand. 
 
 07/12/2022:
 Nous avons crée et commenté le script itrameur. 

14/12/2022:
Pendant le cours nous avons vu comment faire un nuage de mots.  Pour cela il faut installer wordcloud sur la base anaconda. Voici la commande que j'ai lancé depuis Spider avec la commande suivante: conda install -c conda-forge wordcloud. 
Nous attendons cependant d'avoir une connexion autre que celle de l'université qui met à mal cette installation.
Nous avons complété les URLs Français ( pour atteindre 50 URL pour le mot étranger )

19/12/2022:
Avancé du site, création d'un script java pour faire fonctionner des onglets. Les images sont à modifier

20/12/2022:
Afin de compléter le tabeau HTML , il faut rentrer le mot à rechercher dans la langue des url correspondantes. Pour l'allemand il faut rentrer les mots "Ausländer" et "Fremder" qui correspondent au nom commun étranger en français. Cependant nous avons remarqué que les contextes étaient vides. Voici la commande que nous avions effectué: "bash scriptaspirations.sh urlall_auslander.txt tableau.HTML "Ausländer". Mais cela s'est avéré infructueux car il est nécessaire des capter les adjectifs comme "ausländisch" et les mots composés sur "Ausländer". Nous avons donc élaboré une expression régulière capable de capturer les noms communs qui commencent tous par une majuscule en allemand et les adjectifs qui commencent par une minuscule. Voici la regex "\b[Au]sländer\w*\b".Les crochets prennent en compte majuscule et minuscule et le "w*" prend en compte un éventuel mot composé.

22/12/2022:
Nous nous sommes penchées sur la création des nuages de mots et avons trouvé une solution à notre problème d'installation. Wordcloud a été installé avec la commande pip install sur le terminal. Suite à cela, nous avons commencé à manipuler les commandes pour effectuer des tests de nuages. Nous avons remarqué la presence de mots vides/grammaticaux comme "le, la, dans, de ...".
De plus, pour élaborer nos nuages, nous avons décidé de concatener nos fichiers dump-textes pour obtenir un résulat général. </br>
Pour ce faire nous avons utilisé le script d'Itrameur et avons chacune concaténé nos fichiers textes, puis nous avons crée une liste de mots vides.
</br> Nos nuages se sont avérés bien représentatifs avec des mots analysables, neanmoins il nous a parû long de créer notre liste de mot vide entièrement. Après une documentation nous avons eu plusieurs solutions possibles qui sont :
</br>
-La bibliothèque NLTK détient des listes contenant un grand nombre de mots vides dans plusieurs langues. Nous avons utilisé un programme python qui a permis de corriger et supprimer les mots vides de nos fichier textes puis , nous avons crée une liste de mot adapté à notre nuage pour retirer les mots tels que "page","url".. qui s'étaient faufilés pour la segmentation d'itrameur. Ces fichiers corrigés ont été utilisé uniquement pour le construire le nuage de mot sous wordcloud
</br>
-Deuxième solution
</br>
01/01/2023 :
</br>
Bonne année !! Nous souhaitons le meilleur à tout ceux qui passeraient par là :D !</br>
En ce début d'année, nous avons ajouté un menu déroulant à notre site avec les balises "navbar" de Bulma.</br> Nous avons continué à remplir notre site et avons commencé à perfectionner le CSS, car un site rempli c'est bien mais un site rempli et beau c'est mieux ! </br>

</br>
04/12/2022 :
</br>
Nous avons commencé nos analyses Itrameur et avons remarqué un problème, l'importation sur Itrameur ne se faisait pas bien. Nous avons donc décidé de nettoyer les coquilles des fichiers concaténés avec des regx. Nous avons retiré les &lt; et les &gt; qui n'ont pas été retiré par le script Itrameur puis nous avons modifié notre script. Après cette rectification, tout a fonctionné et nous avons pu réaliser notre analyse.</br>
</br>

09/01/2023 :
</br>
Une fois l'architecture du site bien avancée , nous avons pu nous pencher davantage sur Bulma. Nous avons fait une refonte intégrale du site à l'aide de ce template (https://github.com/themefisher/enov-bulma) que nous avons ensuite modifié à notre convenance.
