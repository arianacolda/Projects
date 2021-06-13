%% VTOL
%% identification

load('exp_vtol.mat');
plot(t,y);
y2 = y+26;
figure, plot(t,y2,'r'), hold;
Hf = tf(22.24,[1 0.6934 5.244],'iodelay', 0.8);
step(Hf*6.3,t)
legend('Normalized data','Experimental data');

%% controller

tau = 0.8;
tdelay = tf([-tau/2,1],[tau/2,1]);
P = tf(22.24,[1 0.6934 5.244]) * tdelay;

% good and bad part
Pb = tf([-0.4,1],1); 
Pg = P/Pb;

Pg_inv = 1/Pg;

% the filter
lambda = 0.65;
F = tf(1,[lambda^3 3*(lambda^2) 3*lambda 1]);
C = F * Pg_inv;

% the controller
R = minreal(zpk((Pg_inv*F)/(1-Pb*F)))

% the closed loop
H0 = feedback(R*Hf,1)
step(20*H0)

% discretization
R_discret = c2d(R,0.005,'zoh')

[num1,den1] = tfdata(R_discret,'v')
[num2,den2] = tfdata(R,'v')
[num3,den3] = tfdata(Hf,'v')
