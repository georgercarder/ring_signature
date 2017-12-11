#!/bin/bash


c=$(($(ls publickeys.local -l|wc -l)-1))


cp -r message sign
cp -r mykeys sign
cp -r publickeys.local sign

#rm -r sign/publickeys.local/privategenerators

touch sign/A
touch sign/B
touch sign/Z
touch sign/Z.bin

c=$(($(ls -l|wc -l)-1))
export c

./sign/signscript.sh
./sign/signscript2.sh

./sign/signscript3.sh





####
