
index = 2; % initialize your index here

% write your code here
load('lab6_2.mat');

% identification data
x_id = id.u;
y_id = id.y;
figure, plot(id), title('Identification data set');
N = length(x_id);

% validation data
x_val = val.u;
y_val = val.y;
figure, plot(val), title('Validation data set');
N_val = length(x_val);

na = 9;
nb = 9;

theta = ones(na+nb);
theta = theta(1,:)';

% compute the matrix for identification
for i = 1:N
    for j = 1:na
        if ((i-j) <= 0)
            PHI(i,j) = 0;
        else
            PHI(i,j) = -y_id(i-j);
        end
    end
end

for i = 1:N
    for j = 1:nb
        if((i-j) <= 0 )
            PHI(i,j+na) = 0;
        else
            PHI(i,j+na) = x_id(i-j);
        end
    end
end

% using linear regression to find theta
theta = PHI\y_id;


% compute matrix for validation and ypred
for i = 1:N_val
    for j = 1:na
        if ((i-j) <= 0)
            PHI_val(j) = 0;
        else
            PHI_val(j) = -y_val(i-j);
        end
    end
    for j = 1:nb
        if((i-j) <= 0)
            PHI_val(j+na) = 0;
        else
            PHI_val(j+na) = x_val(i-j);
        end
    end
     ypred(i) = PHI_val*theta;
end

ypred = ypred';
figure, plot(ypred), hold on, plot(y_val), title('The predicted output against the real one');
legend('ypred','y_val');

% compute MSE
mse = mean((y_val-ypred').^2);

% compute ysim 
ysim = 0;
for i = 1:N_val
    for j = 1:na
        if ((i-j) <= 0)
            PHI_val(j) = 0;
        else
            PHI_val(j) = -ypred(i-j);
        end
    end
    for j = 1:nb
        if((i-j) <= 0)
            PHI_val(j+na) = 0;
        else
            PHI_val(j+na) = x_val(i-j);
        end
    end
     ysim(i) = PHI_val*theta;
end
ysim = ysim'

figure, plot(ysim), hold on, plot(y_val), title('The simulated output against the real one');
legend('ysim','y_val');

% validation on best arx
nk = 1;
figure
model = arx(id, [na, nb, nk]);
compare(model,val);


% hints: to predict, you can reuse nearly the same code that you have for generating PHI
% simulation must be run iteratively over time
