
clc,clear,close all; %清除命令，清空工作区，关闭所有窗口


k = 30;
Rr = 10;
Rc = 8;
Er = 4;
Ec = 3;
Nr = 4;
Nc = 4;

lr = ((k*k+k-3)*(Rr-Er-Nr))/((k*k+k-6)*Nr);
lc = ((k*k+k-3)*(Rc-Ec-Nc))/((k*k+k-6)*Nc);
l = 0.1;
% x0 = rand(1);
% y0 = rand(1);
% z0 = rand(1);
x0 = 0.5;
y0 = 0.5;
z0 = 0.5;
tspan = [0 30];
% [t, y]=ode45(@(t, y)egt(t, y, g, r, c, k, v, s, n, o, p), tspan, [x0, y0, z0]);
% [t, y]=ode45(@(t, y)egt(t, y, a, s, m, g, cg, ph, pl, c1, cc, r1, r2, v), tspan, [x0, y0, z0]);
[t, y]=ode45(@(t, y)egt(t, y, k, Rr, Rc, Er, Ec, l, Nr, Nc), tspan, [x0, y0, z0]);

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
    'XTick',0:5:30);

h1 = legend('Direct recycling', 'Cascade utilization', 'Mixed');
set(h1,...
    'FontName', 'Arial',...
    'FontSize', 10,...
    'box', 'off');
xlabel('Time',...
       'FontName', 'Arial',...
       'FontSize',12);
ylabel('Probability of strategy',...
       'FontName', 'Arial',...
       'FontSize', 12);
grid on;
hold on;




