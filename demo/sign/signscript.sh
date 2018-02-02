#!/bin/bash


# given message.txt, mykeys, and i-public.pem for i in 1:7
# want to give recipient:
# message.txt
# (P1,...,P8,v,x1,...,x8)
# where Pi are public keys of 'coven',
# v is random value
# ix are 'random' inputs


##################################
#build directories for sign
#################################

mkdir -p sign/inputs.local/inputgenerators/inputgenerators.private
mkdir sign/k
mkdir sign/outputs.local
mkdir sign/signersinput
mkdir -p sign/value.random/valuegenerator/valuegenerator.private

##################
# build iinput-private.pem

openssl genrsa -out ./sign/inputs.local/inputgenerators/inputgenerators.private/input-private.pem 4096 -outform PEM


openssl rsa -in ./sign/inputs.local/inputgenerators/inputgenerators.private/input-private.pem -out ./sign/inputs.local/inputgenerators/input-public.pem -pubout -outform PEM
x=$(echo "seeds"|sha256sum)
seed=${x:0:63}

x=1
while [ $x -le $c ]
do
y=$(echo $seed|sha256sum)
seed=${y:0:63}
echo $seed >> ./sign/inputs.local/inputgenerators/$x\inputgenerator.txt
x=$(( $x + 1 ))
done


# build ix 
x=1
while [ $x -le $c ]
do
openssl rsautl -encrypt -inkey ./sign/inputs.local/inputgenerators/input-public.pem -pubin -in ./sign/inputs.local/inputgenerators/$x\inputgenerator.txt -out ./sign/inputs.local/$x\x
x=$(( $x + 1 ))
done
###################

# build value-private.pem

y=$(echo $seed|sha256sum)
seed=${y:0:63}
echo $seed>> ./sign/value.random/valuegenerator/value256hash.txt
openssl genrsa -out ./sign/value.random/valuegenerator/valuegenerator.private/value-private.pem 4096 -outform PEM
# build value-public.pem
openssl rsa -in ./sign/value.random/valuegenerator/valuegenerator.private/value-private.pem -out ./sign/value.random/valuegenerator/value-public.pem -pubout -outform PEM
# build v
openssl rsautl -encrypt -inkey ./sign/value.random/valuegenerator/value-public.pem -pubin -in ./sign/value.random/valuegenerator/value256hash.txt -out ./sign/value.random/v
###################

#build k
x=$(cat ./sign/message/message.txt|sha256sum)
echo ${x:0:63} > ./sign/k/keyhash.txt


# mx=rsa^-1(E_k^-1(v)+E_k(y7+E_k(y6+...E_k(y1+v)...)
#construct iy
x=1
while [ $x -le $c ]
do
openssl rsautl -raw -encrypt -inkey ./sign/publickeys.local/$x\-public.pem -pubin -in ./sign/inputs.local/$x\x -out ./sign/outputs.local/$x\y
x=$(( $x + 1 ))
done



#get mx
###################

# put my-public.pem with i-public.pem and cm with ix

# randomly enumerate but keeping i n pairs

# put in inputs.anon message publickeys.anon value.random 
