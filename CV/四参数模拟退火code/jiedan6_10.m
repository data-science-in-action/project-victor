function od=jiedan6_10(xx)
%·µ»ØÖµÊÇÎó²î
global   beta z v1 v2
load('aaa.mat')
beta=xx(1);
z=xx(2);
v1=xx(3);
v2=xx(4);
h=1;
x_end=1:h:134;
x0=0;
L_t=length(x_end/h);
yy(1,:)=[10000000 1072 771 59];
yy_lge(1,:)=yy(1,:);
for i=1:L_t
    x(i,:)=x0+h*i;

yy_lge(i+1,:)=runge_kutta(h ,x(i,:),yy_lge(i,:));

end
%val=[ds,de,di,dr];
for i=2:L_t
new1(i)=yy_lge(i+1,3)-yy_lge(i,3)+yy_lge(i+1,4)-yy_lge(i,4);
if new1(i)<0
    new1(i)=0;
end
end
new1=new1';
den1=sum((aaa-new1).^2);
den2=sum( sum(new1).^2+sum(aaa).^2 );
od=1-den1/den2;
% x=[0 ;x];
%  plot(x,yy_lge)
end