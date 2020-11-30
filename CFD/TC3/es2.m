% Es 2
for i=1:9:54
x_1=X_C(31:end)-0.01;
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

x_adj=X_C(31:end)-0.01;
my_eta=sqrt(U_inf./(ni.*x_adj))'*Y_C;

my_u=U1/U_inf;
my_v=V1(n+30,:)/U_inf*(sqrt(x_adj(n)*U_inf/ni));

n=100;

figure
plot(my_eta(n,:),my_u(30+n,:),'g','LineWidth',2);
grid on
hold on
plot(my_eta(n,:),my_v, 'y', 'LineWidth',2);
yline(0.8604,'LineWidth',2)
xline(5,'LineWidth',2)
legend('empirical u-velocity','empirical v-velocity')
title('Empirical Results at x=0.14')

figure
plot(eta, f_prime, 'r', 'LineWidth',2)
hold on
grid on
plot(my_eta(n,:),my_u(30+n,:),'m','LineWidth',2);
legend('Blausius','My solution')
title('Comparison between emprical evidence and Blausius solution')
xlim([0 7])

figure
plot(eta, 0.5*(eta.*f_prime-f), 'r', 'LineWidth',2)
hold on
grid on
plot(my_eta(n,:),my_v,'m','LineWidth',2);
legend('Blausius','My solution')
title('Comparison between emprical evidence and Blausius solution')
xlim([0 7])

Re=@(x) U_inf*x/ni;
Rex=Re(X_C(31:end)-0.01);

my_tw=rho*ni*DUDY(31:end,1);

cf_blausius=0.664./sqrt((Rex));
my_cf=my_tw/(0.5*rho*U_inf^2);

figure
plot(Rex,cf_blausius,'LineWidth',2)
hold on
grid on
plot(Rex,my_cf,'LineWidth',2)
legend('Blausius','My solution')
title('C_{f} profile')

my_x=X_C(31:end)-0.01;


my_delta=ones(1,300);

for i=1:300
    for j=1:54
        if(my_u(30+i,j)>=0.99) 
            my_delta(i)=Y_C(j)./x_adj(i);
            break;
        else
            continue;
        end
    end
end

my_delta_star=zeros(1,300);
my_theta=zeros(1,300);

h=[Y_C(1) diff(Y_C)];

for i=31:1:300
    for j=1:54 
    my_delta_star(i)=my_delta_star(i)+h(j)*(1-my_u(30+i,j));
    my_theta(i)=my_theta(i)+h(j)*(1-my_u(30+i,j))*my_u(30+i,j);
    end
end

my_delta_star=my_delta_star./x_adj;
my_theta=my_theta./x_adj;

delta_bl=5*Rex.^(-1/2);
delta_star_bl=1.7208*Rex.^(-1/2);
theta_bl=0.664*Rex.^(-1/2);

figure
plot(Rex,my_delta,'g','LineWidth',2)
hold on
grid on
plot(Rex,delta_bl,'m','LineWidth',2)
legend('Empirical','Blasius')
title('Comparison of Delta')
ylim([0 0.4])


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
