#!/bin/bash


c=7

cat sign/value.random/v > sign/summands/2s

i=1

while [ $i -le $(( $c + 1 )) ]
do

	openssl rsautl -raw -encrypt -inkey sign/publickeys.anon/$i\-public.pem -pubin -in sign/inputs.anon/$i\x -out sign/summands/1s

	./sign/xorhexdumpstobinary.sh

	openssl enc -nosalt -in sign/summands/Z.bin -out sign/summands/2s -e -aes256 -k sign/k/keyhash.txt

echo $i
i=$(( $i + 1 ))
done


x=$(cat sign/summands/2s)
y=$(cat sign/value.random/v)

if [ "$x" == "$y" ]
then

echo equal 
else

echo not equal

fi
