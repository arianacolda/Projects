%% a) PD controller

Hf = tf(3.5,[0.5 1 0]);
bodemag(Hf), hold on

wf = 1/0.5;
sigma = 0.1;
zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))
A = 1/4/sqrt(2)/zeta^2
Adb = 20*log10(A)
A = tf(A,1);
bodemag(A)

FN = -Adb+1.84
Vr = 10^(-FN/20)

Hd = Hf*Vr
bodemag(Hd)

wt = 1.23;
wn = 2*zeta*wt;
ts = 4/zeta/wn

cvdB = 2.15;   cv = 10^(cvdB/20)

deltawb = wt


ts_star = 3;

wt1 = wt;
wt2 = wt1*ts/ts_star

tau_d = 0.5;
Tn = tau_d*ts_star/ts

Vr_PD = wt2/wt1
Hr_PD = Vr_PD*tf([tau_d 1],[Tn 1])
Hd2 = minreal(Hf*Vr*Hr_PD)
bodemag(Hd2)

cv_PD_dB = 6.58; cv_PD = 10^(cv_PD_dB/20)

deltawb_PD = wt2;

H0 = minreal(feedback(Vr*Hr_PD*Hf,1))
figure, step(H0)
t = 0:0.1:80;
figure, lsim(H0,t,t)


%% b) PID controller

Hf = tf(3.5,[0.5 1 0]);
bodemag(Hf), hold on

wf = 1/0.5;
sigma = 0.05;
zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))
A = 1/4/sqrt(2)/zeta^2
Adb = 20*log10(A)
A = tf(A,1);
bodemag(A)

FN = -Adb+1.84
Vr = 10^(-FN/20)

Hd = Hf*Vr
bodemag(Hd)

wt = 0.95;  %% from Hd(s) 
wn = 2*zeta*wt;
ts = 4/zeta/wn

cv = 2.1023/2; % from the analytic computation
cvdB = 0.3; % from bode with asymptotes

cv = 10^(cvdB/20) %% read from Hd(s) at w=1

deltawb = wt
 
% PD ctrl
ts_star = 0.8; % 0.8
 
wt1 = wt;
wt2 = wt1*ts/ts_star

tau_d = 0.5;
Tn = tau_d*ts_star/ts

Vr_PD = wt2/wt1
Hr_PD = Vr_PD*tf([tau_d 1],[Tn 1])
Hd2 = minreal(Hf*Vr*Hr_PD) % Hd_PD
bodemag(Hd2)

cv_PD = 64.189/11.05; % computation

cv_PD_dB = 15.2; cv_PD = 10^(cv_PD_dB/20) % from Bode

deltawb_PD = wt2;

% PI ctrl
cv_star = 7;
wz = 0.1*wt2;
wp = cv_PD/cv_star*wz;
Tz = 1/wz;
Tp = 1/wp;

Vr_PI = cv_star/cv_PD;

H_PI = Vr_PI*tf([Tz 1],[Tp 1]) %PI tf
Hd_PID = minreal(Vr*Hr_PD*H_PI*Hf) % open loop tf with all 3 controllers

cv_PID = (64.189*0.5249)/(11.05*0.335) % cv = lim(s*Hd_PID) when s->0
% cv_PID =9.10

bodemag(Hd_PID);

H0 = feedback(Hd_PID,1)
figure, step(H0)
t = 0:0.1:100;
figure, lsim(H0,t,t)




