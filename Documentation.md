# Gestion des conflits

Les conflits sont générés par les actions des utilisateurs,
détectés par le programme, et résolus soit par l'action de
l'utilisateur, soit par l'aide à la résolution des conflits
dans notre programme.

Les types de conflits sont les suivants :

1. Si on a deux fichiers créés avec le même nom
2. Si on a un fichier et un dossier créés qui ont le même nom
3. Si on a un fichier modifié et supprimé
4. Si on a un fichier modifié des deux côtés

## Comment détecter les conflits

Afin de déterminer les conflits, on va passer par trois étapes :

* Générer un journal actuel par dossier synchronisé
* Générer les différences entre le journal actuel et le vieux journal
  * filtrer les différences avec ignore_diff
* Comparer les différences entre les deux dossiers => obtention des conflits

## Comment résoudre les conflits

Pour chacun des cas de conflits on execute un utilitaire
conçu spécialement pour résoudre un cas de conflit en
particulier.

Ou alors l'utilisateur peut faire le choix de ne pas l'utiliser
et corriger par lui-même les conflits.

## Eviter de générer d'autres conflits en résolvant des conflits

En résolvant des cas de conflits, il est probable qu'on
créé d'autres conflits. Par exemple, pour un cas où un même
fichiers a été édité dans les deux dossiers, on peut en renommer
qu'un seul afin de garder les deux versions, seulement, le
programme va détecter qu'un fichier a été modifié en local,
et supprimé en distant (car il cessera d'exister en tant que tel).

Donc dans ces cas, on a les solutions suivantes :

* Modifier le journal afin de faire en sorte que le fichier ne soit pas "supprimé"
* Créer un fichier ignore_files pour faire la même chose, sans modifier le fichier journal
* Créer un fichier ignore_diff où on va exclude des diffs
  * remove une fois fois sync

### Fonctions à créer

* journal > add ignore_diff
* journal > rem ignore_diff
