Ring Signature is an implementation of a cryptographic scheme for a member 
 of a commitee to anonymously sign a document where the recipient can validate 
 the signature. This signature first appeared in a paper by Ron Rivest, 
 Adi Shami, and Yel Tauman.
The signature goes as follows:
 A signer with public key Pk belonging to committee with public keys {P1,P2,...,Pn}, wants to 
 sign a message m.<br> The signer gets key k=H(m) from hash H() for use with 
 symmetric cipher C(). Signer picks set of random values {x1,x2,..,v,..,xn} 
 where random value v replaces a kth value in place of the signer. From the 
 set the signer generates set {y1,y2,...,^,...,yn} where yi=rsa_Pi(xi) is the 
 image of xi under rsa with public key Pi. From here the signer solves equation
 C(yn+C(y(n-1)+C(y(n-2)+...+C(yk+...C(y1+v)...))))=v for yk and finds 
 xk=rsa^(-1)Privk(yk) the pre-image of yk under rsa with Private key Privk
 corresponding to public key Pk.<br>Now the message is signed and the package 
 (m,v,x1,x2,...,xn,P1,P2,...,Pn) is served to the recipient.
 The recipient can validate the message as being signed by the commitee by 
 pluggin these values into the above equation. The signature cannot be forged
 since the "easiest" ways to forge the signature would be finding a fixed point
 v for Ck(v)=v where Ck(x)=C(yn+C(y(n-1)+...C(y1+x))), or breaking rsa!<br><br>
 This project has been fun and I wrote it entirely in bash using openssl but I 
 did get hung up using these tools at the step where I find xk due to "magic 
 numbers" with openssl.<br><br>I plan to rewrite this project in Cryptol where
 

I have a hunch I will not run into the "magic numbers" problem. # UNDERCONSTRUCTION. project contains demo sandbox src testing. When complete, only src and demo will remain


# still need to program verification process but if you are curious..

# you can run the demo by cloning the demo folder and entering ./run.sh within
# the demo directory

# once "verification" is written, then src will be ready for use
