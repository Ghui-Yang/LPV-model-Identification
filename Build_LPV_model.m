clear;clc;

Tsw = 35;
N_1 = 500;
U_1 = gbngen(N_1,Tsw);
w_1 = ones(N_1,1);

N_2 = 1500;
U_2 = gbngen(N_2,Tsw);
w_2 = linspace(1,2.25,N_2)';

N_3 = 500;
U_3 = gbngen(N_3,Tsw);
w_3 = 2.25*ones(N_1,1);

N_4 = 1500;
U_4 = gbngen(N_4,Tsw);
w_4 = linspace(2.25,4,N_4)';

N_5 = 500;
U_5 = gbngen(N_5,Tsw);
w_5 = 4*ones(N_5,1);

da_Num = N_1+N_2+N_3+N_4+N_5;
U = [U_1;U_2;U_3;U_4;U_5];
W = [w_1;w_2;w_3;w_4;w_5];
Y = zeros(da_Num,1);
for i = 1:da_Num
    [dnum,dden] = Get_dnumden(W(i));
    Y(i+1,1) = dnum(2)*U(i) - dden(2) * Y(i,1);
end
Y = Y(1:da_Num,1);

% THoe01 = oe([Y(2001:2500,1),U_1],[1,1,1]); 

%% model Identification
phi_1 = [];
phi_2 = [];
phi_3 = [];
k = [1,1.5,1.9,2.25,2.7,3.4,4];
for i = 1:da_Num
    phi_1 = [phi_1;[1,W(i),abs(W(i)-k(2))^3,abs(W(i)-k(3))^3,abs(W(i)-k(4))^3,abs(W(i)-k(5))^3,abs(W(i)-k(6))^3]];
end
phi_2 = phi_1;
phi_3 = phi_1;
Total_data = 4500;

y1_hat =  Get_yhat(1,U);
y2_hat =  Get_yhat(2.25,U);
y3_hat =  Get_yhat(4,U);

PHI_1 = phi_1.*y1_hat;
PHI_2 = phi_2.*y2_hat;
PHI_3 = phi_3.*y3_hat;
PHI = [PHI_1,PHI_2,PHI_3];
beta = ((PHI'*PHI)\PHI')*Y;
w_step = (1:0.01:4)';
alpha_1 = beta(1) + beta(2)*w_step + beta(3)*abs(w_step-k(2)).^3 + beta(4)*abs(w_step-k(3)).^3 +...
    + beta(5)*abs(w_step-k(4)).^3 + beta(6)*abs(w_step-k(5)).^3 + beta(7)*abs(w_step-k(6)).^3;

alpha_2 = beta(1+7) + beta(2+7)*w_step + beta(3+7)*abs(w_step-k(2)).^3 + beta(4+7)*abs(w_step-k(3)).^3 +...
    + beta(5+7)*abs(w_step-k(4)).^3 + beta(6+7)*abs(w_step-k(5)).^3 + beta(7+7)*abs(w_step-k(6)).^3;

alpha_3 = beta(1+14) + beta(2+14)*w_step + beta(3+14)*abs(w_step-k(2)).^3 + beta(4+14)*abs(w_step-k(3)).^3 +...
    + beta(5+14)*abs(w_step-k(4)).^3 + beta(6+14)*abs(w_step-k(5)).^3 + beta(7+14)*abs(w_step-k(6)).^3;

figure(1);
plot(w_step,alpha_1,'-b',w_step,alpha_2,'--k',w_step,alpha_3,'-.r');
legend('Alpha_1','Alpha_2','Alpha_3')


figure(2);
Nsim = 150;
True_STP = Get_stepresponse(1.5,Nsim);
work_1 = Get_stepresponse(1,Nsim);
work_2 = Get_stepresponse(2.25,Nsim);
work_3 = Get_stepresponse(4,Nsim);
[w_x_1l,w_x_2l,w_x_3l] = Trivial_Interpolation(1.5);
Tri_STP = w_x_1l*work_1 + w_x_2l*work_2 + w_x_3l*work_3;
LPV_STP = alpha_1(51,1)*work_1 + alpha_2(51,1)*work_2 + alpha_3(51,1)*work_3;
plot(0:Nsim,[0;True_STP],'-b',0:Nsim,[0;Tri_STP],'--k',0:Nsim,[0;LPV_STP],'-.r');
legend('Ture','Linear','LPV')
