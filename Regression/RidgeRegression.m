clc,clear,close all; %清除命令，清空工作区，关闭所有窗口
x=[21.02	8.75	3.95	5.23	13.44	6.00	15.07	6.64	2.76;
21.03	8.86	3.97	5.20	13.43	7.00	15.04	6.76	4.59;
21.03	8.95	3.99	5.21	13.49	8.00	15.08	6.78	5.31;
21.04	9.00	4.02	5.21	13.45	9.00	15.02	6.83	5.65;
21.04	9.01	4.04	5.21	13.50	10.00	15.09	6.94	5.96;
21.05	9.09	4.06	5.20	13.53	11.00	15.13	7.02	6.07;
21.05	9.21	4.08	5.19	13.58	12.00	15.17	7.12	6.14;
21.06	9.23	4.10	5.16	13.56	13.00	15.18	7.14	6.22;
21.06	9.26	4.12	5.15	13.58	14.00	15.20	7.20	6.24;]
y=[8.30;8.41;8.44;8.48;8.59;8.66;8.76;8.78;8.84];
x'*x;
count=0;
kvec=0.1:0.1:1;
for k=0.1:0.1:1
    count=count+1;
    [b,bint,r,rint,stats]=ridge1(y,x,k);
    bb(:,count)=b;
    stats1(count,:)=stats; 
end
bb',stats1 
plot(kvec',bb),xlabel('k'),ylabel('b','FontName','Symbo l')

function [b,bint,r,rint,stats] = ridge1(Y,X,k) 
[n,p] = size(X);
mx = mean (X);
my = mean (Y); 
stdx = std(X);
stdy=std(Y);
idx = find(abs(stdx) < sqrt(eps));
MX = mx(ones(n,1),:);
STDX = stdx(ones(n,1),:);
Z = (X - MX) ./ STDX;Y=(Y-my)./stdy;
pseudo = sqrt(k*(n-1)) * eye(p);
Zplus = [Z;pseudo];
Yplus = [Y;zeros(p,1)];
[b,bint,r,rint,stats] = regress(Yplus,Zplus);
end
