figure
Ub=0.005;
d=0.005;
m=1e-3;
y=linspace(0,0.005,40);
u_th=@(y) 3/2*Ub*(y/d).*(2-y/d);
t_th=@(y) -3/d^2*m*Ub*(d-y);
plot(y,u_th(y),'c','LineWidth',2)
hold on
grid on
plot(y,U1(40,:),'m','LineWidth',2)
legend('Theoretical','Experimental')
title('u(y)')

figure
plot(y,t_th(y),'c','LineWidth',2)
hold on
grid on
plot(y,-m*DUDY(40,:),'m','LineWidth',2)
legend('Theoretical','Experimental')
title('tau_{yx}')
