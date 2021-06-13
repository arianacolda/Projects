%% Cascade Control
%% 
close all
clear all
clc

Hf2 = tf(8.6,conv([0.01 1],[0.6 1]));
Tsigma = 0.01;

% for the inner loop
% modulus
Hdm2 = tf(1,conv([2*Tsigma 0 ],[Tsigma 1]))
Hcm2 = minreal(Hdm2/Hf2) 
Hcm2 = zpk(Hcm2) % PI controller


H0m2 = zpk(minreal(feedback(Hf2*Hcm2,1)))
%H0m = minreal(Hdm/(1+Hdm))

figure, step(H0m2)
t = 0:0.1:10;
figure, lsim(H0m2,t,t)


% for the outer loop
Hf1 = tf(2.4,conv([0.5 1],[50 1]))
H0 = tf(1,[0.02 1])
Hf = zpk(Hf1*H0)

Hf_sim = zpk(tf(2.4,conv([0.5+0.02 1],[50 1])))
Tsigma = 0.52;

% symmetrical
Hds1 = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs1 = zpk(minreal(Hds1/Hf)) 

Hr1 = minreal(Hds1/Hf_sim)

H0s1 = minreal(feedback(Hf*Hcs1,1))
% H0s1 = minreal(Hds1/(1+Hds1))

figure, step(H0s1)
t = 0:0.1:30;
figure, lsim(H0s1,t,t)

%% classical negative feedback
% 9.2 
%Hf = Hf1*Hf2;
Hf = tf(2.4*8.6,conv([1.11 1],[50 1]))
Tsigma = 1.11;

Hds = tf([4*Tsigma 1],conv([8*Tsigma^2 0 0],[Tsigma 1]))
Hcs= zpk(minreal(Hds/Hf)) 


