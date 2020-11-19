%Lab 01
clear all 
close all
clc

%1
N=length(V);
t=linspace(0,N,N);
figure
plot(t,V)
title('Voltage vs Time')
hold on
grid on
V_new=sum(V)/N

%2
F=[0,-32,-41.9,-70.9,-90.9,-120.9,-170.9,-270.9,-570.9,-1070.9,12.9,111.9,211.9,411.9,911.9,1411.9]/1000;
X=[-2.72231399658413e-05,0.000100843879465908,0.000136267348650837,0.000248955271896320,0.000334117541683836,0.000455141343295293,0.000656249447185453,0.00105394993579759,0.00225210429233543,0.00425387265017792,-7.81791493779250e-05,-0.000475867746644691,-0.000874618849802820,-0.00167709621908665,-0.00367769193440229,-0.00567118614360631]';
b = polyfit(X,F,1);
figure
plot(X,F,'ko')
hold on 
grid on
y=@(x) b*x;
plot(X,y(X),'LineWidth',2)

%3
b=-249836.574546392;
F_new=b*V;
N=length(V);
t=linspace(0,N,N);
figure
plot(t,F_new)
title('Force vs Time')
hold on
grid on

%4
F=[0,-32,-41.9,-70.9,-90.9,-120.9,-170.9,-270.9,-570.9,-1070.9,12.9,111.9,211.9,411.9,911.9,1411.9]';
X=[-2.72231399658413e-05,0.000100843879465908,0.000136267348650837,0.000248955271896320,0.000334117541683836,0.000455141343295293,0.000656249447185453,0.00105394993579759,0.00225210429233543,0.00425387265017792,-7.81791493779250e-05,-0.000475867746644691,-0.000874618849802820,-0.00167709621908665,-0.00367769193440229,-0.00567118614360631]';
[b,s] = polyfit(X,F,1);
F_reg=b(1)*X+b(2);
residuals=F-F_reg;
ms_error=sum(residuals.^2)/16;
max_abs_error=max(abs(residuals));

%5
m=mean(residuals);
sigma=std(residuals);
max_99_percent=3*sigma;

%6
X=[-7.7163e-05, -7.6422e-05, -7.8454e-05, -7.7748e-05, -7.8330e-05, -8.0294e-05, -7.9772e-05, -7.9045e-05, -7.9029e-05, -7.8253e-05]';
F_real=12.9/100*ones(10,1);
b=[-250126.547182546,-7.23554936991316]/100;
F_ext=b(1)*X+b(2);
residuals=F_real-F_ext;
ms_error=sum(residuals.^2)/10;
max_abs_error=max(abs(residuals));
sigma=std(residuals);
m=mean(residuals);
max_99_percent=3*sigma;

%7
intr_noise=std(V);
noise=std(residuals);

%8
fs=100;
ns=numel(V);
t=[0:1:(ns-1)]/fs;
figure
plot(t,V,'.')
diff(unique(V));

%9
n=numel(V);
F=-270.9/100;
F_inst=b(1)*V+b(2);
F_cum=zeros(n,1);
F_cum_mean=zeros(n,1);
for i=1:n
    F_cum(i)=sum(F_inst(1:i));
    F_cum_mean(i)=F_cum(i)/i;
end
figure
plot([1:n],F_cum_mean, 'm*','LineWidth',0.5)
grid on
hold on
title('Cumulative Mean Force vs Time')

figure
plot([1:n],F_inst, 'c*','LineWidth',0.5)
grid on
hold on
title('Instantaneous Force vs Time')
