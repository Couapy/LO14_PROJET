local
------------
fichier dateA

distant
------------
fichier dateA


SYNC cas 1
===========
local > fichier > dateA
distant > fichier > dateB

=> fichier a modifié dans le dossier distant

SYNC cas 2
===========
local > fichier > dateB
distant > fichier > dateA

=> fichier a modifié dans le dossier local

SYNC cas 3
===========
local > fichier > dateB
distant > fichier > dateC

=> fichier a modifié dans le dossier local et dans le dossier distant
=> CONFLIT /!\
    => Afficher que fichier est en conflit
        => Demander quel fichier garder
        => Demander si on veut garder les deux fichiers sous deux noms différents
