%% Part II: Nonlinear ARX model
%% 
clear
clc

load('iddata-01.mat');

% reading identification and validation data
Ts = id_array(:,1);
x_id = id_array(:,2);
y_id = id_array(:,3);
Ts_val = val_array(:,1);
x_val = val_array(:,2);
y_val = val_array(:,3);

% ploting identification and validation
figure, subplot(211), plot(x_id),grid ,ylabel('x_{id}'),xlabel('time'), title('Identification data'); 
subplot(212), plot(y_id), grid;
ylabel('y_{id}'), xlabel('time');

figure, subplot(211), plot(x_val), grid, ylabel('x_{val}'), xlabel('time'), title('Validation data');
subplot(212), plot(y_val), grid;
ylabel('y_{val}'), xlabel('time');

N = length(x_id);
N_val = length(x_val);

nk = 1;

answer = 'How many runs do you want?: ';
runs = input(answer);
for z=1:runs
    
% give na,nb,m values; na,nb - model orders; m-polynomial degree
answer = 'na = nb = ';
na = input(answer);
nb = na;
answer = 'm = ';
m = input(answer);
        
% the regressors
PHI_id = arx_gen(na,nb,nk,m,y_id,x_id);

%% One-step-ahead Prediction
% linear regression to find the parameters
theta = PHI_id\y_id;

% identification
yhat_predid = PHI_id*theta;

MSE_predid(z) = (1/N)*sum((y_id-yhat_predid).^2);

figure, plot(yhat_predid), hold on, plot(y_id),
title(['The Predicted Output Against the Real One. MSE= ',num2str(MSE_predid(z)), ' na = nb = ',num2str(na),' m = ',num2str(m)]);
legend('y_{predid}','y_{id}'); 
ylabel('Amplitude');
xlabel('Time');
hold off

% validation
PHI_predval = arx_gen(na,nb,nk,m,y_val,x_val);
yhat_predval = PHI_predval*theta;

MSE_predval(z)=1/N_val*sum((y_val-yhat_predval).^2);

figure, plot(yhat_predval), hold on, plot(y_val), 
title(['The Predicted Output Against the Real One. MSE= ',num2str(MSE_predval(z)), ' na = nb = ',num2str(na),' m = ',num2str(m)]);
legend('y_{predval}','y_{val}');
ylabel('Amplitude');
xlabel('Time');
hold off;

%% Simulation

% identification
[y_sim_id] = arx_gen_simulation(na,nb,nk,m,y_id,x_id,theta);
y_sim_id = transpose(y_sim_id);

MSE_simid(z) = (1/N)*sum((y_id-y_sim_id).^2);

figure, plot(y_val), hold on, plot(y_sim_id);
legend('y_{val}','y_{simid}');
title(['The Simulated Output Against the Real One. MSE = ',num2str(MSE_simid(z)), ' na = nb = ',num2str(na),' m = ',num2str(m)]);
ylabel('Amplitude');
xlabel('Time');
hold off;

% validation
[y_sim_val] = arx_gen_simulation(na,nb,nk,m,y_val,x_val,theta);
y_sim_val = transpose(y_sim_val);

MSE_simval(z) = (1/N)*sum((y_val-y_sim_val).^2);

figure, plot(y_val); hold on, plot(y_sim_val);
legend('y_{val}','y_{simval}');
title(['The Simulated Output Against the Real One. MSE = ',num2str(MSE_simval(z)), ' na = nb = ',num2str(na),' m = ',num2str(m)]);
ylabel('Amplitude');
xlabel('Time');
hold off;


end


%% Mean Squared Error

figure, subplot(211), plot(MSE_predval,'r*'), title('MSEs for Prediction - Validation'), ylabel('MSE');
subplot(212), plot(MSE_simval,'r*'), title('MSEs for Simulation - Validation'), ylabel('MSE');

figure, subplot(211), plot(MSE_predid,'r*'), title('MSEs for Prediction - Identification'), ylabel('MSE');
subplot(212), plot(MSE_simid,'r*'), title('MSEs for Simulation - Identification'), ylabel('MSE');

% Minimum MSE
MSE_min_pred_id = min(MSE_predid);
MSE_min_pred_val = min(MSE_predval);
MSE_min_sim_id = min(MSE_simid);
MSE_min_sim_val = min(MSE_simval);

fprintf('The minumim MSE for prediction (identification) is: MSE=%.4f \n',MSE_min_pred_id)
fprintf('The minumim MSE for prediction (for validation) is: MSE=%.4f \n',MSE_min_pred_val)
fprintf('The minumim MSE for simulation (identification) is: MSE=%.4f \n',MSE_min_sim_id)
fprintf('The minumim MSE for simulation (for validation) is: MSE=%.4f \n',MSE_min_sim_val)