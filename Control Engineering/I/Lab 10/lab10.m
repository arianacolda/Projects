%% ZN methods
%% 
% process ( we do not know its model)
Hf = tf(2,conv([10 1],[5 1]),'iodelay',3)

%%  ZN open looop method
step(Hf), hold on
% from the step response with the tangent
Tm = 5;
T = 55/4;
k = 2/1;
Hm = tf(k,[T 1],'iodelay',Tm)
step(Hm), hold off

% P
kp_P = T/(k*Tm)
Hc_P = kp_P
H0_P = feedback(Hc_P*Hf,1)
step(H0_P), hold on

% PI
kp_PI = (0.9*T)/(k*Tm)
Ti_PI = 3.3*Tm
Hc_PI = kp_PI*tf([Ti_PI 1],[Ti_PI 0])
H0_PI = feedback(Hc_PI*Hf,1)
step(H0_PI), hold on

% PID
kp_PID = (1.2*T)/(k*Tm)
Ti_PID = 2*Tm
Td_PID = 0.5*Tm
Hc_PID = kp_PID*tf([Ti_PID*Td_PID Ti_PID 1],[Ti_PID 0])
H0_PID = feedback(Hc_PID*Hf,1)
step(H0_PID), hold on

%% ZN closed loop method
Tcr = 20.9 % 75.6-54.7 
kcr = 2.87

% P
kp_P = 0.5*kcr
Hc_P = kp_P
H0_P = feedback(Hc_P*Hf,1)
step(H0_P), hold on

% PI
kp_PI = 0.45*kcr
Ti_PI = Tcr/1.2
Hc_PI = kp_PI*tf([Ti_PI 1],[Ti_PI 0])
H0_PI = feedback(Hc_PI*Hf,1)
step(H0_PI), hold on

% PID
kp_PID = 0.6*kcr
Ti_PID = Tcr/2
Td_PID = Tcr/8
Hc_PID = kp_PID*tf([Ti_PID*Td_PID Ti_PID 1],[Ti_PID 0])
H0_PID = feedback(Hc_PID*Hf,1)
step(H0_PID), hold on

