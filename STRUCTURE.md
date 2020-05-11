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
* help.md
  * Contient l'aide affichée par le programme
* sync
  * Programme principal du projet

### Dossier lib

* conflit
  * Librairie permettant de résoudre tous les conflits
* journal
  * Librairie qui suit l'évolution d'un dossier
* sync
  * Librairie qui permet de synchroniser les dossiers