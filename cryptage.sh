#!/bin/bash

echo "Bienvenue dans notre service de cryptage"
echo "Quel service voulez-vous utiliser ? (Cryptage ou Decryptage)"
read respond

if [ "$respond" == "Cryptage" ]; then

    echo "Entrez le nom du fichier à crypter :"
    read file_encryption

    if [ -e "$file_encryption" ]; then

        openssl aes-256-cbc -pbkdf2 -a -in "$file_encryption" -out "$file_encryption.enc"

        if [ $? -eq 0 ]; then
            echo "Fichier crypté avec succès."
            rm "$file_encryption"
        else
            echo "Erreur lors du cryptage."
        fi

    else
        echo "Le fichier n'existe pas."
    fi

elif [ "$respond" == "Decryptage" ]; then

    echo "Entrez le nom du fichier à décrypter :"
    read file_decryption

    if [ -e "$file_decryption" ]; then

        output_file="${file_decryption%.enc}"

        openssl aes-256-cbc -pbkdf2 -a -d -in "$file_decryption" -out "$output_file"

        if [ $? -eq 0 ]; then
            echo "Fichier décrypté avec succès."
            rm "$file_decryption"
        else
            echo "Erreur lors du décryptage."
        fi

    else
        echo "Le fichier n'existe pas."
    fi

else
    echo "Vous n'avez pas précisé la bonne action."
fi
