#!/bin/bash


# here we package up iP, v, ix and the message and put into the signed folder




mkdir -p signed/inputs.anon
mkdir -p signed/message
mkdir -p signed/publickeys.anon
mkdir -p signed/value.random
mkdir -p signed/verify


cp -r sign/publickeys.anon/* signed/publickeys.anon

echo "# this is the set of public keys P1,...,Pn" >> signed/publickeys.anon/READMEpubkeys.md   

cp -r sign/value.random/v signed/value.random

echo "# this is the random value v" >> signed/value.random/READMEvaluerandom.md

cp -r sign/inputs.anon/*x signed/inputs.anon

echo "# this is the set of inputs x1,...,xn" >> signed/inputs.anon/READMEinputs.md

cp -r message/message.txt signed/message

echo "# this is the signed message. be sure to validate if unsure..." >> signed/message/READMEmessage.md

i=1
while [ $i -le $(( $c + 1 )) ]
do
        count=$(cat sign/inputs.anon/$i\x|wc -c)
        if [ $count -ne 512 ]; then
            #    rm -r sign/inp* sign/k sign/message sign/mykeys sign/outp* sign/publ* sign/signersinput sign/summ* sign/val* signed

                echo 'Signing this message failed. Run again'

                
	fi
        i=$(( $i + 1 ))
done

##########3
##########
######### need to build verify
