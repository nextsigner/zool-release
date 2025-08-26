#!/bin/bash
folder1=/home/ns/nsp/zoolv4/
folder2=/media/ns/Archivos/zooldev/zool-win-64/build/zool-release

sudo rm -r $folder2

rsync -av --exclude='.git' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='*.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

#A partir de Zool v5.7.10.0, se comenzó a utilizar un Python que está en
#/media/ns/Archivos/zooldev/zool-win-64/build/Python
#MOTIVO POR EL CUAL, YA NO HACE FALTA COPIAR LA CARPETA PYTHON
#cp -r /media/ns/Archivos/zooldev/PythonOk76Mb $folder2/Python
