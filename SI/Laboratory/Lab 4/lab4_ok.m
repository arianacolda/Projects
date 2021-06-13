
yhatstar = 0;  % just to be able to run the function before solving all assignment components

index = 5; % initialize your index here

% write your code here
load('lab4_05.mat');

% identification data
x_id = id.X; % data for input
y_id = id.Y; % data for output
plot(x_id,y_id), title('Identification');

% validation data
x_val = val.X; % data for input
y_val = val.Y; % data for output
figure, plot(x_val,y_val), title('Validation');

N = length(x_id); % N=41
N_val = length(x_val); % N=71


for n = 2:20
    PHI = ones(N,n);
    for k = 1:N
        for i = 1:n
            PHI(k,i) = x_id(k)^(i-1);
        end
    end
    % generate theta
    theta = PHI \ y_id';
    if n == 5
        theta5 = PHI \ y_id';
    end
    
    % generate yhat
    yhat = PHI * theta;

    % validation data
    PHI_val = ones(N_val,n); 
    for k = 1:N_val
        for i = 1:n
            PHI_val(k,i) = x_val(k)^(i-1);
        end
    end

    % generate yhat_val
    yhat_val = PHI_val * theta;

    % calculate MSE
    mse(n-1) = sum((y_val-yhat_val').^2)/N_val;
    mse1(n-1) = sum((y_id-yhat').^2)/N;
end

figure, plot(x_val , yhat_val, x_val, y_val), legend('Approximation', 'True values'), title('For Validation');

figure, plot(mse(1:19)); grid;
hold on, plot(mse1(1:19)); grid;

% minimum of mse
m = min(mse(1:19));
ind = 20; % from the graph

 % compute PHI like in the first part
PHI_min = ones(N,ind);
for k = 1:N
  for i = 1:ind
      PHI_min(k,i) = x_id(k)^(i-1);
  end
end

% generate theta
theta = PHI_min \ y_id';

% compute yhatstar
yhatstar = theta(1);
for i = 2:ind
    yhatstar = yhatstar + theta(i)*((x_val).^(i-1));
end

