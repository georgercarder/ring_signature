#!/bin/bash


# here we package up iP, v, ix and the message and put into the signed folder

cp -r sign/publickeys.anon/* signed/publickeys.anon

echo "# this is the set of public keys P1,...,Pn" >> signed/publickeys.anon/READMEpubkeys.md   

cp -r sign/value.random/v signed/value.random

echo "# this is the random value v" >> signed/value.random/READMEvaluerandom.md

cp -r sign/inputs.local/*x signed/inputs.anon

echo "# this is the set of inputs x1,...,xn" >> signed/inputs.anon/READMEinputs.md

cp -r message/message.txt signed/message

echo "# this is the signed message. be sure to validate if unsure..." >> signed/message/READMEmessage.md

##########3
##########
######### need to build verify
