#!/bin/sh
if [ "$#" != 1 ]; then 
    echo "USAGE: mostrarCarismaUmbriano <id>"
    echo "EXAMPLE: mostrarCarismaUmbriano 35338"
    exit
fi    
BASE_URL="http://www.comunidadumbria.com/comunidad/companeros/pestana/carisma/"$1
TMP_WEB_FILE=/tmp/$1.tmp.html
TMP_TXT_FILE=/tmp/$1.tmp.txt
wget $BASE_URL -O $TMP_WEB_FILE
echo "Charisma points: "
cat $TMP_WEB_FILE \
  | grep 'div class="opinion' -A4 \
  | grep src |awk 'BEGIN{FS="alt=\""}{print($2)}' \
  | awk 'BEGIN{FS="\""}{print($1)}' \
  | sort \
  | uniq -c \
  | sort -r \
  | awk '    {                                            \
              total += $1;                                \
              count += 1;                                 \
              print($0)                                   \
             }                                            \
          END{                                            \
              endogamy = (total / count) - 1;             \
              normalized = endogamy / (1 + endogamy);     \
              print "\nEndogamy index: " normalized "\n"  \
             }' 
# Indice de endogamia = (suma de puntuaciones de carisma / cuenta de opinadores únicos) - 1, normalizado de 0 a 1 (N/N+1)
#       Persona con N puntos procedentes de N personas diferentes, endogamia = 0
#       Persona con N puntos procedentes todos de la misma persona, endogamia -> 1 cuando N -> inf

