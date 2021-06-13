%% Kalman

Hf = tf([1],[3.34 1],'iodelay',1.86);

Ts = 1;
Hf_discrete = c2d(Hf,Ts,'zoh')

%% Dahlin

Hfd = tf([0.2],conv([50 1],[3 1]),'iodelay',2);

Ts = 1;
Hfd_discrete = c2d(Hfd,Ts,'zoh')
