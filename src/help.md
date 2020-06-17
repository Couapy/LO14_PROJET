# Aide

    Cet outil permet de synchroniser deux dossiers au sein d'un même
    système.

## Commandes

    L'outil propose les commandes suivantes :

### sync init [dossier distant]

    Initialise la synchronisation de deux dossiers.
    Attention le dossier distant doit ne pas exister.

### sync conflits

    Affiche les conflits du dossier local dans l'état actuel.
    A executer aussi dans un dossier synchronisé.

### sync diff

    Affiche les modifications du dossier local depuis la dernière
    synchronisation. A executer dans un dossier synchronisé.

### sync sync

    Synchronise le dossier local avec le distant. Si des conflits
    existent, l'utilisateur devra les corriger.

### sync help

    Affiche cette aide.

## Auteurs

    Ce programme a été écrit par Nicolas Zuddas et Maël Marchand
    pour un projet dans le cadre de la matière LO14 à l'UTT.
