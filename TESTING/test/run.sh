#!/bin/bash


c=$(($(ls publickeys.local -l|wc -l)-2))


cp -r message sign
cp -r mykeys sign
cp -r publickeys.local sign

rm -r sign/publickeys.local/privategenerators


c=$(($(ls -l|wc -l)-1))
export c

./sign/signscript.sh
#./sign/signscript2.sh



####
