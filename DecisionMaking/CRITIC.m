clc;clear;
X=[-17.62 122.32 -23.20 6.18   161.15 1.78
-3.50  -18.15 -10.79 -40.02 -60.27 -13.60
-1.73  -4.26  12.34  34.68  78.40  -20.78
2.85   12.73  11.54  103.28 28.34  -44.76
5.25   -2.54  14.78  74.38  47.33  -67.85];
[n,m]=size(X);
%X(:,3) = min_best(X(:,3)) ;% 将极小型指标转化为加大型
xmin = min(X);
xmax = max(X);
xmaxmin = xmax-xmin;
Z =(X-xmin)./repmat(xmaxmin,n,1);  % 最大值最小值标准化，去除量纲
R = corrcoef(Z);  % 计算相关系数矩阵，但是要将相关系数矩阵都变成正相关
for i =1:n
    for j=1:m
        if R(i,j)<0
            R(i,j)=-R(i,j);
        end
    end
end 
delta = zeros(1,m);
c = zeros(1,m);
for j=1:m
    delta(j) = std(Z(:,j));
    c(j)= size(R,1)-sum(R(:,j));
end
C = delta.*c;
w =C./(sum(C))

% min_best子函数：
function [change_x]=min_best(x)
  r=size(x,1);
  change_x = repmat(max(x),r,1)-x;
end
