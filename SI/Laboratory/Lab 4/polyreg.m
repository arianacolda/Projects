function [index, theta5, mse, yhatstar] = polyreg
warning('off', 'MATLAB:nearlySingularMatrix'); % disable spurious warning

theta5 = 0; yhatstar = 0;  % just to be able to run the function before solving all assignment components

index = 5; % initialize your index here

% write your code here
load('lab4_05.mat');

% identification data
x_id = id.X; % data for input
y_id = id.Y; % data for output
plot(x_id,y_id), title('Identification');

N = length(y_id); % N=41

% validation data
x_val = val.X; % data for input
y_val = val.Y; % data for output
figure, plot(x_val,y_val), title('Validation');

N_val = length(y_val); % N=71

for n = 2:20
    PHI = zeros(N,n);
    for k = 1:N
        for i = 1:n
            PHI(k,i) = x_id(k)^(i-1);
        end
    end
    theta{n} = PHI\y_id(:);
end

for n=2:20
    PHI_val = zeros(N_val,n);
    for k = 1:N_val
        for i = 1:n
            PHI_val(k,i) = x_val(k)^(i-1);
            yhat(k) = PHI_val(k,i)*theta{n};
        end
    end
    mse(n-1) = sum((y_val(:) - yhat(:)).^2)/N_val;   
end
    
   


% plot yhat
figure, plot(x_id,yhat)





end % function polyreg