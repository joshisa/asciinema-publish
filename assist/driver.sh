#!/bin/bash
#
# asciidriver -- a bash script that echoes its argument one character
# per time unit.
#

###########
# Glyphs ##
###########

green='\x1B[0;32m'
red='\x1B[0;31m'
yellow='\x1B[0;33m'
cyan='\x1B[0;36m'
no_color='\x1B[0m' # No Color
beer='\xF0\x9f\x8d\xba'
delivery='\xF0\x9F\x9A\x9A'
beers='\xF0\x9F\x8D\xBB'
eyes='\xF0\x9F\x91\x80'
cloud='\xE2\x98\x81'
crossbones='\xE2\x98\xA0'
litter='\xF0\x9F\x9A\xAE'
fail='\xE2\x9B\x94'
harpoons='\xE2\x87\x8C'
tools='\xE2\x9A\x92'
present='\xF0\x9F\x8E\x81'
clapping='\xF0\x9F\x99\x8C'
k8s='\xE2\x8E\x88'
heart='\xE2\x9D\xA4'
#########

function eyecandy() {
  modline=$(echo -e $1 | sed "s/{green}/$(echo -e ${green}) /g")
  modline=$(echo -e $modline | sed "s/{red}/$(echo -e ${red}) /g")
  modline=$(echo -e $modline | sed "s/{yellow}/$(echo -e ${yellow}) /g")
  modline=$(echo -e $modline | sed "s/{cyan}/$(echo -e ${cyan}) /g")
  modline=$(echo -e $modline | sed "s/{no_color}/$(echo -e ${no_color}) /g")
  modline=$(echo -e $modline | sed "s/{beer}/$(echo -e ${beer}) /g")
  modline=$(echo -e $modline | sed "s/{delivery}/$(echo -e ${delivery}) /g")
  modline=$(echo -e $modline | sed "s/{beers}/$(echo -e ${beers}) /g")
  modline=$(echo -e $modline | sed "s/{eyes}/$(echo -e ${eyes}) /g")
  modline=$(echo -e $modline | sed "s/{cloud}/$(echo -e ${cloud}) /g")
  modline=$(echo -e $modline | sed "s/{crossbones}/$(echo -e ${crossbones}) /g")
  modline=$(echo -e $modline | sed "s/{litter}/$(echo -e ${litter}) /g")
  modline=$(echo -e $modline | sed "s/{fail}/$(echo -e ${fail}) /g")
  modline=$(echo -e $modline | sed "s/{harpoons}/$(echo -e ${harpoons}) /g")
  modline=$(echo -e $modline | sed "s/{tools}/$(echo -e ${tools}) /g")
  modline=$(echo -e $modline | sed "s/{present}/$(echo -e ${present}) /g")
  modline=$(echo -e $modline | sed "s/{clapping}/$(echo -e ${clapping}) /g")
  modline=$(echo -e $modline | sed "s/{k8s}/$(echo -e ${k8s}) /g")
  modline=$(echo -e $modline | sed "s/{heart}/$(echo -e ${heart}) /g")
}

PS1="\\$ "  # You can customize the terminal prompt
DEFAULTPACE=0.15
FAST=0.10
MEDIUM=0.30
SLOW=0.50

# Initialize
PACE="${DEFAULTPACE}"
OLDPACE="${PACE}"

while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ ${line:0:1} != "#" ]] && [[ ${line:0:1} != ">" ]]; then {
    i=0;  #Unaltered Line Output.  Will be treated as a literal
    modline=$line
  } else {
    # Looks like we have a comment line.  Pace will be dictated
    # by whether angled brackets are used or not.  If only hash is used
    # then we'll go with the default comment pace

    eyecandy "$line"
    if [[ ${line:0:2} == '>>' ]];
    then
      if [[ ${line:0:3} == '>>>' ]];
      then
        i=3;
        PACE="${FAST}"
      else
        i=2;
        PACE="${MEDIUM}"
      fi
    else
      i=1;
      PACE="${SLOW}"
    fi
  }
  fi
  
  if [[ ${line:0:1} == '>' ]];
  then
    if [[ ${line:0:2} == '>>' ]];
    then
      if [[ ${line:0:3} == '>>>' ]];
      then
        PACE="${FAST}"
      else
        PACE="${MEDIUM}"
      fi
    else
      PACE="${SLOW}"
    fi
  else
    PACE="${DEFAULTPACE}"
  fi

  for (( i; i < ${#modline}; i+=1 )) ; do
    if [[ ${modline:$i:1} == " " ]] ; 
    then {
      echo -e -n "${modline:$i:1}";
      sleep 0;
    } else {
      echo -e -n "${modline:$i:1}";
      sleep "${PACE}";
    }
    fi
  done
  echo
  if [[ ${line:0:1} != "#" ]] && [[ ${line:0:1} != ">" ]] ; then eval "$line" ; fi
done < "$1"
