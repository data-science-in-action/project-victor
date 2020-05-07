%无任何防控措施的SEIR模型
clear;clc;
%参数设置
N= 1400050000;%人口数
I=291;%传染者
R=0;%康复者
D=6;%死亡患者数量
E=0;%潜伏者
S=N-I;%易感染者
r=10;%接触病患的人数
a=0.125;%潜伏者患病概率
B=0.6225;%感染概率
y=0.3;%康复概率
k=0.03;%死亡率
T=20:500;
for idx =1:length(T)-1
    S(idx+1)=S(idx)-r*B*I(idx)*S(idx)/N;%易感人数迭代
    E(idx+1)=E(idx)+r*B*S(idx)*I(idx)/N-a*E(idx)%潜伏者人数迭代
    I(idx+1)=I(idx)+a*E(idx)-(y+k)*I(idx);%患病人数迭代
    R(idx+1)=R(idx)+y*I(idx);%康复人数迭代 
    D(idx+1)=D(idx)+k*I(idx);%死亡患者人数迭代
end
plot(T,S,T,E,T,I,T,R,T,D);
grid on;
xlabel('日期');
ylabel('人数');
legend('易感者','潜伏者','传染者','康复者','死亡者');
title('SEIR模型');
plot(T,E,T,I,T,R,T,D);
grid on;
xlabel('日期');
ylabel('人数');
legend('潜伏者','传染者','康复者','死亡者');
title('情况');
