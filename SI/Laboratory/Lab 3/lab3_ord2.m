load('lab3_order2_2.mat');
y2 = data.y; % output data
u2 = data.u; % input data
plot(data)
yss2 = mean(data.y(1:2.5));
Ts=data.Ts

k00=2.76/Ts
k01=3.9/Ts
k02=4.98/Ts