%% tningar: 

% fungerar inte ?n
data = xlsread('data1.xls')
%%

%hastigheter
V = [2.2894;
2.1259;
2.2046;
1.9841;
2.8345;
1.9841;
2.1259;
2.2046;
1.7007;
2.0525;
1.9841];


%vinkelfrekvenser
W = [47;
    31.924;
    72.736;
    54.603;
    50.292;
    39.341;
    59.929;
    56.118;
    39.404;
    53.296;
    44.972];

%vinklar
alpha = [0.3440 0.2867 0.3801 0.4130 0.7854 0.4999 0.3048 0.4434 0.4674 0.5124 0.3785]' % h?r beh?vs riktiga v?rden



%%
H = helicopterData'
% en 11x5 matris med a, b, c, d, L i kolumnerna f?r varje helikopter

A = ones(11, 2);
B = ones(11,1);

a = H(:,1)
b = H(:,2)
c = H(:,3)
d = H(:,4)
L = H(:,5)

rho_a = 1.293

%% for equation 1
 % Filling matrix A 
for k = 1:11
A(k, 1) = a(k)*b(k)*b(k)*sin(alpha(k))*(rho_a/2) * cos(alpha(k))*V(k)*V(k)  
A(k, 2) = a(k)*b(k)*b(k)*sin(alpha(k))*(rho_a/2) * sin(alpha(k))*W(k)*W(k)*b(k)*b(k)/3
B(k) = rho_a*W(k)*W(k)*(c(k)*(b(k)^4)/6 + L(k)*(d(k)^4)/96)
end
 C = A\B % ingen ?r utel?mnad. 
 %%
 % leaving one sample out of the experiment starting with leaving the last
 % helicopter out
 
for q = 1:11
A = circshift(A, [-1, 0]) % leaving the first one out the first time
B = circshift(B, [-1,0])
Atemp = A(1:10,:)
Btemp = B(1:10,:)
constants1(q,:) = Atemp\Btemp
end
%% h?r testas helikopter 1 d?r konstanterna ?r skattade mot det stickprov d?r nr 1 utel?mnats. 

for w = 1:11
VL = A(w,1)*constants1(w,1) + A(w,2)*constants1(w,2)
HL = B(w)
test(w) = VL - HL
end



%% for equation 2
 % Filling matrix A 
 g = 9.82;
 rho_p = 0.080;
 
 
for k = 1:11
A(k, 1) = rho_a*a(k)*b(k)*cos(alpha(k)) * cos(alpha(k))*V(k)*V(k)  
A(k, 2) = -rho_a*a(k)*b(k)*cos(alpha(k)) * (sin(alpha(k))*W(k)*W(k)*b(k)*b(k)/3)
B(k) = (2*rho_p)*b(k)*(a(k) + c(k) + L(k))*g
end
 C = A\B % ingen ?r utel?mnad. 

% leave-one-out estimation
% leaving the first helicopter one out the first iteration, the second one the second iteration etc. 
for q = 1:11
A = circshift(A, [-1, 0]) 
B = circshift(B, [-1,0])
Atemp = A(1:10,:)
Btemp = B(1:10,:)
constants2(q,:) = Atemp\Btemp
end
 

%%

C_dd1 = constants2(:,1)
C_dd2 = constants2(:,2)
C_dr1 = constants1(:,1)
C_dr2 = constants1(:,2)


vy = sqrt((2*rho_p*b*(a+c+L)*g/(rho_a*a*b*cos(alpha)^2.*C_dd1))/(1-C_dd2.*sin(alpha)*b^2*C_dr1*rho_a*a*b^2*sin(alpha)*cos(alpha)/(C_dd1*cos(alpha)*(C_dr2*rho_a*a*b^2*sin(alpha)*b^2/2 + C_dm*rho_a*(c*b^4/2+L*d^4/32)))));
omega = sqrt(vy^2 * C_dr1*rho_a*a*b^2.*sin(alpha).*cos(alpha)./(C_dr2.*rho_a.*a.*(b.^2).*sin(alpha).*b^2/3 + C_dm*rho_a*(c*b^4/3 + L*d^4/48)));
