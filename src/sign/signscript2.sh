#!/bin/bash




# second part of signscript...

r=$(( RANDOM % $c + 1 ))

echo 'r is' $r


echo "need to rearrange iy iP etc"


mkdir -p sign/publickeys.anon
mkdir -p sign/inputs.anon
mkdir -p sign/outputs.anon
mkdir -p sign/summands

cat sign/mykeys/public/my-public.pem > sign/publickeys.anon/$r\-public.pem

if [ $r -le $c ]; then
	i=$c

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

	echo $i i iss
	i=$(( $i + 1 ))
	done

fi

# cases to get my and mx


##find ry here

cat sign/value.random/v > sign/summands/2s

i=1
while [ $i -le $(( r - 1 )) ]
do
	cat sign/outputs.anon/$i\y > sign/summands/1s

	./sign/xorhexdumpstobinary.sh

	openssl enc -in sign/summands/Z.bin -out sign/summands/2s -e -aes256 -k sign/k/keyhash.txt

echo $i
i=$(( $i + 1 ))
done

cat sign/summands/2s > sign/summands/22s


openssl enc -in sign/value.random/v -out sign/summands/2s -d -aes256 -k sign/k/keyhash.txt

i=$(( $c + 1 ))

while [ $i -ge $(( $r + 1 )) ] 
do
	cat sign/outputs.anon/$i\y > sign/summands/1s

	./sign/xorhexdumpstobinary.sh

	openssl enc -in sign/summands/Z.bin -out sign/summands/2s -d -aes256 -k sign/k/keyhash.txt 

echo $i
i=$(( $i - 1 ))
done


# now we have 2s and 22s 

cat sign/summands/2s > sign/summands/1s
cat sign/summands/22s > sign/summands/2s

./sign/xorhexdumpstobinary.sh

cat sign/summands/Z.bin > sign/outputs.anon/$r\y



# getting ry

# getting rx

openssl rsautl -raw -decrypt -inkey sign/mykeys/private/my-private.pem -in sign/outputs.anon/$r\y -out sign/inputs.anon/$r\x




