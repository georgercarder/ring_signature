#!/bin/bash

# given variables A,B, we xor the corresponding hexdumps hexdumpA, hexdumpB 
# the output is Z

rm A 
rm B
rm Z

echo $A >> A
echo $B >> B

hexdumpA=$(hexdump -ve '1/1 "%02x\n"' A)
hexdumpB=$(hexdump -ve '1/1 "%02x\n"' B)


la=$(echo $hexdumpA|wc -c)
lb=$(echo $hexdumpB|wc -c)

echo $la $lb



Z=""
echo $hexdumpA
echo " "
echo $hexdumpB
echo " "

i=0

while [ $i -le 1533 ]
do
xx=0x${hexdumpA:$i:2}
yy=0x${hexdumpB:$i:2}
xxx=$xx
yyy=$yy

zzz=$((( $xxx ^ $yyy ) % 256 ))
zzz=$(printf '%02x\n' $zzz)

Z=$Z' '$zzz
echo $xxx $yyy $zzz
i=$(($i+3))
done


echo $Z

echo $Z >> ./sign/Z

xxd -r -p ./sign/Z ./sign/Z.bin
