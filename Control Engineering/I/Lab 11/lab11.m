%% 
G = [0.4 2; 2.5 0.1]
x = G.*inv(G)'
y = rga(G)

%     u1         u2
%y1 -0.0081   1.0081
%
%y2 1.0081    -0.0081

% because of the minus signs we have the following parings: y1-u2
G12 = tf(2,[5 1]) % ->>> Gc1 (5%, ts=3s) GT

% => y2-u1
G21 = tf(2.5,[10 1]) % ->>> Gc2 ( 5%, ts =15s)

% overshoot - zeta = ?
% ts - wn = ?

% Gc1 using GT method:
sigma = 0.1;
ts = 3;

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2));
wn = 4/(ts*zeta);

cv = wn/2/zeta;
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2 + 4*zeta^4));

H01 = tf(wn^2,[1 2*zeta*wn wn^2]) % similar for y2
Gc1 = minreal(1/G12*H01/(1-H01))
step(H01)

% GC2 using GT 

sigma2 = 0.05;
ts2 = 14;

zeta2 = abs(log(sigma2)/sqrt(pi^2+(log(sigma2))^2));
wn2 = 4/(ts2*zeta2);

cv2 = wn2/2/zeta2;
deltawb2 = wn2*sqrt(1-2*zeta2^2+sqrt(2-4*zeta2^2 + 4*zeta2^4));

H02 = tf(wn2^2, [1 2*zeta2*wn2 wn2^2]);
Gc2 = minreal(1/G21*H02/(1-H02))
figure,step(H02)

