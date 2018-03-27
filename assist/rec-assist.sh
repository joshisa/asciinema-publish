#!/bin/bash
#
# rec-assist -- a bash script that powers the creation of polished recordings
# per time unit.
#


function join { local IFS="$1"; shift; echo "$*"; }

targetfolderpath="$1"
STEPS=("clear")

for i in `ls -v "${targetfolderpath}"/*.cli`; do 
  STEPS+=("&&" "./driver.sh $i");
done;

CMD=$(echo ${STEPS[@]})

#debug
#echo "${CMD}"
asciinema --insecure rec -y --overwrite -t "$2" -c "${CMD}"

# Let's exit this recording and get it uploaded per the config defined @ $HOME/.config/asciinema/config
exit
