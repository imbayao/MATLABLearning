
x = 1:6;
y = [21.64, 58.32, 109, 153, 261, 381];
pre_x = 1:22;

fun = 'y~b1/(1+b2*exp(-b3*x))';
c0 = [2000, 8.8147, 0.0001];
%opts = statset('Display','iter','TolFun',1e-10);
%mdl = fitnlm(x, y, 'y~b1/(1+b2*exp(-b3*x))', c0, 'Options',opts);
logimod=fitnlm(x,y,fun,c0)

pre_result = 893.2./(1+50.091.*exp(-0.6031.*pre_x));
hold on;


plot(x, y, 'rs', pre_x, pre_result, 'b'); set(gca, 'ygrid', 'on');