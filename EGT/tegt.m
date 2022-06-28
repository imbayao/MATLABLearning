
clc,clear,close all; %清除命令，清空工作区，关闭所有窗口
Fx = 5;

F = 2;

Ps = 3;
Pc = 1;

R0 = 3;
E = 1;
C1 = 3;
Cs = 2;
Pp = 2;
R1 = 10;
Tx = 10;
S = 3;
Sp = 0;
Ns = 0;
C0 = 0;

% x0 = rand(1);
% y0 = rand(1);
% z0 = rand(1);
x0 = 0.5;
y0 = 0.5;
z0 = 0.5;
tspan = [0 10];

[t, y]=ode45(@(t, y)tegt(t, y, Tx, S, Pc, R1, R0, C0, C1, E, F, Fx, Pp, Sp, Ns, Cs, Ps), tspan, [x0, y0, z0]);

y1 = y(:,1);
y2 = y(:,2);
y3 = y(:,3);
figure
plot(t, y1,...
     'Color', [0 0.4470 0.7410],...
     'LineWidth',1.7);
hold on;
plot(t, y2,...
     'Color', [0.8500 0.3250 0.0980],...
     'LineWidth',1.7);
hold on;
plot(t, y3,...
     'Color', [0.4660 0.6740 0.1880],...
     'LineWidth',1.7);
hold on;
ylim([0 1]);

set(gca,...
    'XTick',0:2:10);

h1 = legend('g', 'm', 'c');
set(h1,...
    'FontName', 'Microsoft YaHei',...
    'FontSize', 10,...
    'box', 'off');
xlabel('时间',...
       'FontName', 'Microsoft YaHei',...
       'FontSize',12);
ylabel('策略概率',...
       'FontName', 'Microsoft YaHei',...
       'FontSize', 12);
grid on;
hold on;

function dy = tegt(t, y, Tx, S, Pc, R1, R0, C0, C1, E, F, Fx, Pp, Sp, Ns, Cs, Ps)
dy = zeros(3,1);
%dy(1) = y(1)*(1-y(1))*(Tx-T0-S+Pm+Pc-y(2)*(Pm+Sm)-y(3)*(Pc+Sc));
%dy(2) = y(2)*(1-y(2))*(R1-R0-C0-E+y(1)*(Sm+Pm)+y(3)*(C0-C1));
%dy(3) = y(3)*(1-y(3)*(y(2)*(F+y(1)*Sc)-Fx-y(1)*Pc));

dy(1) = y(1)*(1-y(1))*(Tx-S-Sp-Ns+Pp+Pc+y(2)*(Sp+Ns-Pp-Cs)-y(3)*(Pc+y(2)*Ps));
dy(2) = y(2)*(1-y(2))*(y(3)*(C0-C1)+y(1)*(Cs+Pp)-C0+R1-R0-E);
dy(3) = y(3)*(1-y(3))*(F+y(1)*y(2)*Ps-Fx+y(1)*Pc);
end
