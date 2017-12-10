#run signscript.sh
#this script will generate random x1,...,x7 and random value v
#then it will find x_s so that rsa(x_s) with myprivatekey will yield
#rsa(x_s)=y_s
#where y_s=E_k^-1+E_k(y7+E_k(y6+..E_k(y1+v)))
#where yi=rsa(xi) with the respective public keys
# finally the message will be packaged with (P1,...,Pn,v,x1,...,xn)
# where Pi are public keys of committee.
# UNDER CONSTRUCTION 
