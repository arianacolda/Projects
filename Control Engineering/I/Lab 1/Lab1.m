%% ex2
Hf=tf([5],[2 1]);
Hr=1;

Ho=(Hf*Hr)/(1+Hf*Hr);

%% position
step(Ho);

%% Velocity
t=0:0.01:100;

figure;
lsim(Ho, t, t);

%% acceleration
figure;
lsim(Ho, t.^2./2, t);
