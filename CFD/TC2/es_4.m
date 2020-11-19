%es 4

%part 1
ni=1e-6;
d=0.05;
Re=55000;
K=0.41;
E=8.6;


Ub=ni*Re/(2*d);

x_tg=650;
u_tau=sqrt(STRS(x_tg,1));
U=U1(x_tg,:)./u_tau;

U0=U1(x_tg,end);
c_f_exp=2*u_tau.^2./(U0^2);
Re=2*0.05*1/ni;
B=5.2;
B1=0.5;
tosolve=@(x) (sqrt(2/x)-1/K*log(Re*(sqrt(8/x)-4.8).^(-1))-B-B1);
exact_sol=fzero(tosolve, c_f_exp);
residual=abs(sqrt(2/c_f_exp)-1/K*log(Re*(sqrt(8/c_f_exp)-4.8).^(-1))-B-B1);

%part 2
delta_ni=ni./u_tau;
y_plus=Y_C/delta_ni;

