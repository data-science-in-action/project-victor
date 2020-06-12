function val=ode6_10(x,y)
global   beta z v1 v2
S=y(1);
E=y(2);
I=y(3);
R=y(4);
N=S+E+I+R;
ds=-beta*exp(-z*x)*S*I/N;
de=beta*exp(-z*x)*S*I/N-v1*E;
di=v1*E-1/v2*I;
dr=v2*I;
val=[ds,de,di,dr];
