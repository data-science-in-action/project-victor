%% SA 模拟退火
clear; clc

%% 参数初始化
narvs = 4; % 变量个数
T0 = 100;   % 初始温度
T = T0; % 迭代中温度会发生改变，第一次迭代时温度就是T0
maxgen = 200;  % 最大迭代次数
Lk = 100;  % 每个温度下的迭代次数
alfa = 0.95;  % 温度衰减系数
x_lb = [0 0 0 0]; % x的下界
x_ub =[1 1 1 1]; % x的上界


%%  随机生成一个初始解
x0 = x_lb + (x_ub - x_lb).*rand(1,narvs) ;
% h = scatter(x0,jiedan6_10(x0),'*r');  % scatter是绘制二维散点图的函数（这里返回h是为了得到图形的句柄，未来我们对其位置进行更新）

%% 初始化用来保存中间结果的x和y的取值
iter_x = x0;
iter_y = jiedan6_10(x0);

%% 模拟退火过程
for iter = 1 : maxgen  % 外循环, 我这里采用的是指定最大迭代次数
    for i = 1 : Lk  % 内循环，在每个温度下开始迭代
%         title(['当前温度：',num2str(T)])
        y0 = jiedan6_10(x0); % 计算当前解的函数值
%         disp('**************************分**割**线**************************')
%         disp(['当前解的函数值：',num2str(y0)])
        y = randn(1,narvs);  % 生成1行narvs列的N(0,1)随机数
        z = y / sqrt(sum(y.^2)); % 根据新解的产生规则计算z
        x_new = x0 + z*T; % 根据新解的产生规则计算x_new的值
        % 如果这个新解的位置超出了定义域，就对其进行调整
        for j = 1: narvs
            if x_new(j) < x_lb(j)
                r = rand(1);
                x_new(j) = r*x_lb(j)+(1-r)*x0(j);
            elseif x_new(j) > x_ub(j)
                r = rand(1);
                x_new(j) = r*x_ub(j)+(1-r)*x0(j);
            end
        end
        x1 = x_new;    % 将调整后的x_new赋值给新解x1
        y1 = jiedan6_10(x1);  % 计算新解的函数值
%         disp(['新解的函数值：',num2str(y1)])
        if y1<=y0    % 如果新解函数值大于当前解的函数值
%             disp('更新当前解为新解')
            x0 = x1; % 更新当前解为新解
            iter_x = [iter_x; x1]; % 将新找到的x1添加到中间结果中
            iter_y = [iter_y; y1];  % 将新找到的y1添加到中间结果中
        else
            p = exp(-(y0 - y1)/T); % 根据Metropolis准则计算一个概率
%             disp(['新解的函数值小于当前解的函数值，接受新解的概率为：',num2str(p)])
            if rand(1) < p   % 生成一个随机数和这个概率比较，如果该随机数小于这个概率
%                 disp('该随机数小于这个概率，那么我们接受新解')
                x0 = x1;  % 更新当前解为新解
            end
        end

    end  
    T = alfa*T;   % 温度下降
    pause(0.01)  % 暂停一段时间(单位：秒)后再接着画图

end
x0
y1