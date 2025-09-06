#!/bin/bash
folder1=/home/ns/nsp/zoolv4/
folder2=/home/ns/nsp/zool-release

rm -r $folder2/*.qml
rm -r $folder2/*.cfg
rm -r $folder2/modules
rm -r $folder2/py
rm -r $folder2/js

rsync -av --exclude='.git' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='*.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

