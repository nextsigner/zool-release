#!/bin/bash

#Necesita tener instalado lo siguiente en Ubuntu 20.04
#sudo apt install libttspico-utils

#Requiere 3 parámetros.
#Parámetro 1: "El texto a reproducir entre comillas dobles"
#Parámetro 2: El nombre temporal de archivo .wav. Ejemplo /tmp/351651321.wav
#Parámetro 3: El identificador del idioma o lenguaje. Ejemplo: es-ES

#pico2wave --lang="es-ES" -w=/tmp/test.wav "$1"
FILEDATA=$(cat $1)
rm $2
echo $FILEDATA
#exit
pico2wave --lang="es-ES" -w=$2 "$FILEDATA"
#aplay /tmp/test.wav
#aplay $2
#rm /tmp/test.wav
#rm $2
echo "Proceso Pic2Wave finalizado."
exit
