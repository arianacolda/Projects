
index = 2;  % set here the index assigned to you by the teacher

% don't forget to create all the return variables of the function (initially with dummy values, 
% if you haven't yet solved that part of the assignment) so that the function can work
% for instance:
K2 = 0; xi = 0; omega = 0; MSE2 = 0;

%% order 1
load('lab3_order1_2.mat');
y = data.y; % output data
u = data.u; % input data
plot(data)

% identification for the first impulse signal
u_id = u(3:15);
y_id = y(3:15);

% find K1 and T
yss = mean(data.y(1:3.5));  %yss=2.957
uss = data.u(1);
K1 = yss/uss;
ymax = 3.96; % from the grah
t1 = 3.84; % the time when ymax=3.96
y0 = yss;
u0 = uss;
y_t2 = y0 + 0.368*(ymax - y0) 
t2 = 5.76;
T = t2-t1;

% state space model
A = -1/T;
B = K1/T;
C = 1;
D = 0;
Hss = ss(A,B,C,D) 

% validation data
u_val = data.u(15:40);
y_val = data.y(15:40);
t_val = t(15:40);

y1 = lsim(Hss,u_val,t_val,yss);

figure, plot(t_val,y1) 
hold on
plot(t_val,y_val,'r')
hold off

% compute MSE1
MSE1 = 1/40 * sum((y1-y_val).^2);



%% order 2
load('lab3_order2_2.mat');
y2 = data.y; % output data
u2 = data.u; % input data
plot(data)

% identification data for the first impulse signal
y2_id = data.y(2:11);
u2_id = data.u(2:11);

% find K1, xi, omega
yss2 = mean(data.y(1:3));
y02 = yss2;
uss2 = data.u(1);
u02 = uss2;
K2 = yss2/uss2;

ymax2 = 1.5; % from the graph
time1 = 3.2; % time when ymax2=1.5
time3 = 5.42; % time value of the second peak

t00 = 2.76;
t01 = 3.9;
t02 = 4.98;
Ts = data.Ts;

k00 = 2.76/Ts; %
k01 = 3.9/Ts;
k02 = 4.98/Ts; 

% areas estimated numerically
aplus = Ts*sum(y2(k00:1:k01)-yss2);
aminus = Ts*sum(yss2-y2(k01:1:k02));

M = aminus/aplus; % overshoot
xi = log(1/M)/(sqrt(pi^2+log(M)^2)); % damping factor
T0 = time3-time1; % he ocsillation period
omega = (2/T0)*sqrt(pi^2 + log(M)^2); % natural frequency

% state space model
A2 = [ 0 1; -omega^2 -2*xi*omega];
B2 = [ 0 ; K2*omega^2]
C2 = [1 0];
D2 = 0;
Hss2 = ss(A2,B2,C2,D2)

% validation data
u2_val = data.u(11:30);
y2_val = data.y(11:30);
t2_val = t(11:30);

y12 = lsim(Hss2, u2_val, t2_val, [yss2 0]);

figure, plot(t2_val,y12) 
hold on
plot(t2_val,y2_val,'b')
hold off

% compute MSE2
MSE2 = 1/30 * sum((y12-y2_val).^2);


% Hints:
% use function load to load datafiles; plot to create graphs; 
% ss to create the state-space model; lsim to simulate its response to the input;
% use sums of outputs to approximate the integrals;
% if you want to develop a programmatic solution (optional), function find will be useful


%% call the function
[index, K1, T, MSE1, K2, xi, omega, MSE2] = transient_impulse(0)