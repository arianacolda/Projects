Hf = tf(2,[5 1 0])

delta_sigma = 0.02;
sigma = 0.1 - delta_sigma

zeta = abs(log(sigma)/sqrt(pi^2+(log(sigma))^2))

ts = 6;
wn = 4/(ts*zeta)
deltawb = wn*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2+4*zeta^4))

cv2 = wn/2/zeta
cv_star = 1.6;

pc = delta_sigma/(1/cv2-1/cv_star);
zc = pc/(1+delta_sigma);

H1 = tf([1 zc],[1 pc])
H2 = tf(pc,zc)
H0 = tf(wn^2,[1 2*zeta*wn wn^2])
H0c = H0 * H1 *H2;

zpk(minreal(H0c/Hf/(1-H0c)))

Hr = minreal(H0c/Hf/(1-H0c)) % controller tf

t = 0:0.1:100;
step(H0c)
figure, lsim(H0c,t,t)

Hrsim = 2,88*tf([33,57 1],[56,29 1])
H0_sim=minreal(Hf*Hrsim/(1+Hf*Hrsim))
figure, step(H0_sim)
figure, lsim(H0_sim,t,t)