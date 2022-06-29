clc,clear,close all;

% 从excel中读取数据
% 读取了所有的产废企业和处理能力的数据
% xlsread("文件路径"，Sheet数，“数据范围”)
enterprises = xlsread("test.xlsx", 7,"B3:AT15" );
production = xlsread("test.xlsx", 7,"B19:AT31" );

% 数据预处理
% 替换产生单位中Nan的为0
enterprises(isnan(enterprises)) = 0;

% 对矩阵中所有HW求p%和c%
% 矩阵求和
a = sum(enterprises); 
b = sum(production);
% 复制矩阵
ax = repmat(a, [13, 1]); 
bx = repmat(b, [13, 1]);
% p%和c%
p = enterprises./ax;
c = production./bx;

% 选择危险废物类型
% 这里的1为第一列
hw = 1;
p_hw = p(:,hw);
c_hw = c(:,hw);

% 能力/单位数
t = c_hw ./ p_hw;
[tt, index] = sort(t);

% 基于[能力/单位数]进行重排序
p_re = p_hw(index,:);
c_re = c_hw(index,:);

% p累积和c累计
x1 = [0; cumsum(p_re)];
y1 = [0; cumsum(c_re)];

% 绘图部分
% 绘制线条设置
plot(x1,y1, '-ro',...
    'LineWidth', 1,...
    'Markersize', 7,...
    'MarkerFaceColor', 'w');
hold on
plot([0,1],[0,1],...
    'LineWidth',1,...
    'Color', [0 0.4470 0.7410])

% 全局字体大小
set(gca,'FontSize',10); 

% 设置x轴和y轴坐标间距
xticks(0:0.1:1)
yticks(0:0.1:1)

% x轴和y轴标签设置
xlabel('产生单位累计（%）',...
    'FontName','微软雅黑',...
    'FontSize',12,...
    'FontWeight','normal');
ylabel('处理能力累计（%）',...
    'FontName','微软雅黑',...
    'FontSize',12,...
    'FontWeight','normal');

% 图例设置
L1 = legend('实际分配曲线','理论公平曲线',...
    'Location','NW');
set(L1, 'box', 'off',...
    'FontName','微软雅黑',...
    'FontSize',10,...
    'FontWeight','normal');

% 关闭背景网格
grid off

% 删除上方与右侧坐标刻度
box off
ax2 = axes('Position',get(gca,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
set(ax2,'YTick', []);
set(ax2,'XTick', []);
box on

% G基尼系数计算
B=trapz(x1,y1);
A=trapz(x1,x1-y1);
G=A/(A+B)

% 高斯拟合部分
[xData, yData] = prepareCurveData( x1, y1 );

% 拟合选项
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [1 1 0.130456720945348];

% 拟合结果
% fitresult为拟合结果
% gof为拟合检验结果数据
[fitresult, gof] = fit( xData, yData, ft, opts );
fitresult
gof

% 拟合结果绘图
figure( 'Name', '拟合情况' );
h = plot( fitresult, xData, yData );
legend( h, '实际点', '拟合曲线', 'Location', 'NorthEast' );

xlabel x1
ylabel y1
grid on
