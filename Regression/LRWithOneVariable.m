%原始数列
x = 2012:2020;
y = [57067.11808, 63720.00556, 65502.62852, 68720.66669, 76332.53539, 82116.50762, 90804.80388, 92478.25069, 98606.24644];

cofficient = polyfit(x,y,1);
y1 = polyval(cofficient, x);


plot(x, y, 'o', x, y1, '-');

R2 = norm(y1 -mean(y))^2/norm(y - mean(y))^2;




% R方
% Rsq = 1 - sum((Y'-yCalc1).^2)/sum((Y'-mean(Y')).^2);
% disp('R方为：');
% Rsq

