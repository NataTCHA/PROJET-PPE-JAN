import nltk
nltk.download ()
from nltk.corpus import stopwords

def cleancorpus(text):
    clean =list()
    liste_words=text.split()
    clean=[word.lower() for word in liste_words if word.lower() not in fr_stopwords]
    text=" ".join(clean)
    return text

fr_stopwords = stopwords.words('french')
with open("./itrameur/contextes_FR-URL_FR.txt", 'r') as file:
    filefr= file.read()
with open("./itrameur/corrigé", 'a') as file:
    fileclean = cleancorpus(filefr)
    file.write(fileclean)
