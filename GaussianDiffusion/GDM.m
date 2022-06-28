clc,clear,close all; %清除命令，清空工作区，关闭所有窗口

[x,y]=meshgrid(0:1:500,-500:1:500); %设定网格，下风向排放点距离x米，烟气中心轴水平距离y米

Q=3.954;%源强，释放速度

% B
% gam1=0.281846;gam2=0.127190;
% alp1=0.914370;alp2=0.964435;
% gam3=0.396353;gam4=0.057025;
% alp3=0.865014;alp4=1.09356;

% C
gam1=0.177154;gam2=0.106803;
alp1=0.924279;alp2=0.917595;
gam3=0.232123;gam4=0.106803;
alp3=0.885157;alp4=0.917959;

% D
% gam1=0.110726;gam2=0.104634;
% alp1=0.926849;alp2=0.826212;
% gam3=0.146669;gam4=0.400167;
% alp3=0.888723;alp4=0.632023;

% F
%gam1=0.0553634;gam2=0.0620765;
%alp1=0.929418;alp2=0.7844;
%gam3=0.0733348;gam4=0.370015;
%alp3=0.888723;alp4=0.525969;


sigy=gam1*x.^alp1.*(x>=0&x<=1000)+gam3*x.^alp3.*(x>1000);%水平扩散系数
sigz=gam2*x.^alp2.*(x>=0&x<=500)+gam4*x.^alp4.*(x>500);%垂直扩散系数
u=4;%风速
He=15; %有效高度
z=7;%高度

 

Qpi=2*Q./(2*pi*u.*sigy.*sigz+eps);%计算公式第一部分
ex1=exp(-0.5*(y./(sigy+eps)).^2);%计算公式第二部分
ex2=exp(-0.5*((z-He)./(sigz+eps)).^2)+exp(-0.5*((z+He)./(sigz+eps)).^2);%计算公式第三部分
C=Qpi.*ex1.*ex2;%计算扩散气体浓度

 

mesh(x,y,C);

xlabel('x轴下风向距离(m)'),ylabel('y轴向距离(m)'),zlabel('气体扩散浓度'),

[Cmax,I]=max(C(:));%计算c的最大值（Cmax），并得到下标

xmax=x(I);%利用下标得到x的最大值（xmax）


designatedX = 200; % 指定的X轴
transX = designatedX * 1001 + 1; % X轴转换
transY = transX + 500; % Y轴转换
realX = x(transX); % 转换后的X
realY = y(transY); % 转换后的Y
Cneed = C(transY);
