#!/bin/bash




# second part of signscript...

r=$(( RANDOM % $(( $c + 1 )) + 1 ))


echo "need to rearrange iy iP etc"

hereeeeeeeeeeeeee #deliberate error to remind to rearrange

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

	1) E $(xor $(cat sign/outputs.local/1y) $(cat sign/value.random/v) )

	*) E $(xor $1\y $(S $(( $i - 1 )) ) )	
	
	esac
}

function Sinv(){

	case "$1" in

	$(( $c + 1 ))) Ekinv $( xor $(cat sign/outputs.local/$(( $c + 1 ))\y) $( Ekinv $sign/value.random/v))

	*)



}







#case "$r" in

#$(( $c + 1  )) )	A=1y
#			B=v
#			xor
#
#1)

#*)


#esac






# put my-public.pem and mx with i-public.pem and ix
# randomly enumerate but keeping in pairs 

# put in inputs.anon message pubickeys.anon and value.random


