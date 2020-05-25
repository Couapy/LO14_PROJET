# Synchronisation de dossiers

Dans le cadre de la matière LO14, nous avons réalisé un script
permettant de synchroniser deux dossiers entre eux, tout en
gérant les potentiels conflits qui peuvent arriver.

## Structure du projet

Afin de mieux comprendre le projet et sa structure interne, les sections
suivantes vous aidront à comprendre son fonctionnement.

### Dossier .sync

Dans chaque dossier synchronisé, se trouve un dossier caché .sync
contenant différentes informations.

La mention unique indique que le fichier est différent d'un dossier
à l'autre.

* .sync
  * conflits
    * contient tous les conflits actuels
    * Format
      * code d'erreur>chemin relatif vers le fichier
      * Exemple : 1>dossier/fichier
  * diff
    * Contient toutes les différences actuelles
    * Format
      * Type de modification#chemin relatif vers le fichier
      * Exemples
        * ADD#dossier/fichier
        * MOD#dossier/fichier
        * REM#dossier/fichier
    * Unique
  * ignore
    * Liste de modifications à ignorer
    * Même format que le fichier diff
    * Unique
  * journal
    * Contient le journal daté de la dernière synchronisation réussie
    * Chaque ligne est un fichier ou un dossier suivit de leur md5sum
      * La chaine ";" sépare le chemin du fichier/dossier de son md5
      * Un md5 vide correspond à un dossier
  * journal_temp
    * journal actuel du dossier
    * Unique
  * remote
    * Contient le chemin absolu vers le dossier distant
    * Unique

D'après l'arbre ci-dessus la seule information redondante est le journal.
Pour une question de praticité nous avons décidé d'en faire une copie dans
le dossier *.sync*.

### Sources

Les sources sont situées dans le dossier **src**. A l'intérieur se
trouve le script principal, et un dossier contenant les librairies
du projet.

#### Dossier src

* lib/
  * Contient toutes les librairies nécéssaires au projet
* help.md
  * Contient l'aide affichée par le programme
* sync
  * Programme principal du projet

#### Dossier lib

* conflit
  * Librairie permettant de résoudre tous les conflits
* journal
  * Librairie qui suit l'évolution d'un dossier
* sync
  * Librairie qui permet de synchroniser les dossiers

## Fonctionnement du programme

Le programme est contenu dans le fichier *src/sync*. Les commandes
doivent être données en argument lors de l'appel du script.

### Commandes disponibles

Les commandes suivantes sont disponible sur le script principal :

* init
  * Initialise le dossier en créant un miroir
* sync
  * Résoud les conflits s'il y en a, puis synchronise les dossiers entre eux
* diff
  * Montre les opérations effectuées en local depuis la dernière synchronisation
* conflits
  * Montre les conflits de l'état actuel

### Détection des différences

Les différences résultent de la comparaison du journal datant de la
dernière synchronisation et du journal actuel.
Une nouvelle entrée indique un nouveau fichier/dossier.
Une entrée supprimée indique un fichier/dossier supprimé.
Une entrée modifiée (md5sum modifié pas le nom du fichier) indique
qu'un fichier a été modifié.

### Détection des conflits

Les conflits sont détecté à partir des modifications établies dans
chacun des dossiers.
Par exemple, si deux fichiers sont créés chacun dans un dossier synchronisé,
et ont le même chemin relatif, alors on condsière un conflit.
Nous verrons plus bas les types de conflits existants.

### Synchronisation

Si le script détecte des conflits, il demandera à l'uilisateur de les résoudre
avant de synchroniser. L'utilisateur est libre d'utiliser l'outil de résolution
de conflits, ou de résoudre les conflits par lui-même.

Donc le script ne pourra synchroniser deux dossiers sans conflits, et peut gérer le
cas où l'utilisateur modifie un des deux dossiers en cours de synchronisation : les
modifications seront prise en compte comme nouvelles différences un fois fini.

## Gestion des conflits

Les conflits sont générés par les actions des utilisateurs,
détectés par le programme, et résolus soit par l'action de
l'utilisateur, soit par l'aide à la résolution des conflits
dans notre programme.

Les types de conflits sont les suivants :

1. Si on a un fichier modifié des deux côtés
2. Si on a un fichier et un dossier créés qui ont le même nom
3. Si on a un fichier modifié et supprimé
4. Si on a deux fichiers créés avec le même nom

### Comment détecter les conflits

Afin de déterminer les conflits, on va passer par trois étapes :

* Générer un journal actuel par dossier synchronisé
* Générer les différences entre le journal actuel et le vieux journal
  * filtrer les différences avec ignore_diff
* Comparer les différences entre les deux dossiers => obtention des conflits

### Comment résoudre les conflits

Pour chacun des cas de conflits on execute un utilitaire
conçu spécialement pour résoudre un cas de conflit en
particulier.

Ou alors l'utilisateur peut faire le choix de ne pas l'utiliser
et corriger par lui-même les conflits.

### Eviter de générer d'autres conflits en résolvant des conflits

En résolvant des cas de conflits, il est probable que l'on
créé d'autres conflits. Par exemple, pour un cas où un même
fichier a été édité dans les deux dossiers, on peut en renommer
qu'un seul afin de garder les deux versions, seulement, le
programme va détecter qu'un fichier a été modifié en local,
et supprimé en distant (car il cessera d'exister en tant que tel).

Donc dans ces cas, nous avions les solutions suivantes :

* Modifier le journal afin de faire en sorte que le fichier ne soit pas "supprimé"
  * Mettre à jour le journal
* Créer un fichier ignore_files pour faire la même chose, sans modifier le fichier journal
  * Ne pas suivre des entrées dans le journal
* Créer un fichier ignore_diff où on va exclude des différences
  * Ne pas suivre des différences

Nous avons donc choisi la dernière option, permettant de ne pas
compromettre l'état du journal, qui lui est forcément dans un état
sans conflit, sans pour autant louper d'autres conflits avec la seconde
option.

## Gestion du projet

Le projet a été hébergé sur la plateforme GitHub, et la communication
s'est passée sur Discord.

## Auteurs

Ce programme a été écrit par Nicolas Zuddas et Maël Marchand
pour un projet dans le cadre de la matière LO14 à l'UTT.
