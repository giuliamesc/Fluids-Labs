%Qualitative assessment of the solution
%pt1
rho=998.23;
ni=1e-6;
d=0.05;

x_tg=650;

tau_vis=rho*ni*DUDY;
tau_turb=rho*ENUT(x_tg,:).*DUDY;
tau_tot=tau_vis+tau_turb;
tau_wall= rho*STRS(x_tg,1);
tau_t=@(y) tau_wall*(1-y/d);

tau_tot_2=tau_t(Y_C); %different form tau_tot!!!! why?
tau_turb_2=tau_tot_2-tau_vis;

figure
plot(Y_C/d, tau_vis(x_tg,:),'m','LineWidth',3)
title('tau_{visc}(y)')
grid on
figure
plot(Y_C/d, tau_turb(x_tg,:),'c','LineWidth',3)
% plot(Y_C/d, tau_turb_2,'c','LineWidth',3)

grid on
title('tau_{turb}(y)')
figure
plot(Y_C, tau_tot(x_tg,:),'LineWidth',3)
hold on
% plot(Y_C, tau_tot_2,'LineWidth',3)
grid on
title('tau_{tot}(y)')
figure
hold on
grid on
plot(Y_C/d, tau_vis(x_tg,:)./tau_wall,'m','LineWidth',3)
plot(Y_C/d, tau_turb(x_tg,:)./tau_wall,'c','LineWidth',3)
% plot(Y_C/d, tau_turb_2/tau_wall,'c','LineWidth',3)
title('Comparison')

%pt2
U0=U1(x_tg,end);
figure
U=U1(x_tg,:)/U0;
plot(Y_C/0.05,U,'r','LineWidth',3)
hold on
grid on
%laminar solution
y=linspace(0,0.05,NY);
d=0.05;
Ub=1;
U00=3/2*Ub;
u_th=@(y) 3/2*Ub*(y/d).*(2-y/d);
plot(y/0.05, u_th(y)/U00','b','LineWidth',3);
