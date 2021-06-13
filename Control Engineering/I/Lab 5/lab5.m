%% a) P controller

Hf = tf(3.5,[0.5 1 0]);
bodemag(Hf), hold on

wf = 1/0.5;
sigma = 0.15;
zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))
A = 1/4/sqrt(2)/zeta^2
Adb = 20*log10(A)
A = tf(A,1);
bodemag(A)

FN = -Adb+1.94
Vr = 10^(-FN/20)

Hd = Hf*Vr
bodemag(Hd)


wt = 1.5;
wn = 2*zeta*wt;
ts = 4/zeta/wn

cvdB = 4.39;   cv = 10^(4.39/20)

deltawb = wt

H0 = feedback(Hf*Vr,1)
figure, step(H0)
t = 0:0.1:20
figure, lsim(H0,t,t)

%% b) P controller

Hf = tf(3.5,[0.5 1 0]);
bodemag(Hf), hold on

wf = 1/0.5;
sigma = 0.07;
zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))
A = 1/4/sqrt(2)/zeta^2
Adb = 20*log10(A)
A = tf(A,1);
bodemag(A)

FN = -Adb+1.94
Vr = 10^(-FN/20)

Hd = Hf*Vr
bodemag(Hd)


wt = 1.05;
wn = 2*zeta*wt;
ts = 4/zeta/wn

cvdB = 0.49;   cv = 10^(0.49/20)

deltawb = wt

H0 = feedback(Hf*Vr,1)
figure, step(H0)
t = 0:0.1:20
figure, lsim(H0,t,t)

%% b) PI controller

Hf = tf(3.5,[0.5 1 0]);
bodemag(Hf), hold on

wf = 1/0.5;
sigma = 0.07;
zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))
A = 1/4/sqrt(2)/zeta^2
Adb = 20*log10(A)
A = tf(A,1);
bodemag(A)

FN = -Adb+1.94
Vr = 10^(-FN/20)

Hd = Hf*Vr
bodemag(Hd)

wt = 1.05;
wn = 2*zeta*wt;
ts = 4/zeta/wn

cvdB = 0.49;   cv = 10^(0.49/20)

deltawb = wt

cvstar = 5;
wz = 0.1*wt;
wp = cv/cvstar*wz;
Tz = 1/wz;
Tp = 1/wp;
VrPI = cvstar/cv

HPI = VrPI*tf([Tz 1],[Tp 1]);
cvnew = VrPI*3.5*Vr
Hd_PI = Hf*Vr*HPI
bode(Hd_PI)

H0 = feedback(Vr*HPI*Hf,1)
figure, step(H0)
t = 0:0.1:80
figure, lsim(H0,t,t)



