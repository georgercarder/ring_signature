#!/bin/bash

# given variables A,B, we xor the corresponding hexdumps hexdumpA, hexdumpB 
# the output is Z



echo $A > sign/A
echo $B > sign/B

hexdumpA=$(hexdump -ve '1/1 "%02x\n"' sign/A)
hexdumpB=$(hexdump -ve '1/1 "%02x\n"' sign/B)


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

echo $Z > sign/Z

xxd -r -p sign/Z sign/Z.bin
