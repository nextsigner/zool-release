#!/bin/bash

# Validar que se pasaron exactamente tres parámetros
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <carpeta_destino> <nombre_zip>"
  exit 1
fi


mkdir -p /tmp/zool4zip
folder1=/home/ns/nsp/zoolv4/
folder2=/tmp/zool4zip

sudo rm -r $folder2

rsync -av --exclude='.git' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='copyAll4Install.sh' \
          --exclude='zool_launch_linux.sh' \
          --exclude='install.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

#cp -r /media/ns/Archivos/zooldev/PythonOkParaInstaladorZool $folder2/Python


# Asignar los parámetros a variables
CARPETA_ORIGEN="$folder2"
CARPETA_DESTINO="$1"
NOMBRE_ZIP="$2"

# Validar que la carpeta origen existe
if [ ! -d "$CARPETA_ORIGEN" ]; then
  echo "Error: La carpeta origen '$CARPETA_ORIGEN' no existe."
  exit 1
fi

# Validar que la carpeta destino existe
if [ ! -d "$CARPETA_DESTINO" ]; then
  echo "Error: La carpeta destino '$CARPETA_DESTINO' no existe."
  exit 1
fi

# Comprimir la carpeta
ZIP_PATH="$CARPETA_DESTINO/$NOMBRE_ZIP.zip"
zip -r "$ZIP_PATH" "$CARPETA_ORIGEN"

# Comprobar si el comando zip tuvo éxito
if [ $? -eq 0 ]; then
  echo "Carpeta comprimida exitosamente en '$ZIP_PATH'."
else
  echo "Error al comprimir la carpeta."
  exit 1
fi
