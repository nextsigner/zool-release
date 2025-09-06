#!/bin/bash
folder1=/home/ns/nsp/zoolv4/
folder2=/home/ns/zip_data_4_zool-release/zool-release
folder3=/home/ns/zip_zoolv4

sudo rm -r $folder2
sudo rm -r $folder3
#mkdir $folder2

rsync -av --exclude='.git' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='copyAll4Install.sh' \
          --exclude='zool_launch_linux.sh' \
          --exclude='*.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

mkdir -p "$folder2"
mkdir -p "$folder3"
cd /home/ns/zip_data_4_zool-release
zip -r "$folder3/zool-release.zip" .
mv "$folder3/zool-release.zip"  "$folder3/zool_v$1.zip"
if [ $? -eq 0 ]; then
  echo "Carpeta comprimida exitosamente en $folder3/zool_v$1.zip"
else
  echo "Error al comprimir la carpeta."
fi
