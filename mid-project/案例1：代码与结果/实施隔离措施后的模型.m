%ʵʩ�����ʩ���SEIRģ��
%�����趨
N=1400050000;%�˿���
E=0;%Ǳ����
D=6;%������������
I=291;%��Ⱦ����
S=N-I;%�׸�����
R=0;%����������
r=10;%��Ⱦ�߽Ӵ�����
B=0.6225;%��Ⱦ����
a=0.125;%Ǳ����ת��Ϊ��Ⱦ�ߵĸ���
r2=10;%Ǳ���߽Ӵ�����
B2=0.03;%Ǳ���ߴ�Ⱦ�����˵ĸ���
y=0.3;%��������
k=0.03;%������
B3=0.1;%ת����
T=1:200;
for idx=1:length(T)-1
    if idx>=7
        r=5;
        r2=5;
end
    if idx<7
        S(idx+1)=S(idx)-r*B*S(idx)*I(idx)/N-r2*B2*S(idx)*E(idx)/N;%�׸���Ⱥ����
        E(idx+1)=E(idx)+r*B*S(idx)*I(idx)/N-a*E(idx)+r2*B2*S(idx)*E(idx)/N;%Ǳ���ߵ���
        I(idx+1)=I(idx)+a*E(idx)-(k+y)*I(idx);%��Ⱦ��������
        R(idx+1)=R(idx)+y*I(idx);%������������
        D(idx+1)=R(idx)+k*I(idx);%����������������
else
        S(idx+1)=S(idx)-r*B*S(idx)*I(idx)/N-r2*B2*S(idx)*E(idx)/N+B3*E(idx-6);%�׸���Ⱥ����
        E(idx+1)=E(idx)+r*B*S(idx)*I(idx)/N-a*E(idx)+r2*B2*S(idx)*E(idx)/N-B3*E(idx-6);%Ǳ���ߵ���
        I(idx+1)=I(idx)+a*E(idx)-(k+y)*I(idx);%��Ⱦ��������
        R(idx+1)=R(idx)+y*I(idx);%������������
        D(idx+1)=R(idx)+k*I(idx);%����������������
    end
end
B={'01-19','02-08','02-28','03-19','04-08','04-28','05-18','06-07','06-27','07-17','08-06'};
plot(T,E,T,I,T,R);
grid on;
hold on;
plot([7 7],[0 1000]);
set(gca,'XTickLabel',B)
xlabel('����');
ylabel('����');
legend('Ǳ����','����','������','��ʼʵʩ�����ʩ');
title('��ȡ�����ʩ��SEIRģ��');
