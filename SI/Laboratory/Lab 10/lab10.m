function [index, Pinv10, theta50, thetaN] = rarxidentify

Pinv10 = 0; theta50 = 0; thetaN = 0;

index = 4; % initialize your index here

load('lab10_4.mat');

x_id = id.u;
y_id = id.y;
x_val = val.u;
y_val = val.y;
Ts=id.Ts;

figure, plot(id), title('Identification data');
figure, plot(val), title('Validation data');

na=3*n
nb=3*n;
nk=1;

N = length(x_id);

% for delta = 0.01 
delta = 0.01;
theta = zeros(na+nb,1);
phi = zeros(na+nb,1);
Pinv = zeros(na+nb,na+nb);
Pinv = (1/delta)*eye(na+nb);

for i = 1:N
    % form the regressor vector
    for j = 1:na
        if ((i-j) <= 0)
            phi(i,j) = 0;
        else
            phi(i,j) = -y_id(i-j);
        end
    end
    for k = 1:nb
        if ((i-k) <= 0 )
            phi(i,k+na) = 0;
        else
            phi(i,k+na) = x_id(i-k);
        end
    end
    
    % compute the prediction error
    e(i) = y_id(i)-phi(i,:)*theta;
    % the inverse
    Pinv = Pinv-(Pinv*phi(i,:)'*phi(i,:)*Pinv)/(1+phi(i,:)*Pinv*phi(i,:)');
    % compute weight
    w = Pinv*phi(i,:)';
    % the parameters
    theta = theta+w*e(i);
    
    % computing Pinv10 and theta50 and thetaN
    if (i==10)
        Pinv10 = Pinv;
    end
    if (i==49)
       theta50 = theta;
    end
    if (i==N)
       thetaN = theta;
    end
   
end

model1 = idpoly([1 theta50(1:na)'], [0 theta50(na+1:na+nb)'], [], [], [], [], Ts);
model2 = idpoly([1 thetaN(1:na)'], [0 thetaN(na+1:na+nb)'], [], [], [], [], Ts);
figure, compare(val, model1, model2);

% read the lab description carefully
% for a given column vector theta, create the model as follows: idpoly([1 theta(1:na)'], [0 theta(na+1:na+nb)'], [], [], [], [], id.Ts);
% don't forget to compare your two models on the validation dataset

end % main function
