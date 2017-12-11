#!/bin/bash




# second part of signscript...

r=$(( RANDOM % $c + 1 ))

echo 'r is' $r


echo "need to rearrange iy iP etc"


mkdir -p sign/publickeys.anon
mkdir -p sign/inputs.anon
mkdir -p sign/outputs.anon


cat sign/mykeys/public/my-public.pem > sign/publickeys.anon/$r\-public.pem

if [ $r -le $c ]; then
	i=$(( $c + 1 ))

	while [ $i -ge $r ]
	do
		cat sign/inputs.local/$i\x > sign/inputs.anon/$(( $i + 1 ))\x
		cat sign/outputs.local/$i\y > sign/outputs.anon/$(( $i + 1 ))\y
		cat sign/publickeys.local/$i\-public.pem > sign/publickeys.anon/$(( $i + 1 ))\-public.pem
	echo $i 'i is'	
	i=$(( $i - 1 ))
	done

         ##############

	i=1

	while [ $i -le $(( $r - 1 )) ]
	do
		cat sign/inputs.local/$i\x > sign/inputs.anon/$i\x
                cat sign/outputs.local/$i\y > sign/outputs.anon/$i\y
                cat sign/publickeys.local/$i\-public.pem > sign/publickeys.anon/$i\-public.pem
	i=$(( $i + 1 ))
	done

fi

# cases to get my and mx

#write function here for E_k(A+B)

function xor(){
	A=$1
	B=$2
	export A
	export B

	./sign/xorhexdumpstobinary.sh
}


function Ek(){
	openssl enc -in $1 -out E -e -aes256 -k sign/k/keyhash.txt
}

function Ekinv(){
	openssl enc -in $1 -out Einv -e -aes256 -k sign/k/keyhash.txt
}



##find ry here

#building s1=E(y1+v) and vinv=Ekinv(v)

#need to build y1+v
#redo below
openssl enc -in sign/value.random/v -out so -e -aes256 -k sign/k/keyhash.txt
#need to build einv(v)

# now do while loop to build ry




vinv=$( Ekinv $( cat sign/value.random/v ) )








# getting ry

xor $( S $(( $r - 1 )) ) $(Sinv $(( $r + 1 )) ) > sign/outputs.anon/$r\y

# getting rx

openssl rsautl -decrypt -inkey sign/mykeys/private/my-private.pem -in sign/outputs.anon/$r\y -out sign/inputs.anon/$r\x




# put my-public.pem and mx with i-public.pem and ix
# randomly enumerate but keeping in pairs 

# put in inputs.anon message pubickeys.anon and value.random

