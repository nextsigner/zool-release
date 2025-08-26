#!/bin/bash

# Ruta a tu carpeta de Python portable
PYTHON_DIR="/home/ns/.wine/drive_c/p1/Zool/zool-release/Python"

# Archivos y carpetas esenciales
KEEP_FILES=(
    "python.exe"
    "python3.dll"
    "python3*.dll"
    "pip3.exe"
    "DLLs/"
    "Lib/"
    "Scripts/"
    "vcruntime*.dll"
    "ucrtbase.dll"
)

# Carpetas a eliminar (con precaución)
REMOVE_DIRS=(
    "Doc/"
    "include/"
    "tcl/"
    "Tools/"
    "share/"
    "__pycache__/"
    "tests/"
    "demo/"
)

# Archivos a eliminar (con precaución)
REMOVE_FILES=(
    "*.pdb"
    "*.pyc"
    "*.pyo"
    "*.chm"
    "*.txt"
    "*.html"
    "*.pdf"
    "*.exe.manifest"
)

# Eliminar carpetas
for dir in "${REMOVE_DIRS[@]}"; do
    rm -rf "$PYTHON_DIR/$dir"
done

# Eliminar archivos
for file in "${REMOVE_FILES[@]}"; do
    find "$PYTHON_DIR" -name "$file" -type f -delete
done

# Mantener archivos esenciales
find "$PYTHON_DIR" -type f | while read file; do
    keep=false
    for essential in "${KEEP_FILES[@]}"; do
        if [[ "$file" == "$PYTHON_DIR/$essential" || "$file" == "$PYTHON_DIR/$essential"* ]]; then
            keep=true
            break
        fi
    done
    if [[ "$keep" == false ]]; then
        rm -f "$file"
    fi
done

# Eliminar carpetas vacías
find "$PYTHON_DIR" -type d -empty -delete

echo "Limpieza completada."
echo "Atención!! Recordar que esto se utiliza para limpiar la carpeta Python que se pondra en el instalador pero estre script borra algunos dlls necesarios. Por eso hay que hacer cp *.dll desde la carpeta de origen hacia la carpeta Python que se utilizará en el instalador. No confundir con la carpetata C:\Python Portable x64\App\Python este último se utilizo solo para hacer correr pip.exe desde wine cmd.exe."
