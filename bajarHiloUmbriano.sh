#!/bin/sh
if [ "$#" != 3 ]; then 
    echo "USAGE: bajarHiloUmbriano <id> <max> <name>"
    echo "EXAMPLE: bajarHiloUmbriano 35338 82 carnifexEnTuVida"
    exit
fi    
BASE_URL="http://www.comunidadumbria.com/comunidad/foros/tema"
THREAD_ID=$1
MAX_ID=$2
NAME=$3
for ID in `seq 1 $MAX_ID`; do
    wget ${BASE_URL}/${THREAD_ID}?__Pg=${ID} -O "umbria_${THREAD_ID}_${NAME}_$ID.html"
done
