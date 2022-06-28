%建立符号变量a(发展系数)和b(灰作用量)
syms a b;
c = [a b]';

%原始数列 A

A = [3.3,4,4,4.4];
n = length(A);

% 数列极比
X = [exp(-2/(n+1)); exp(2/(n+1))];
for j = 2:n
    K(j) = A(j - 1)/A(j);
    if K(j)>X(1) && K(j)<X(2)
        disp('通过级比效验');
    else
        error('未通过级比效验');
    end
end

%对原始数列 A 做累加得到数列 B
B = cumsum(A);

%对数列 B 做紧邻均值生成
for i = 2:n
    C(i) = (B(i) + B(i - 1))/2; 
end
C(1) = [];

%构造数据矩阵 
B = [-C;ones(1,n-1)];
Y = A; Y(1) = []; Y = Y';

%使用最小二乘法计算参数 a(发展系数)和b(灰作用量)
c = inv(B * B') * B * Y;
c = c';
a = c(1); b = c(2);

%预测后续数据
F = []; F(1) = A(1);
for i = 2:(n+11)
    F(i) = (A(1)-b/a)/exp(a*(i-1))+ b/a;
end

%对数列 F 累减还原,得到预测出的数据
G = []; G(1) = A(1);
for i = 2:(n+11)
    G(i) = F(i) - F(i-1); %得到预测出来的数据
end

disp('预测数据为：');
G

%模型检验

H = G(1:4);
%计算残差序列
epsilon = A - H;

%法一：相对残差Q检验
%计算相对误差序列
delta = abs(epsilon./A);
%计算相对误差Q
disp('相对残差Q检验：')
Q = mean(delta)

%法二：方差比C检验
disp('方差比C检验：')
C = std(epsilon, 1)/std(A, 1)

%法三：小误差概率P检验
S1 = std(A, 1);
tmp = find(abs(epsilon - mean(epsilon))< 0.6745 * S1);
disp('小误差概率P检验：')
P = length(tmp)/n



%绘制曲线图
t1 = 2016:1:2019;
t2 = 2016:1:2030;


scatter(t1, A, 'ro')
hold on;
plot(t2, G, 'g-');
xlabel('年份'); ylabel('脱硫石膏总产生量（亿万吨）');
legend('实际值','预测值');

set(gca, 'xtick', t2);
box on;
grid on;
