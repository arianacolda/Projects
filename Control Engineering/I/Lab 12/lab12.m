%% Lab 12

G11 = tf(0.4,[3 1]);
G12 = tf(2,[5 1]);
G21 = tf(2.5,[10 1]);
G22 = tf(0.1,[7 1]);

% steady state gains of the process tf matrix
G11_0 = 0.4;
G12_0 = 2;
G21_0 = 2.5;
G22_0 = 0.1;

% decoupler design
D12 = -G12_0/G11_0;
D21 = -G21_0/G22_0;
D11 = 1;
D22 = 1;

% decoupled process tf
Hf1 = zpk(G11*D11+G12*D21)
Hf2 = zpk(G21*D12+G22*D22)

% design of Gc1 based on Hf1 we design based on -Hf1 since hf1 has negative
% gain. controller Gc1 will be implemented with negative gain

Hf1_star = -Hf1
Hf2_star = -Hf2

% Gc1
sigma = 0.1;
ts = 1;

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2));
wn = 4/(ts*zeta);

cv = wn/2/zeta;
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2 + 4*zeta^4));

H01 = tf(wn^2,[1 2*zeta*wn wn^2]) % similar for y2
Gc1 = minreal(1/Hf1_star*H01/(1-H01))
step(H01)

% GC2 

sigma2 = 0.03;
ts2 = 8;

zeta2 = abs(log(sigma2)/sqrt(pi^2+(log(sigma2))^2));
wn2 = 4/(ts2*zeta2);

cv2 = wn2/2/zeta2;
deltawb2 = wn2*sqrt(1-2*zeta2^2+sqrt(2-4*zeta2^2 + 4*zeta2^4));

H02 = tf(wn2^2, [1 2*zeta2*wn2 wn2^2]);
Gc2 = minreal(1/Hf2_star*H02/(1-H02))
figure,step(H02)
