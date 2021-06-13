%% Servo System

load('servo_chstat.mat');

%% identification servo motor
close all
load servo_chstat
sim('Servo_model_ident') % it runs with a fixed step size of 0.002s
figure(1), plot(y(:,1),y(:,2)), hold on
figure(1), plot(y(10/0.002:end,1),y(10/0.002:end,2), 'r--')
%normalize data to make it simpler for identification and shift the signal
%to start from 0
t=0:0.002:10+0.002;
y_exp=y(10/0.002:end,2)-y(10/0.002,2);
figure(2), plot(t,y_exp), hold on

ts = 6;
T = 1
k = 200;
H = tf(k,[T 1])
y_id = 0.05*step(t,H)
plot(t,y_id)

%% model validation

input_change=0.07 % run the file with 0.07, validate the transfer function,then check for -0.05

sim('Servo_model_validate') % it runs with a fixed step size of 0.002s
figure(3), plot(y(:,1),y(:,2)), hold on
figure(3), plot(y(10/0.002:end,1),y(10/0.002:end,2), 'r--')

t=0:0.002:10+0.002;
y_exp=y(10/0.002:end,2)-y(10/0.002,2);
figure(4), plot(t,y_exp), hold on

H=tf(k,[T 1]);
ysim=input_change*step(t,H)
figure(4), plot(t,ysim,'k--')

%% controller

ts_g = 1.5;
sigma = 0.05;

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2)) 
wn = 4/(ts_g*zeta)

cv = wn/2/zeta % velocity coefficient
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2+4*zeta^4)) 

% the closed loop trasfer function
H0 = tf(wn^2,[1 2*zeta*wn wn^2])

% the controller transfer function
Hc = zpk(minreal(H0/H/(1-H0)))

% discretization
Ts = 0.002;
Hc_discret = c2d(Hc,Ts,'zoh')

[num, den] = tfdata(Hc_discret, 'v')

