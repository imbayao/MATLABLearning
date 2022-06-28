
clc,clear,close all; %清除命令，清空工作区，关闭所有窗口
xdata=1:7;
ydata=[21.64 58.32 109 153 261 381 492];
%% 指定非线性函数拟合曲线
X0=[1000 10 0.5];
[parameter,resnorm]=lsqcurvefit(@fun,X0,xdata,ydata); %指定拟合曲线
mdl = fitnlm(xdata,ydata,@fun,X0)
A=parameter(1);
B=parameter(2);
C=parameter(3);
X1=[A B C];
fprintf('拟合Logistic曲线的参数A为：%.8f，B为：%.8f，C为：%.8f', A, B, C);
fit_y=fun(parameter,xdata);
figure(1)
plot(xdata, ydata, 'r*');
hold on
plot(xdata,fit_y,'b-');
xlabel('t');
ylabel('y');
legend('观测数据点','拟合曲线', 'Location', 'northwest');
saveas(gcf,sprintf('Logistic曲线.jpg'),'bmp');

R_sq = 1-var(ydata-fit_y)/var(ydata)

%% Logistic函数
% y=A/(1+B*exp(-C*t))
function f=fun(X,t)
f=X(1)./(1+X(2).*exp(-X(3).*(t)));
end