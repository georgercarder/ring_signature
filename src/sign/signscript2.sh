#!/bin/bash




# second part of signscript...

r=$(( RANDOM % $(( $c + 1 )) + 1 ))

echo 'r is' $r


echo "need to rearrange iy iP etc"


mkdir -p sign/publickeys.anon

cat sign/mykeys/public/my-public.pem > sign/publickeys.anon/$r\-public.pem

if [ $r -le $c ]; then
	i=$(( $c + 1 ))

	while [ $i -ge $r ]
	do
		cat sign/inputs.local/$i\x > sign/inputs.local/$(( $i + 1 ))\x
		cat sign/outputs.local/$i\y > sign/outputs.local/$(( $i + 1 ))\y
		cat sign/publickeys.local/$i\-public.pem > sign/publickeys.anon/$(( $i + 1 ))\-public.pem
	echo $i 'i is'	
	i=$(( $i - 1 ))
	done

         ##############

	i=1

	while [ $i -le $(( $r - 1 )) ]
	do
		cat sign/inputs.local/$i\x > sign/inputs.local/$i\x
                cat sign/outputs.local/$i\y > sign/outputs.local/$i\y
                cat sign/publickeys.local/$i\-public.pem > sign/publickeys.anon/$i\-public.pem
	i=$(( $i + 1 ))
	done

fi

# cases to get my and mx

#write function here for E_k(A+B)


function Ek(){
	openssl enc -in $1 -out E -e -aes256 -k sign/k/keyhash.txt
}

function Ekinv(){
	openssl enc -in $1 -out Einv -e -aes256 -k sign/k/keyhash.txt
}

function xor(){
	A=$1
	B=$2
	./sign/xorhexdumpstobinary.sh
}

function S(){
	case "$1" in

	0) cat sign/value.random/v > E
	
	1) E $( xor $(cat sign/outputs.local/1y) $(cat sign/value.random/v) )

	*) E $(xor $(cat sign/outputs.local/$1\y) $(S $(( $i - 1 )) ) )	
	
	esac
}

function Sinv(){

	case "$1" in

	$(( $c + 1 ))) Ekinv $( xor $(cat sign/outputs.local/$(( $c + 1 ))\y) $( Ekinv $sign/value.random/v))

	*) Ekinv $( xor $(cat sign/outputs.local/$1\y) $(Sinv $(( $1 + 1 ))) )

	esac

}



# getting ry

xor $( S $(( $r -1 )) ) $(Sinv $(( $r + 1 )) ) > sign/outputs.local/$r\y

# getting rx

openssl rsautl -decrypt -inkey sign/mykeys/private/my-private.pem -in sign/outputs.local/$r\y -out sign/inputs.local/$r\x




# put my-public.pem and mx with i-public.pem and ix
# randomly enumerate but keeping in pairs 

# put in inputs.anon message pubickeys.anon and value.random

