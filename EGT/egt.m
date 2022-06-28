% function dy = egt(t, y, g, r, c, k, v, s, n, o, p)
% dy = zeros(3,1);
% dy(1) = y(1)*(1-y(1))*(y(2)*g*-1+g+r-c);
% dy(2) = y(2)*(1-y(2))*(y(3)*(y(1)*k*v+s-p)-v-n-y(1)*g);
% dy(3) = y(3)*(1-y(3))*(y(1)*k*v*1-y(2)-o);
% end
% 
% function dy = egt(t, y, a, s, m, g, cg, ph, pl, c1, cc, r1, r2, v)
% dy = zeros(3,1);
% dy(1) = y(1)*(1-y(1)) * (y(2) * (y(3) * a - s - a - y(3) * m) + g + a - y(3) * a - cg);
% dy(2) = y(2)*(1-y(2))*(y(3)*(ph+pl-y(1)*a-2*c1)+y(1)*(s+a)+c1-pl-cc);
% dy(3) = y(3)*(1-y(3))*(y(1)*y(2)*m+y(2)*(r1+r2-4*v)+2*v-r2);
% end

function dy = egt(t, y, k, Rr, Rc, Er, Ec, l, Nr, Nc)
    a11 = Rr-Er-(1+l)*Nr;
    a12 = Rr-Er-Nr;4
    a13 = Rr-Er-(1+l)*Nr;
    a21 = Rc-Ec-Nc;
    a22 = Rc-Ec-(1+l)*Nc;
    a23 = Rc-Ec-(1+l)*Nc;
    a31 = Rr+Rc-Er-Ec-(1+l)*Nr-Nc;
    a32 = Rr+Rc-Er-Ec-Nr-(1+l)*Nc;
    a33 = Rr+Rc-Er-Ec-(1+l)*(Nr+Nc);
    dy = zeros(3,1);
    phi = y(1)*y(1)*a11 + y(2)*y(2)*a22 + y(3)*y(3)*a33 + y(1)*y(2)*(a12+a21) + y(1)*y(3)*(a13+a31) + y(2)*y(3)*(a23+a32);
    dy(1) = y(1)*( y(1)*a11 + y(2)*(a12+((k+3)*a11-3*a21-k*a12)/(k*k+k-6)) + y(3)*(a13+((k+3)*a11-3*a31-k*a13)/(k*k+k-6)) - phi);
    dy(2) = y(2)*( y(1)*(a21+((k+3)*a22-3*a12-k*a21)/(k*k+k-6)) + y(2)*a22 + y(3)*(a23+((k+3)*a22-3*a32-k*a23)/(k*k+k-6)) - phi);
    dy(3) = y(3)*( y(1)*(a33+((k+3)*a13-3*a31-k*a12)/(k*k+k-6)) + y(2)*(a32+((k+3)*a33-3*a23-k*a32)/(k*k+k-6)) + y(3)*a33 - phi);
    end