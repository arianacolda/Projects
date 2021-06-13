function [index, pe3, pe10, u3, theta3, y10] = prbsidentify
% to ensure the same noise realizations and thus the same solutions, you should:
% reset the random number generator, as done below
% generate FIRST the validation dataset, THEN the identification dataset with m=3, THEN with m=10 (and no others in-between)
rng('default');  
 
index = 3; % initialize your index here

% don't forget to load the validation input
load('uval.mat');

% here is how you can use system_simulator, as an example here we will generate the validation dataset
val = system_simulator(index, u); 
figure, plot(val), grid, title('Dataset generated for u3');

% compute the orders of PE and create the PRBS signals
% for m=3
pe3 = 2^3-1;

% for m =10
pe10 = 2^10-1;


% PRBS for m = 3
u3 = funPRBS(300, 3, 0.5, 1);
u3 = u3';
id1 = system_simulator(index,u3);
figure, plot(id1), grid, title('Dataset generated for u3');

% arx model for m=3
na = 15;
nb = 15;
nk =1;
arxmodel = arx(id1,[na,nb,nk]);
theta3 = [arxmodel.a(2:na) arxmodel.b(2:nb)]';

% PRBS for m =10 
u10 = funPRBS(300, 10, 0.5, 1);
u10 = u10';
id2 = system_simulator(index,u10);
figure, plot(id2), grid, title('Dataset generated for u10');

% arx model for m=10
na = 15;
nb = 15;
nk =1;
arxmodel2 = arx(id2,[na,nb,nk]);

% simulated model output
y10 = sim(arxmodel2,u);

% initialize coefficients a as in the table from the lecture
% generate dataset for m=3, run arx on it, validate the model in simulation
% recall signature: model = arx(dataset, [na nb 1])
% to pick up the column vector of parameters from the resulting model: theta = [model.a(2:na) model.b(2:nb)]'
% to simulate, use syntax y = sim(model, u) or compare(model, val), which shows you a graph and a fit percentage
% generate dataset for m=10, run arx on it, validate the model in simulation

end % main function

function unew = funPRBS(N, m, b, c)

% compute the matrix A
A = zeros(m,m);
for i=2:m
     A(i,i-1) = 1;
end

%coefficients equal to 1
if(m==3) || (m==4) || (m==6) || (m==7)
     A(1,1) = 1;
     A(1,m) = 1;
end
if m==5
    A(1,2) = 1;
    A(1,5) = 1;
end
if m==8
    A(1,1) = 1;
    A(1,2) = 1;
    A(1,7) = 1;
    A(1,8) = 1;
end
if m==9
    A(1,4) = 1;
    A(1,9) = 1;
end 
if m==10
    A(1,3) = 1;
    A(1,10) = 1;
end

% the initial states for m=3 and m=10
if m==3
x = [0,1,1]';
end

if m==10
    x=[0,0,0,0,0,0,0,0,1,1]';
end

u2 = ones(1,m);
    
for k = 1:N
    u2(k) = x(end);
    x = mod(A*x,2);
end

unew = b+(c-b)*u2;

end % PRBS function
