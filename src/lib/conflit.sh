#!/bin/bash


### $1, nom du fichier qui pose problème
### $2 type de conflit

### Déclaration d'un nouveau nom
function name_change {
        continuer=1
        while [ continuer -eq 1 ];
        do
            echo "Nouveau nom : "
            read new_name
            if [ -e new_name];
            then
                echo "Ce nom est déjà attribué à un autre fichier ou répertoire. \n"
            else
                continuer=0
            fi
        done
    return new_name
}


### Ecrase le fichier se trouvant sur le pc par celui de la machine distante (cas 1)
# $1 chemin vers le fichier qui va être écrasé
# $2 chemin vers le fichier en qui va être garder
# $3 phrase prompt
function delete {
        path_delete=$(dirname $1)
        path_save=$(dirname $2)
        name=$(basename $2)
        echo "$3"
        read verification
        continuer
        while [ continuer -eq 1 ];
        do 
            if [ verification == "oui" ];
            then 
                cp $path_save/$name $path_delete/$name
                resolu=0
                continuer=0
                

            else if [ verification == "non" ];
                continuer=0
                resolu=1

            else
                echo "Veuillez entrer oui ou non :"
                read verification
            fi 
        done 
    return resolu   
}

### Sauvegarde des deux fichier en changeant le nom de l'un d'eux (cas 1)
# $1 chemin vers le fichier en conflit local
# $2 chemin vers le fichier en conflit distant
function double_save {
    new_name=$(name_change) # On renomme obligatoirement le fichier local
    file_path_local=$(dirname $1) # chemin vers le fichier > /path/dir/sync
    file_name=$(basename $1) # nom du fichier:  le même pour les deux puisque conflit
    file_path_distant=$(dirname $2) # chemin vers le fichier > /path/dir/sync
    

    cp $file_path_local/$file_name $file_path_local/$new_name ### changement de nom dans l'ordi
    cp $file_path_local/$new_name $file_path_distant/$new_name ### path+new_name pour en faire la copie dans le distant
    cp $file_path_distant/$file_name $file_path_local/$file_name
    resolu=0

    return resolu
}

### Changement du nom du fichier (cas 2)
# $1 chemin vers le fichier en conflit local
# $2 chemin vers le fichier en conflit distant
# $3 Nouveau nom du fichier
function file_name_change {
    file_path_local=$(dirname $1) # chemin vers le fichier > /path/dir/sync
    file_name=$(basename $1) # nom du fichier:  le même pour les deux puisque conflit
    file_path_distant=$(dirname $2) # chemin vers le fichier > /path/dir/sync
    ### Cherche lequel est le fichier ou le répertoire : -d test si répertoire
        if [ -d $1];
        then
            mv $file_path_distant/$file_name $file_path_distant/$3 
            cp $file_path_local/$file_name $file_path_distant/$file_name
            cp $file_path_distant/$3 $file_name/$3
        else 
            mv $file_path_local/$file_name $file_path_local/$3
            cp $file_path_local/$3 $file_path_distant/$3
            cp $file_path_distant/$file_name $file_path_local/$file_path_distant
        fi
        resolu=0
    return resolu
}

### Changement du nom du répertoire (cas2)
# $1 chemin vers le fichier en conflit local
# $2 chemin vers le fichier en conflit distant
# $3 Nouveau nom du repertoire
function repertory_name_change {
    file_path_local=$(dirname $1) # chemin vers le fichier > /path/dir/sync
    file_name=$(basename $1) # nom du fichier:  le même pour les deux puisque conflit
    file_path_distant=$(dirname $2) # chemin vers le fichier > /path/dir/sync
    ### Cherche lequel est le fichier ou le répertoire : -f test si fichier "ordinaire"
        if [ -f $1];
        then
            mv $file_path_distant/$file_name $file_path_distant/$3
            cp $file_path_local/$file_name $file_path_distant/$file_name
            cp $file_path_distant/$3 $file_name/$3
        else 
        else 
            mv $file_path_local/$file_name $file_path_local/$3
            cp $file_path_local/$3 $file_path_distant/$3
            cp $file_path_distant/$file_name $file_path_local/$file_path_distant
        fi
        resolu=0
    return resolu  
}

### Main script
function conflit {
    ### Selection du type de conflit : choix 1 --> Les deux fichiers ont été modifié depuis la dernière synchro.
    if [ $2 -eq 1 ];
    then
        name_file=$(basename $1)
        resolu=1
        while [ resolu -eq 1 ];
        do
            ### Proposition de choix pour utilisateur
            echo "Les deux fichiers $name_file ont été modifié depuis la dernière synchronisation."
            echo "Que voulez vous faire :\n 1 - Donner un autre nom à la version présente sur ce pc \n 2 - Ecraser la version disponible sur le pc distant \n 3 - Ecraser le fichier disponible sur ce pc "
            read choix
            phrase_supp_distant="Etes-vous sûr de vouloir écraser la version disponible sur le pc distant (oui / non) :"
            phrase_supp_local="Etes-vous sûr de vouloir écraser la version disponible sur ce pc (oui / non) :"

            ### Choix : on garde les deux donc on change un des noms
            if [ choix -eq 1 ];
            then 
                resolu=name_change $1

            ### On ecrase sur le pc distant
            else if [ choix -eq 2 ];

                resolu=$(delete $2 $1 $phrase_supp_distant)
                
            ### On écrase sur le pc qui lance le sync
            else if [ choix -eq 3 ];
                resolu=$(delete $1 $2 $phrase_supp_local)

            else
                echo "Choix non valide."
            fi

        done 

    ### Sélection du type de conflit : choix 2 --> un fichier à le même nom qu'un répertoire
    else if [ $2 -eq 2 ];
        resolu=1
        while [ resolu -eq 1 ];
        do
            ### Proposition de choix pour l'utilisateur
            echo "$name_file est à la fois un ficher et un répertoire. Changer le nom du :\n 1 - fichier \n 2 - répertoire"
            read choix

            new_name=$(name_change)

            ### On change le nom du fichier
            if [ choix -eq 1 ];
            then 
                resolu=$(file_name_change $1 $2 $new_name)

            else if [ choix -eq 2];
                resolu=$(repertory_name_change $1 $2 $new_name)

            else
                echo " Choix invalide!"
            fi
        done


    ### Sélection du type de conflit : choix 3 -->
    else if [ $2 -eq 3];


    fi           
}

conflit $@