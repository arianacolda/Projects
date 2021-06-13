%% a
Hr = 2;
Hf = tf(1,[2 1]); %1/2s+1

Hd = Hf * Hr;
Ho = Hf*Hr/(1+Hf*Hr)

step(Ho)

t=0:0.1:10;
lsim(Ho,t,t)

%% b
Hr = tf(2,[1 0]);
Hf = tf(1,[2 1]); %1/2s+1

Hd = Hf * Hr;
Ho = feedback(Hf*Hr,1)

step(Ho)

t = 0:0.1:30;
figure, lsim(Ho,t,t)
%% c
Hr = tf(2,[1 0 0]);
Hf = tf(1,[2 1]); %1/2s+1

Hd = Hf * Hr;
Ho = feedback(Hf*Hr,1)

step(Ho)

t = 0:0.1:30;
figure, lsim(Ho,t,t)