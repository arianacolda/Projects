%% PI ctrl

Hf = tf(2, [10 11 1], 'IODelay', 1);
bode(Hf)

PM = 60;
% read from bode where the phase is -180+15+60 => 105 deg
wc = 0.299
Ti = 4/wc
mod_Hf_dB = -4.32;
mod_Hf = 10^(mod_Hf_dB/20)
kp = 1/mod_Hf

Hc = tf(kp*[Ti 1],[Ti 0])
bode(Hc*Hf)


%% PD ctrl

Hf = tf(2, [10 11 1], 'IODelay', 1);
bode(Hf)

beta = 0.1;
phase_C = atand((1-beta)/2/sqrt(beta))
PM = 60;
phase_Hf = -180-phase_C+PM

% read from bode where the phase is -174.9

wc = 0.88;
Td = 1/wc/sqrt(beta)
mod_Hf_dB_PD = -15.5; % from bode where the freq=wc
mod_Hf_PD = 10^(mod_Hf_dB_PD/20)
kp_PD = sqrt(beta)/mod_Hf_PD

Hc_PD = kp_PD*tf([Td 1],[beta*Td 1]) % the controller tf
Hd = Hf*Hc_PD % open loop tf

bode(Hd)

Ts =  0.1 
Hc_PD_d = c2d(Hc_PD, Ts, 'zoh')

Hc_PD_d = c2d(Hc_PD, 0.01, 'zoh')
