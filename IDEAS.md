# Idées pour réaliser le projet

## Fonctions à développer

* init
* diff (donner la différence depuis le dernier update)
  * utiliser un md5
    * Permet de voir si le fichier est à jour
  * comparer les date de modifications
    * Permet de voir si le fichier est à jour
    * Permet de garder le dernier modifié
* sync (récupérer les modifications distances)
  * permissions
    * wrx
      * owner
      * groupe
      * others
  * meta données
    * type
    * taille
  * conflicts
    * Demander quel fichier garder, ou les deux
* add -d /home/user/mondossier
  * clone un dossier distant
* help (afficher l'aide)

## Structure du dossier

Attention à utiliser un format de date identique

Dans le dossier à synchroniser:

* Dossier à sync
  * .sync
    * files
    * folders
    * modifications
    * remote
  * monfichier1
  * etc...
