#!/bin/bash
folder1=/home/ns/nsp/zoolv4/
folder2=/home/ns/.wine/drive_c/Zool/zool-release

sudo rm -r $folder2

rsync -av --exclude='.git' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='copyAll4Install.sh' \
          --exclude='zool_launch_linux.sh' \
          --exclude='install.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

#cd /home/ns/.wine/drive_c/Zool

cp -r /media/ns/Archivos/zooldev/PythonOkParaInstaladorZool $folder2/Python
cd $folder2
pwd
