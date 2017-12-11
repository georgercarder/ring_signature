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


##find ry here

cat sign/value.random/v > sign/summands/2s

i=1
while [ $i -le $(( r - 1 )) ]
do
	cat sign/outputs.anon/$i\y > sign/summands/1s

	./sign/xorhexdumpstobinary.sh

	cat sign/summands/Z.bin > sign/summands/2s

echo $i
i=$(( $i + 1 ))
done

cat sign/summands/Z.bin > sign/summands/ZZ.bin


openssl enc -in sign/value.random/v -out sign/summands/2s -d -aes256 -k sign/k/keyhash.txt

i=$(( $c + 2 ))

while [ $i -ge $(( $r + 1 )) ] 
do
	cat sign/output.anon/$i\y > sign/summands/1s

	./sign/xorhexdumpstobinary.sh

	cat sign/summands/Z.bin > sign/summands/2s 

echo $i
i=$(( $i - 1 ))
done


# now we have Z.bin and ZZ.bin

cat sign/summands/Z.bin > sign/summands/1s
cat sign/summands/ZZ.bin > sign/summands/2s

./sign/xorhexdumpstobinary.sh

cat sign/summands/Z.bin > sign/outputs.anon/$r\y



# getting ry

# getting rx

openssl rsautl -decrypt -inkey sign/mykeys/private/my-private.pem -in sign/outputs.anon/$r\y -out sign/inputs.anon/$r\x


cat sign/inputs.anon/$r\x > signed/inputs.anon/$r\x



