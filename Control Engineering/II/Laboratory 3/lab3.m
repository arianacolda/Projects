%% Level control in water tank
%% Task 1

load('exp_level.mat');
plot(t,y_exp,'r*');
y = y_exp-51.7;
figure, plot(t,y,'b*'), title("Normalized experimental data"), hold;

u1 = 0.2;
tsat = 50;
ysat = 9.5;
t1 = 0;
y1 = 0;
T = u1*(tsat - t1)/(ysat - y1)

Hf = tf(1,[T 0])

opt = stepDataOptions;
opt.StepAmplitude = 0.2;
step(Hf, opt)

%% Task 2
% P controller
u2 = 10;
ts = 200;
% first order system => ts=4T
Tf = 50;
H0 = tf(1,[Tf 1]);

Hc_P = minreal((1/Hf) * (H0 / (1 - H0)));
Hd_P = Hc_P * Hf; % open loop tf
H0_P = feedback(Hd_P,1); % closed loop tf
step(H0_P);

%% Task 3
% PI controller
kp = 11.583;
Ti = 0.36;

Hc_PI = kp*tf([Ti 1],[Ti 0])

Hd_PI = Hc_PI*Hf;
H0_PI = feedback(Hd_PI,1);

% discretization
Ts = 0.036;
Hc_PI_d = c2d(Hc_PI,Ts,'zoh')


