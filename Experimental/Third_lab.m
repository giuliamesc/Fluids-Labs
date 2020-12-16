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
load('FORCEdata_nowater.mat');
noise1=std(Fx);
noise2=std(Fy);

load('FORCEdata_stillwater.mat');
noise3=std(Fx);
noise4=std(Fy);


%3
load('FORCEdata_flow.mat');
A_ch=h*B;
U_b=0.001*Q/A_ch;
Re=rho*D*U_b/mu;

%4
A=L*D;
Fl=Fy-f_buoyancy;
RA_Fd=mean(Fx);
RA_Fl=mean(Fl);
RA_Cd=RA_Fd/(0.5*rho*U_b^2*A);
RA_Cl=RA_Fl/(0.5*rho*U_b^2*A);

%5
ns=length(Fl);
Fl_fourier=fft(Fl-mean(Fl))/ns;
ff=[0:(ns-1)]/ns*fs;
figure,plot(ff,2*abs(Fl_fourier));
xlim([0 fs/2]);
f=1.006;
St=f*D/U_b;

%6
f_co=2*f;
ny=fs/2;
t=[0:(ns-1)]/fs;
fir=fir1(20000,f_co/ny);
Fl_filt=filtfilt(fir,1,Fl);
figure
plot(t,Fl,'m')
hold on
grid on
plot(t,Fl_filt,'c','LineWidth',2)
legend('Experimental Measures','Filtred')
xlim([40 60])

%7
h_peaks=findpeaks(Fl_filt);
l_peaks=-findpeaks(-Fl_filt);
amplitudes=h_peaks-l_peaks;

al=mean(amplitudes)/2;
cl_prime=al/(0.5*rho*U_b^2*A);

%8
unc_fd=0.045;
unc_fl=sqrt(2)*0.025;

unc_al=sqrt(2)*0.025;

unc_area=sqrt((L*0.1e-3)^2+(D*0.5e-3)^2);
unc_ub=sqrt((0.001/(h*B)*0.01*Q)^2+(0.001*Q/(h*B^2)*0.5e-3)^2+(0.001*Q/(h^2*B)*1e-3)^2);

unc_cd=sqrt((unc_fd*1/(0.5*rho*U_b^2*A))^2+(unc_ub*2*RA_Fd/(0.5*rho*U_b^3*A))^2+(unc_area*RA_Fd/(0.5*rho*A^2*U_b^2))^2);
unc_cl=sqrt((unc_fl*1/(0.5*rho*U_b^2*A))^2+(unc_ub*2*RA_Fl/(0.5*rho*U_b^3*A))^2+(unc_area*RA_Fl/(0.5*rho*A^2*U_b^2))^2);

unc_clpr=sqrt((unc_al*1/(0.5*rho*U_b^2*A))^2+(unc_ub*2*al/(0.5*rho*U_b^3*A))^2+(unc_area*al/(0.5*rho*A^2*U_b^2))^2);

%9
load('FORCEdata_NatOsc_corrected.mat');
fs=200;
ns=length(Fx);
t2=[0:(ns-1)]/fs;
figure
subplot(2,1,1)
plot(t2,Fx)
subplot(2,1,2)
plot(t2,Fy)

Fx_fourier=fft(Fx-mean(Fx))/ns;
ff=[0:(ns-1)]/ns*fs;
figure,plot(ff,2*abs(Fx_fourier));
xlim([0 fs/2]);
f1=7.563;

Fy_fourier=fft(Fy-mean(Fy))/ns;
ff=[0:(ns-1)]/ns*fs;
figure,plot(ff,2*abs(Fy_fourier));
xlim([0 fs/2]);
f2=30.69;

%10
load('FORCEdata_stillwater2.mat');
f_buoyancy2=mean(Fy);

load('FORCEdata_flow2.mat');
Fy_2=Fy-f_buoyancy2;
RA_Fd2=mean(Fx);
RA_Fl2=mean(Fy_2);
RA_Cd2=RA_Fd2/(0.5*rho*U_b^2*A);
RA_Cl2=RA_Fl2/(0.5*rho*U_b^2*A);

%contribution of endplates
Q2=56.3;
U_b2=0.001*Q2/A_ch;

RA_Fd_Ub=RA_Fd2*(U_b/U_b2)^2;
RA_Fl_Ub=RA_Fl2*(U_b/U_b2)^2;

Fym=f_buoyancy;
Sc=rho*9.8*L*pi*(D/2)^2;
Se=Fym-Sc;
Fym2=f_buoyancy2;
weigth=Fym2-Se;

rate_Fd=RA_Fd_Ub/(0.5*rho*A*U_b^2);
rate_Fl=RA_Fl_Ub/(0.5*rho*A*U_b^2);

%11

dh=2e-3;
Ax=(180*2)*1e-6;
dS=2*rho*9.8*dh*Ax;

err_RA_Cl=dS/(0.5*rho*A*U_b^2);
