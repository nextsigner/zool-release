#!/bin/bash
CANT=$(cat $1 | jq .$2_en_$3.manifestaciones | jq keys | jq length)
bodie=$2
sign=$3
sign=${sign^}
titulo="${bodie^}"
titulo="$titulo en $sign"
titulo=$(echo $titulo | sed 's/_/ /g')
HTML="${titulo^}"
HTML="<h1>$HTML</h1>"
HTML=$HTML"<ul>"
for (( c=0; c<$CANT; c++ ))
do
    ITEMNAME=$(cat $1 | jq .$2_en_$3.manifestaciones | jq keys | jq .[$c])
    #echo "Hay $ITEMNAME"

    titulo=$(echo $ITEMNAME | sed 's/"//g' | sed 's/_/ /g')
    titulo="${titulo^}"
    #echo $titulo
    HTML=$HTML"<li><b>$titulo:</b>"
    des=$(cat $1 | jq .$2_en_$3.manifestaciones | jq '.['$ITEMNAME']'  | sed 's/"//g')
    HTML=$HTML" $des</li>"
    #echo $des
done
HTML=$HTML"</ul>"
echo $HTML
