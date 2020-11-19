%Suitability of the CFD model

%es2
figure
plot(X_E,VOR1(:,3))
title('Vorticity')
grid on
figure
plot(Y_N,U1(130,:),'m')
title('U(y)')
grid on