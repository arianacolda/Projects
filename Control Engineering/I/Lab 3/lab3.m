%% a)
Hf = tf(2,[2 1 0])

sigma = 0.15;
ts = 35;

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))
wn = 4/(ts*zeta)

cv = wn/2/zeta
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2+4*zeta^4))

H0 = tf(wn^2,[1 2*zeta*wn wn^2])

Hc = minreal(H0/Hf/(1-H0))

step(H0)
t = 0:0.1:50;
figure, lsim(H0,t,t)
figure, bode(H0)

%% b)
Hf = tf(2,[2 1 0])

sigma = 0.15;
ts = 6;

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2)) 
wn = 4/(ts*zeta)  

cv = wn/2/zeta
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2+4*zeta^4))

H0 = tf(wn^2,[1 2*zeta*wn wn^2])

Hc = minreal(H0/Hf/(1-H0))

step(H0)
t = 0:0.1:10;
figure, lsim(H0,t,t)
figure, bode(H0)

%% c)
Hf = tf(2,[2 1 0])

sigma = 0.1;
ts = 2;

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2)) % zeta=0.516;
wn = 4/(ts*zeta) 

cv = wn/2/zeta
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2+4*zeta^4))

H0 = tf(wn^2,[1 2*zeta*wn wn^2])

Hc = minreal(H0/Hf/(1-H0))

step(H0)
t = 0:0.1:8;
figure, lsim(H0,t,t)
figure, bode(H0)
