rho=998;
mu=0.001;
D=0.06;
L=0.185;
B=0.5;
hb=0.18;
fs=200;

Q=75;
h=0.42;

%1

load('FORCEdata_nowater.mat');
F_y0=Fy;
Fx_mean0=mean(Fx);
Fy_mean0=mean(Fy); %should be close to zero

load('FORCEdata_stillwater.mat');
Fx_mean=mean(Fx);
Fy_mean=mean(Fy); 

f_buoyancy=mean(Fy);

% load('FORCEdata_flow.mat');
% Fx_mean=mean(Fx);
% Fy_mean=mean(Fy); 

% figure
% plot(Fx)
% plot(Fy) %more oscillations: there is a flow

%2
noise=std(Fy);

%3
load('FORCEdata_flow.mat');
A_ch=h*B;
U_b=0.001*Q/A_ch;
Re=rho*D*U_b/mu;

%4
A=L*D;
RA_Fd=mean(Fx);
RA_Fl=mean(Fy)-f_buoyancy;
RA_Cd=RA_Fd/(0.5*rho*U_b^2*A);
RA_Cl=RA_Fl/(0.5*rho*U_b^2*A);

%5
ns=length(Fy);
Fl_fourier=fft(Fy)/ns;
ff=[0:(ns-1)]/ns*fs;
figure,plot(ff,2*abs(Fl_fourier));
xlim([0 fs/2]);
ylim([0 0.2]);
f=1.006;
St=f*D/U_b;
