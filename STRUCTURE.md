# Structure du projet

Ce fichier permet de mieux comprendre comment le projet est structuré.

## Dossier .sync

* .sync
  * journal
    * Contient le journal daté de la dernière synchronisation réussie
    * Chaque ligne est un fichier ou un dossier suivit de leur md5sum
      * La chaine ";" sépare le chemin du fichier/dossier de son md5
  * remote
    * Contient le chemin absolu vers le dossier distant

## Sources

Les sources sont situées dans le dossier **src**.

### Dossier src

* lib/
  * Contient toutes les librairies nécéssaires au projet
* help
  * Contient l'aide affichée par le programme
* sync
  * Programme principal du projet

### Dossier lib

* conflit
  * Permet de gérer les conflits
* journal
  * Permet de gérer l'état du dossier et sa journalisation
* sync
  * Permet de synchroniser deux dossier entre eux