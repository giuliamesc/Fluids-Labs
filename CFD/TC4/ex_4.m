Dati=readtable('forces.csv');

P_avg=mean(P1(:,:,25:end),3);
U1_avg=mean(U1(:,:,25:end),3);
V1_avg=mean(V1(:,:,25:end),3);

%1+6
D=0.06;
H=1;
rho=998.23;
U_inf=0.4;
FX=Dati.FX;
FY=Dati.FY;
t=Dati.TIME;

figure
title('Drag force')
plot(t,FX)
grid on

figure
title('Lift force')
plot(t,FY)
grid on

Cd=(FX/H)/(0.5*rho*U_inf^2*D);
Cd_avg=mean(Cd);

sep_angle= 1.378813; %from the Phoenics plot
sep_angle_deg=sep_angle*180/pi;

[peaks, positions]=findpeaks(FX);

positions=t(positions);

period=mean(diff(positions));

f=1/period;

St=f*D/U_inf; %like the one predicted by theory

%3
p_th=0.5*rho*U_inf^2*(1-4*sin(X_C).^2);

figure
plot(X_C, P_avg(:,2),'m','LineWidth',2)
hold on
grid on
plot(X_C, p_th, 'g','LineWidth',2)
xline(sep_angle)
legend('Experimental','Potential flow solution')
xlim([0 pi])

%4
p_wall=P_avg(:,2);

%SISTEMARE T_WALL

s_angle=X_C(40);
s_angle_deg=s_angle*180/pi;

%5
Cd=(FX/H)/(0.5*rho*U_inf^2*D);
Cl=(FY/H)/(0.5*rho*U_inf^2*D);

figure
plot(t,Cd,'c','LineWidth',2)
hold on
[peaks_d, pos_d]=findpeaks(Cd);
grid on
plot(t,Cl,'y','LineWidth',2)
[peaks_l, pos_l]=findpeaks(Cl);
plot(t(pos_d),peaks_d,'r*')
plot(t(pos_l),peaks_l,'k*')
legend('Cd','Cl')
%we see that the lift force has 2*frequence of the drag: OK
%difference of phase: 0.12-0.16 radiants

Cd_avg=mean(Cd);
Cl_avg=mean(Cl);

%7

figure
subplot(2,2,1)

y=Y_C(2:end);

U_th=U_inf*(1+(D^2./(4*y.^2))).*sin(pi);

plot(y, U1_avg(90,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, U_th,'b','LineWidth',2)
legend('Experimental','Potential')

subplot(2,2,2)

y=Y_C(2:end);

U_th=U_inf*(1+(D^2./(4*y.^2))).*sin(0);

plot(y, U1_avg(1,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, U_th,'b','LineWidth',2)
legend('Experimental','Potential')

subplot(2,2,3)

y=Y_C(2:end);

U_th=U_inf*(1+(D^2./(4*y.^2))).*sin(pi/2);

plot(y, U1_avg(45,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, U_th,'b','LineWidth',2)
legend('Experimental','Potential')

subplot(2,2,4)
y=Y_C(2:end);

U_th=U_inf*(1+(D^2./(4*y.^2))).*sin(3*pi/2);

plot(y, U1_avg(135,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, U_th,'b','LineWidth',2)
legend('Experimental','Potential')

%%%%%%

figure
subplot(2,2,1)

y=Y_C(2:end);

V_th=-U_inf*(1-(D^2./(4*y.^2))).*cos(pi);

plot(y, V1_avg(90,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, V_th,'b','LineWidth',2)
legend('Experimental','Potential')

subplot(2,2,2)

y=Y_C(2:end);

V_th=-U_inf*(1-(D^2./(4*y.^2))).*cos(0);

plot(y, V1_avg(1,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, V_th,'b','LineWidth',2)
legend('Experimental','Potential')

subplot(2,2,3)

y=Y_C(2:end);

V_th=-U_inf*(1-(D^2./(4*y.^2))).*cos(pi/2);

plot(y, V1_avg(45,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, V_th,'b','LineWidth',2)
legend('Experimental','Potential')

subplot(2,2,4)
y=Y_C(2:end);

V_th=-U_inf*(1-(D^2./(4*y.^2))).*cos(3*pi/2);

plot(y, V1_avg(135,2:end),'r','LineWidth',2)
grid on
hold on
plot(y, V_th,'b','LineWidth',2)
legend('Experimental','Potential')
