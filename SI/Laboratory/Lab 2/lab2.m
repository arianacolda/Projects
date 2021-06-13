
index = 2;  % set here the index assigned to you by the teacher

%% order 1
load('lab2_order1_2.mat');
i1 = data.u; % input data
o1 = data.y; % output data
plot(data)

%identification for the first step signal
identification_i1 = i1(1:100);
identification_o1 = o1(1:100);

%%find K1 and T
yss = 2.5;
y0 = 0;
uss = 0.5;
u0 = 0;
K1 = (yss - y0)/(uss - u0);
y(T)=y0 + 0.632(yss-y0)
y_T = 0.632 * yss;
ind = find(o1 > y_T,1); % finding the corresponding indices from the x axis
T = t(ind) % value of T in point ind
T = 1.05;

% the transfer function
H = tf(K1, [T 1])

% validation
% simulate its response to the input
lsim(H, i1, t);
figure, plot(t(1:100),identification_o1)


% compute the MSE1
MSE1 = 1/500 * sum((o1 -lsim(H, i1, t)) .^2);
MSE1=0.0056;

%% order 2

load('lab2_order2_2.mat');
i2 = data.u; % input data
o2 = data.y; % output data
plot(data)

%identification for the first step signal
identification_i2 = i2(1:100);
identification_o2 = o2(1:100);

% find K2,xi,omega
yss2 = 6;
uss2 = 1.5;
t1 = 3.5;
t2 = 7.15;
t3 = 10;
y02 = 0;
u02 = 0;
%y(t1) = 8.3;

K2 = (yss2 - y02)/(uss2 - u02);
M = (8.3 - yss2)/yss2; % overshoot
xi = log(1/M)/(sqrt(pi^2+log(M)^2)); % damping factor
T0 = t3 - t1;
omega = (2/T0)*sqrt(pi^2 + log(M)^2); % natural frequency


% the transfer function
H2 = tf(K2*(omega^2), [1 2*xi*omega omega^2])

% validation
% simulate its response to the input
lsim(H2, i2, t);
figure, plot(t(1:100), identification_o2)

% compute the MSE2
MSE2 = 1/500 * sum((o2 -lsim(H2, i2, t)) .^2);

