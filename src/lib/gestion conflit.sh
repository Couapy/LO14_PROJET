
### $1, nom du fichier qui pose problème
### $2 type de conflit

### Selection du type de conflit : choix 1 --> Les deux fichiers ont été modifié depuis la dernière synchro.
if [ $2 -eq 1 ];
then
    tag=1
    while [ tag -eq 1 ];
    do
        ### Proposition de choix pour utilisateur
        echo "Les deux fichiers $1 ont été modifié depuis la dernière synchronisation. \n Que voulez vous faire :\n 1 - Donner un autre nom à la version présente sur ce pc \n 2 - Ecraser la version disponible sur le pc distant \n 3 - Ecraser le fichier disponible sur ce pc "
        read choix

        ### Choix : on garde les deux donc on change un des noms
        if [ choix -eq 1 ];
        then 
            echo "Nouveau nom : "
            read new_name
            tag2=1
            while [ tag2 -eq 1 ];
            do 
                if [ -e new_name];
                then
                    echo "Ce nom est déjà attribué à un autre fichier ou répertoire. \n Nouveau nom :"
                    read new_name
                fi 
                tag2=0
            done 
            cp $1 $new_name ### changement de nom dans l'ordi
            cp $new_name ### path+new_name pour en faire la copie dans le distant
            cp ### path+$1 vers $1

            tag=0
        fi

        ### On ecrase sur le pc distant
        else if [ choix -eq 2 ];
        then
            echo "Etes-vous sûr de vouloir écraser la version disponible sur le pc distant (oui / non) : "
            read verification
            tag2=1
            while [ tag2 -eq 1 ];
            do 
                if [ verification == "oui" ];
                then 
                    ### cp $1 vers path+$1
                    tag=0
                    tag2=0
                 fi

                else if [ verification == "non" ];
                then
                    tag2=0
                fi

                else
                    echo "Veuillez entrer oui ou non :"
                    read verification
                fi 
            done 
        fi

        ### On écrase sur le pc qui lance le sync
        else if [ choix -eq 3 ];
        then
            echo "Etes-vous sûr de vouloir écraser la version disponible sur ce pc (oui / non) : "
            read verification
            tag2=1
            while [ tag2 -eq 1 ];
            do 
                if [ verification == "oui" ];
                then 
                    ### cp path+$1 vers $1
                    tag=0
                    tag2=0
                 fi

                else if [ verification == "non" ];
                then
                    tag2=0
                fi

                else
                    echo "Veuillez entrer oui ou non :"
                    read verification
                fi 
            done 
        fi

        else
            echo "Choix non valide."
        fi

    done 

fi




