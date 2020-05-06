
### $1, nom du fichier qui pose problème
### $2 type de conflit

### Déclaration d'un nouveau nom
function name_change {
        tag2=1
        while [ tag2 -eq 1 ];
        do 
            echo "Nouveau nom : "
            read new_name
            if [ -e new_name];
            then
                echo "Ce nom est déjà attribué à un autre fichier ou répertoire. \n"
                
            else 
                tag2=0
            fi
        done 
    return new_name
}

### Ecrase le fichier de la machine distante par celui se trouvant sur le pc (cas 1)
function delete_distant {
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
                 
            else if [ verification == "non" ];
            
                tag2=0
                tag=1

            else
                echo "Veuillez entrer oui ou non :"
                read verification
            fi 
        done 

    return tag        
}

### Ecrase le fichier se trouvant sur le pc par celui de la machine distante (cas 1)
function delete_host {
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
                

            else if [ verification == "non" ];
                tag2=0
                

            else
                echo "Veuillez entrer oui ou non :"
                read verification
            fi 
        done 
    return tag   
}

### Sauvegarde des deux fichier en changeant le nom de l'un d'eux (cas 1)
function double_save {
    
    new_name=name_change
    cp $1 $new_name ### changement de nom dans l'ordi
    cp $new_name ### path+new_name pour en faire la copie dans le distant
    cp ### path+$1 vers $1

    tag=0

    return tag
}

### Changement du nom du fichier (cas 2)
function file_name_change {
    ### Cherche lequel est le fichier ou le répertoire : -d test si répertoire
        if [ -d $1];
        then
            mv ### path+$1 path+$2
            cp $1 ### path+$1
            cp ### path+$2 $2
        else 
            mv $1 $2
            cp $2 ### path+$2
            cp ### path+$1 $1
        fi
        tag=0
    return tag
}

### Changement du nom du répertoire (cas2)
function repertory_name_change {
    ### Cherche lequel est le fichier ou le répertoire : -f test si fichier "ordinaire"
        if [ -f $1];
        then
            mv ### path+$1 path+$2
            cp $1 ### path+$1
            cp ### path+$2 $2
        else 
            mv $1 $2
            cp $2 ### path+$2
            cp ### path+$1 $1
        fi
        tag=0
    return tag  
}

### Main script

function conflit {
    ### Selection du type de conflit : choix 1 --> Les deux fichiers ont été modifié depuis la dernière synchro.
    if [ $2 -eq 1 ];
    then
        tag=1
        while [ tag -eq 1 ];
        do
            ### Proposition de choix pour utilisateur
            echo "Les deux fichiers $1 ont été modifié depuis la dernière synchronisation."
            echo "Que voulez vous faire :\n 1 - Donner un autre nom à la version présente sur ce pc \n 2 - Ecraser la version disponible sur le pc distant \n 3 - Ecraser le fichier disponible sur ce pc "
            read choix

            ### Choix : on garde les deux donc on change un des noms
            if [ choix -eq 1 ];
            then 
                tag=name_change $1

            ### On ecrase sur le pc distant
            else if [ choix -eq 2 ];

                tag=delete_distant $1
                
            ### On écrase sur le pc qui lance le sync
            else if [ choix -eq 3 ];
                tag=delete_host $1

            else
                echo "Choix non valide."
            fi

        done 

    ### Sélection du type de conflit : choix 2 --> un fichier à le même nom qu'un répertoire
    else if [ $2 -eq 2 ];
        tag=1
        while [ tag -eq 1 ];
        do
            ### Proposition de choix pour l'utilisateur
            echo "Un fichier à le même nom qu'un répertoire. Changer le nom du :\n 1 - fichier \n 2 - répertoire"
            read choix

            new_name=name_change

            ### On change le nom du fichier
            if [ choix -eq 1 ];
            then 
                tag=file_name_change $1 $new_name

            else if [ choix -eq 2];
                tag=repertory_name_change $1 $new_name

            else
                echo " Choix invalide!"
            fi
        done


    ### Sélection du type de conflit : choix 3 -->
    else if [ $2 -eq 3];


    fi           
}



