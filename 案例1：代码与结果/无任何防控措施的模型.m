%���κη��ش�ʩ��SEIRģ��
clear;clc;
%��������
N= 1400050000;%�˿���
I=291;%��Ⱦ��
R=0;%������
D=6;%������������
E=0;%Ǳ����
S=N-I;%�׸�Ⱦ��
r=10;%�Ӵ�����������
a=0.125;%Ǳ���߻�������
B=0.6225;%��Ⱦ����
y=0.3;%��������
k=0.03;%������
T=20:500;
for idx =1:length(T)-1
    S(idx+1)=S(idx)-r*B*I(idx)*S(idx)/N;%�׸���������
    E(idx+1)=E(idx)+r*B*S(idx)*I(idx)/N-a*E(idx)%Ǳ������������
    I(idx+1)=I(idx)+a*E(idx)-(y+k)*I(idx);%������������
    R(idx+1)=R(idx)+y*I(idx);%������������ 
    D(idx+1)=D(idx)+k*I(idx);%����������������
end
plot(T,S,T,E,T,I,T,R,T,D);
grid on;
xlabel('����');
ylabel('����');
legend('�׸���','Ǳ����','��Ⱦ��','������','������');
title('SEIRģ��');
plot(T,E,T,I,T,R,T,D);
grid on;
xlabel('����');
ylabel('����');
legend('Ǳ����','��Ⱦ��','������','������');
title('���');
