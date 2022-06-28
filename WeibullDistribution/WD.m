clc,clear,close all; %清除命令，清空工作区，关闭所有窗口
t1 = 0:21;
dy = [5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5];

h1 = wblpdf(t1, 15.5, 3.5)
% h3 = wblpdf(t, 7.5, 3.5);
% h4 = wblpdf(t, 8.5, 3.5);
% h2 = wblcdf(t, 5.5, 3.5);
% % 可靠度
% h3 = 1 - h2;


% plot(t1, h1, 'r-');
%h1;
% plot(t, h3, 'y-'); hold on;
% plot(t, h4, '-'); hold on;
% plot(t, h3, 'b-');