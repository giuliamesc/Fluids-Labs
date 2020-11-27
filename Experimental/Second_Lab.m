%1
D=0.06;
rho=998;
mu=0.001;
Q=35/1000;
B=0.5;
h=0.42;
hb=0.18;
A=B*h;

Ub=Q/A;

Re=rho*Ub*D/mu;

%2
%with Paint I identify the coordinates
x0=464;
y0=286;

%check resolution with Paint, using a selection rectangle
res=3040;
space=0.0075;

%3

x=(Grid_X-x0)/res;
y=(Grid_Y-y0)/res;

x_ad=x/D;
y_ad=y/D;

fs=50;
sh=1/fs;

u=(SX_out/res)/sh;
v=(SY_out/res)/sh;

u_ad=u/Ub;
v_ad=v/Ub;

%4

um=nanmean(u,3);
vm=nanmean(v,3);

u_adm=nanmean(u_ad,3);
v_adm=nanmean(v_ad,3);

figure, quiver(x,y,um,vm)
hold on
circle2(D/2,0,D/2);
set(gca,'Ydir','reverse');
set(gca,'Xdir','reverse');
xlabel('Hz')
ylabel('amplitude')

figure,streamslice(x,y,um,vm)
hold on
circle2(D/2,0,D/2);
set(gca,'Ydir','reverse');
set(gca,'Xdir','reverse');

figure,streamslice(x_ad,y_ad,u_adm,v_adm)
hold on
circle2(1/2,0,1/2);
set(gca,'Ydir','reverse');
set(gca,'Xdir','reverse');
hold off

%%%%%%%

%5
vort=curl(x,y,um,vm);
figure
pcolor(x,y,vort)
shading interp
colormap('spring')
hold on
streamslice(x,y,um,vm)
circle2(D/2,0,D/2);
set(gca,'Ydir','reverse');
set(gca,'Xdir','reverse');

%6
ns=1499;
t=0:1:ns-1;
figure
plot(x(1,:),-um(15,:),'m*-','LineWidth',2)
hold on 
circle2(D/2,0,D/2);
grid on
title('R-A u along y/D=0')

figure
plot(y(:,1),um(:,18),'c*-','LineWidth',2)
grid on
title('R-A u along x/D=0.5')

figure
plot(y_ad(:,1),u_adm(:,10),'y*-','LineWidth',2)
grid on
title('R-A u along x/D=1.5')

%7

vort=curl(x,y,um,vm);
figure
pcolor(x,y,vort)
shading interp
colormap('spring')
hold on
streamline(x,y,um,vm,x,y)
circle2(D/2,0,D/2);
set(gca,'Ydir','reverse');
set(gca,'Xdir','reverse');

mod=um.^2+vm.^2;

%8
v1=v(10,10,:);
v1=squeeze(v1);
figure, plot(v1,'.')
v1i=interp1(t,v1,t,'spline');
hold on, plot(v1i,'m')
V1=fft(v1i)/ns;
ff=[0:(ns-1)]/ns*fs;
figure,plot(ff,2*abs(V1))
xlim([0 fs/2])
f=0.567; %similar to the one calculated with the movie and with the previous plot
fff=17.5/30;
T=1/f;
dt=T/5;
w=15;


uma=nan(size(x));
vma=nan(size(x));

for i=1:w:100
  uma(:,:,i)=nanmean(u(:,:,i:i+w-1),3);
  vma(:,:,i)=nanmean(v(:,:,i+i+w-1),3);
  figure
  hold on,pcolor(x,y,curl(uma(:,:,i),vma(:,:,i)))
  shading interp
  streamslice(x,y,uma(:,:,i),vma(:,:,i))
  circle2(D/2,0,D/2);
  set(gca,'Ydir','reverse');
  set(gca,'Xdir','reverse');
  drawnow
  pause
end


map=colormap(gray(256));
F=im2frame(im_0300,map);

dirname='C:\Users\giuli\OneDrive\Desktop\Fluids Labs\Exp_Lab_2\PSVdata\PSVimages0300_0590 (2)\';
for i=300:590
    imname=['im_0', num2str(i),'.jpg'];
    imm=imread([dirname, imname]);
    F(i-299)=im2frame(imm,map);
end
movie(F,1,10)
