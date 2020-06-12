function y=runge_kutta(h,x0,y0)
k1=ode6_10(x0,y0);
k2=ode6_10(x0+h/2,y0+h/2*k1);
k3=ode6_10(x0+h/2,y0+h/2*k2);
k4=ode6_10(x0+h,y0+h*k3);
y=y0+h*(k1+2*k2+2*k3+k4)/6;
end