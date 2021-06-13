%% exemplu PI controller
Hf = tf(2,[10 1],'iodelay',2)
bode(Hf)

PM = 55;
phase_Hf = -180+15+PM
% phase = -110  =>
wc = 0.324;

Ti = 4/wc
mod_Hf_dB = -4.55;
mod_Hf = 10^(mod_Hf_dB/20)
kp = 1/mod_Hf

Hc = kp*tf([Ti 1],[Ti 0]) % the controller 
Hd = Hf*Hc % open loop tf

bode(Hd)

%% PI controller
Hf = tf(2,conv([10 1],[5 1]),'iodelay',3)
bode(Hf)

PM = 50; % phase margin 
phase_Hf = -180+15+PM

wc = 0.143; % from bode where phase is -115 deg
Ti = 4/wc

mod_Hf_dB = -0.66; % from bode where the freq=wc
mod_Hf = 10^(mod_Hf_dB/20) % transformation from dB
kp = 1/mod_Hf

Hc = kp*tf([Ti 1],[Ti 0]) % the controller tf
Hd = Hf*Hc % open loop tf

bode(Hd)

%% exemplu PD controller
close all
clear all
clc
Hf = tf(2,[10 1],'iodelay',2)
bode(Hf)

beta = 0.1;
phase_C = atand((1-beta)/2/sqrt(beta))
PM = 60;
phase_Hf = -180-phase_C+PM

wc = 0.8;

Td = 1/wc/sqrt(beta)
mod_Hf_dB = -12.1; % from bode where the freq=wc
mod_Hf = 10^(mod_Hf_dB/20) % transformation from dB
kp = sqrt(beta)/mod_Hf

Hc = kp*tf([Td 1],[beta*Td 1]) % the controller tf
Hd = Hf*Hc % open loop tf

bode(Hd)


%% PD controller
close all
clear all
clc
Hf = tf(2,conv([10 1],[5 1]),'iodelay',3)
bode(Hf)

PM = 50;
beta = 0.1;
phase_C = atand((1-beta)/2/sqrt(beta))
phase_Hf = -180-phase_C+PM

wc = 0.319;

Td = 1/wc/sqrt(beta)
mod_Hf_dB = -10; % from bode where the freq=wc
mod_Hf = 10^(mod_Hf_dB/20) % transformation from dB
kp = sqrt(beta)/mod_Hf

Hc = kp*tf([Td 1],[beta*Td 1]) % the controller tf
Hd = Hf*Hc % open loop tf

bode(Hd)

%% c)
% the overshoot for PD 
sigma1 = ((1.06- 0.66)/0.66)*100

% the overshoot for PI
sigma2 = (1.15-1)*100

