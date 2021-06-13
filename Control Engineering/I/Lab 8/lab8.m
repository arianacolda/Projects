%% magnitude optimum criterion and symmetrical optimum
%% a
close all
clear all
clc

Hf = tf(2,[1 1])
Tsigma = 1;

% modulus
Hdm = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm = minreal(Hdm/Hf) 
Hcm = zpk(Hcm)

H0m = minreal(feedback(Hf*Hcm,1))
H0m = minreal(Hdm/(1+Hdm))

figure, step(H0m)
t = 0:0.1:10;
figure, lsim(H0m,t,t)

% symmetrical
Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs = zpk(minreal(Hds/Hf)) % I in series with a PI
H0s = minreal(feedback(Hf*Hcs,1))
H0s = minreal(Hds/(1+Hds))

figure, step(H0s)
t = 0:0.1:30;
figure, lsim(H0s,t,t)

%% b
close all
clear all
clc

Hf = tf(2,[1 1 0])
Tsigma = 1;

% modulus
Hdm = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm = minreal(Hdm/Hf) % P controller
Hcm = zpk(Hcm)

H0m = minreal(feedback(Hf*Hcm,1))
H0m = minreal(Hdm/(1+Hdm))

figure, step(H0m)
t = 0:0.1:10;
figure, lsim(H0m,t,t)

% symmetrical
Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs = zpk(minreal(Hds/Hf)) % PI controller
H0s = minreal(feedback(Hf*Hcs,1))
H0s = minreal(Hds/(1+Hds))

figure, step(H0s)
t = 0:0.1:30;
figure, lsim(H0s,t,t)

%% c
close all
clear all
clc

Hf = tf(2,conv([1 1],[10 1]))
Tsigma = 1;

% modulus
Hdm = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm = minreal(Hdm/Hf) % PI controller
Hcm = zpk(Hcm)

H0m = minreal(feedback(Hf*Hcm,1))
H0m = minreal(Hdm/(1+Hdm))

figure, step(H0m)
t = 0:0.1:10;
figure, lsim(H0m,t,t)

% symmetrical
Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs = zpk(minreal(Hds/Hf)) % PI in series with a PI controller
H0s = minreal(feedback(Hf*Hcs,1))
H0s = minreal(Hds/(1+Hds))

figure, step(H0s)
t = 0:0.1:30;
figure, lsim(H0s,t,t)
%% d
close all
clear all
clc

Hf = tf(2,conv([1 1 0],[10 1]))
Tsigma = 1;

% modulus
Hdm = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm = minreal(Hdm/Hf) % ideal PD controller can t be implemented
Hcm = zpk(Hcm)
Hcm_real = Hcm* tf(1,[0.1 1]); % 0.02 filter


H0m = minreal(feedback(Hf*Hcm_real,1))
%H0m = minreal(Hdm/(1+Hdm))

% bode(tf(0.25*[10 1],[1]))

figure, step(H0m)
t = 0:0.1:10;
figure, lsim(H0m,t,t)

% symmetrical
Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs = zpk(minreal(Hds/Hf)) % P
H0s = minreal(feedback(Hf*Hcs,1))
H0s = minreal(Hds/(1+Hds))

figure, step(H0s)
t = 0:0.1:30;
figure, lsim(H0s,t,t)
%% e
close all
clear all
clc

Hf = tf(2,conv([1 1],conv([10 1],[20 1])))
Tsigma = 1;

% modulus
Hdm = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm = minreal(Hdm/Hf) % PID controller
Hcm = zpk(Hcm)

H0m = minreal(feedback(Hf*Hcm,1))
H0m = minreal(Hdm/(1+Hdm))

figure, step(H0m)
t = 0:0.1:10;
figure, lsim(H0m,t,t)

% symmetrical
Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs = zpk(minreal(Hds/Hf)) % PID in series with a PI controller
H0s = minreal(feedback(Hf*Hcs,1))
%H0s = minreal(Hds/(1+Hds))

figure, step(H0s)
t = 0:0.1:30;
figure, lsim(H0s,t,t)

%% f
close all
clear all
clc

Hf = tf(2,conv([1 1 0],conv([10 1],[20 1])))
Tsigma = 1;

% modulus
Hdm = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm = minreal(Hdm/Hf) % 2 ideal PD controllers in series
Hcm = zpk(Hcm)

Hcm_real=Hcm*tf(1,[0.1 1])*tf(1,[0.1 1])

H0m = minreal(feedback(Hf*Hcm,1))
H0m = minreal(Hdm/(1+Hdm))

figure, step(H0m)
t = 0:0.1:10;
figure, lsim(H0m,t,t)

% symmetrical
Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs = zpk(minreal(Hds/Hf)) % PID controller with a filter
Hcs_real = Hcs*tf(1, [0.05 1])

H0s = minreal(feedback(Hf*Hcs_real,1))
%H0s = minreal(Hds/(1+Hds))
% (4s+1)(10s+1)(20s+1)/16s 
% (24s+1)(10s+1)/16s - PID
% (4s+1)(10s+1)/16s - PID in series with a PD (20s+1)/(0.1s+1)

figure, step(H0s)
t = 0:0.1:30;
figure, lsim(H0s,t,t)
