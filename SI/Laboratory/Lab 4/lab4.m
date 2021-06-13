%% Linear regression
index = 5;
load('lab4_05.mat');
% identification data
x_id = id.X; % data for input
y_id = id.Y; % data for output
plot(x_id,y_id)

N= length(x_id)

% validation data
x_val = val.X; % data for input
y_val = val.Y; % data for output
figure, plot(x_val,y_val), title('Validation');

N_val = length(x_val)


figure, plot(x_id , yhat', x_id, y_id);
legend('Approximation', 'Real Output');
title(['Identification MSE= ',num2str(mse)] );


for n = 2:20
    
for k = 1:N
    for i = 1:n
        PHI(k,i) = x_id(k)^(i-1);
    end
end

% generate theta
theta = PHI \ iy';

% generate yy
yy = phi * theta;


% calculate Mean Square Error
mse(n) = sum((iy-yy').^2)/N

% validation data
for k = 1:Nval
    for i = 1:n
        phival(k,i) = vx(k)^(i-1);
    end
end

% generate yyval
yhatval = phival * theta;


% calculate Mean Square Error
mseval(n) = sum((vy-yyval').^2)/Nval

%pause(1);
end



