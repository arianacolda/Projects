function [index, Z10, phi10, theta] = ividentify

Z10 = 0; phi10 = 0; theta = 0; 

index = 4; % initialize your index here

load('lab9_4.mat');

% identification and validation data
x_id = id.u;
y_id = id.y;
x_val = val.u;
y_val = val.y;

Ts = id.Ts;
N = length(x_id);

figure, plot(id); grid; title('Identification data');
figure, plot(val); grid; title('Validation data');


% compare ARX model
na = n
nb = n
nk = 1;

arxmodel = arx(id,[na,nb,nk]);
figure, compare(arxmodel,val)

yhat = sim(arxmodel,x_id); % y from Z formula for instruments

Z = zeros(N,na+nb);
phi = zeros(N,na+nb);
Y_til = zeros(na+nb,1);
phi_til = zeros(na+nb,na+nb);

% IV 
for i = 1:N 
    for j = 1:na
        if ((i-j)<=0)
            Z(i,j) = 0;
            phi(i,j) = 0;
         else
            Z(i,j) = -yhat(i-j);
            phi(i,j) = -y_id(i-j);
        end
    end
   
    for k = 1:nb
        if ((i-k)<=0)
            Z(i,na+k) = 0;
            phi(i,na+k) = 0;
        else
            Z(i,na+k) = x_id(i-k);
            phi(i,na+k) = x_id(i-k);
        end 
    end
end

% compute Z10 and phi10
Z = Z';
phi = phi';
for i =1:(na+nb);
    Z10(i,1) = Z(i,10);
    phi10(i,1) = phi(i,10);
end

% computing Y tilda and phi tilda
phi = phi';
for i=1:N
   Y_til = Y_til + Z(:,i)*y_id(i);
end
Y_til = Y_til/N

for i=1:N 
    phi_til = phi_til + Z(:,i)*phi(i,:);
end
phi_til = phi_til/N

% computing theta 
theta = phi_til\Y_til;

% the model
model = idpoly([1 theta(1:na)'], [0 theta(na+1:na+nb)'], [], [], [], 0, Ts);
figure, compare(val, model, arxmodel); 


% see the lab description for hints
% make sure to save the instrumental vector and the regressor vector at k=10
% after the algorithm finishes, create the model as follows: 
% idpoly([1 theta(1:na)'], [0 theta(na+1:na+nb)'], [], [], [], 0, id.Ts);

end % main function