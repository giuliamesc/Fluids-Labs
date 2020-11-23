% Es 2
for i=1:9:54
x_1=X_C(31:end);
eta_1=i/NY*0.005.*sqrt(U_inf./(ni*x_1));

den=U_inf.*(sqrt(x_1*U_inf/(ni)));
num=V1(31:end,i)';

u_1=U1/U_inf;
v_1=num./den;

figure
plot(eta_1,u_1(31:end,i),'LineWidth',2)
grid on
hold on
plot(eta_1,v_1,'LineWidth',2)
legend('u-velocity','v-velocity')
title('Self-similarity of the empirical solution')
end

f=[0 0.026 0.1655 0.323 0.65 0.992 1.397 1.7469 2.305 2.692 3.283 4.279 5.279];
f_prime=[0 0.133 0.3298 0.4563 0.63 0.7289 0.846 0.9017 0.956 0.9758 0.992 0.998 0.999];
eta=[0 0.4 1 1.4 2 2.4 3 3.4 4 4.4 5 6 7];

figure
plot(eta, f_prime,'LineWidth',2)
grid on
hold on
plot(eta, 0.5*(eta.*f_prime-f),'LineWidth',2)
legend('theoretical u-velocity','theoretical v-velocity')
title('Theoretical Results')

my_x=0.10;
my_eta=Y_C.*sqrt(U_inf./(ni*my_x));

my_u=U1/U_inf;
my_v=V1/U_inf.*(sqrt(my_x*U_inf/(ni)));

figure
plot(my_eta,my_u(220,:),'g','LineWidth',2);
xline(5,'LineWidth',2)
grid on
hold on
plot(my_eta,my_v(220,:), 'y', 'LineWidth',2);
yline(0.8604,'LineWidth',2)
legend('empirical u-velocity','empirical v-velocity')
title('Empirical Results')

figure
plot(eta, f_prime, 'r', 'LineWidth',2)
hold on
grid on
plot(my_eta,my_u(220,:),'m','LineWidth',2);
legend('Blausius','Giulia')
title('Comparison between emprical evidence and Blausius solution')
xlim([0 7])

figure
plot(eta, 0.5*(eta.*f_prime-f), 'r', 'LineWidth',2)
hold on
grid on
plot(my_eta,my_v(220,:),'m','LineWidth',2);
legend('Blausius','Giulia')
title('Comparison between emprical evidence and Blausius solution')
xlim([0 7])

Re=@(x) U_inf*x/ni;
Rex=Re(X_C(31:end));

my_tw=rho*ni*DUDY(31:end,1);

cf_blausius=0.664./sqrt((Rex));
my_cf=my_tw/(0.5*rho*U_inf^2);

figure
plot(Rex,cf_blausius,'LineWidth',2)
hold on
grid on
plot(Rex,my_cf,'LineWidth',2)
legend('Blausius','Giulia')
title('C_{f} profile')

my_x=X_C(31:end);

fun=1-my_u;
fun2=my_u.*(1-my_u);

my_delta=sqrt(ni*my_x/U_inf)./my_x;
my_delta_star=zeros(1,300);
my_theta=zeros(1,300);

for i=31:1:300
my_delta_star(i)=integral(fun(i,:),0,inf)./my_x(i);
my_theta(i)=integral(fun2(i,:),0,inf)./my_x(i);
end

delta_bl=0.370*Rex.^(-1/5);
delta_star_bl=0.463*Rex.^(-1/5);
theta_bl=0.036*Rex.^(-1/5);

figure
plot(Rex,my_delta,'g','LineWidth',2)
hold on
grid on
plot(Rex,delta_bl,'m','LineWidth',2)
legend('Empirical','Blasius')
title('Comparison of Delta')


figure
plot(Rex,my_delta_star,'g','LineWidth',2)
hold on
grid on
plot(Rex,delta_star_bl,'m','LineWidth',2)
legend('Empirical','Blasius')
title('Comparison of Delta Star')

figure
plot(Rex,my_theta,'g','LineWidth',2)
hold on
grid on
plot(Rex,theta_bl,'m','LineWidth',2)
legend('Empirical','Blasius')
title('Comparison of Theta')
