#!/bin/bash

# given variables A,B, we xor the corresponding hexdumps hexdumpA, hexdumpB 
# the output is Z




hexdumpA=$(hexdump -ve '1/1 "%02x\n"' sign/summands/1s)
hexdumpB=$(hexdump -ve '1/1 "%02x\n"' sign/summands/2s)


la=$(echo $hexdumpA|wc -w)
lb=$(echo $hexdumpB|wc -w)

echo $la $lb



Z=""
#echo $hexdumpA
echo " "
#echo $hexdumpB
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
#echo $xxx $yyy $zzz
i=$(($i+3))
done


#echo $Z

echo $Z > sign/summands/Z

xxd -r -p sign/summands/Z sign/summands/Z.bin
