function [index, e1, de1, theta] = oeidentify

e1 = 0; de1 = 0; theta = 0; 

index = 4; % initialize your index here

load('lab8_4.mat');

% identification and validation data
x_id = id.u;
y_id = id.y;
x_val = val.u;
y_val = val.y;

figure, plot(id); grid; title('Identification data');
figure, plot(val); grid; title('Validation data');

N = length(x_id); 


f = 1; 
b = 1;


% computing e1 and de1
e1(1) = y_id(1);
de1(1) = 0;
def(1) = 0;
deb(1) = 0;

for k=2:N
        e1(k) = -f*e1(k-1)+y_id(k)+f*y_id(k-1)-b*x_id(k-1);
        def(k) = -e1(k-1)+y_id(k-1)-f*def(k-1);
        deb(k) = -x_id(k-1)-f*deb(k-1);
        de1(1,k) = def(k);
        de1(2,k) = deb(k);
end

% finding theta
theta = [f,b]';
l = 1; % counter
th = 1; % the value of thetal+1 - thetal

% max iterations
lmax = 100;
% stepsize
alfa = 0.5;
% threshold
tr = 1e-4; 

e(1) = y_id(1);
de(1) = 0;
def(1) = 0;
deb(1) = 0;

while (l<=lmax) && (th>tr)
    
    f = theta(1,l);
    b = theta(2,l); 
    for k=2:N
        e(k) = -f*e(k-1)+y_id(k)+f*y_id(k-1)-b*x_id(k-1);
        def(k) = -e(k-1)+y_id(k-1)-f*def(k-1);
        deb(k) = -x_id(k-1)-f*deb(k-1);
        de(1,k) = def(k);
        de(2,k) = deb(k);
    end
    H = zeros(2,2);
    dv = zeros(2,1); 
    
    for k = 1:N 
        dv(1,1) = dv(1,1)+e(k)*de(1,k);
        dv(2,1) = dv(2,1)+e(k)*de(2,k);
    end
    dv = 2/N*dv; % the gradient
    H = H+(2/N)*(de*de'); % the Hessian
    
    thetan = [f,b]'-alfa*inv(H)*dv;
    theta = [theta thetan];
    
    l = l+1; % increment counter
    th = norm(theta(:,l) - theta(:,l-1)); % the condition for the while with the norm of theta
    
end


% model validation
oemodel = idpoly(1,[0 b],1,1,[1 f],0,id.Ts);
compare(val,oemodel);

% see the lab description for full pseudocode and coding hints
% make sure to save the error and error derivatives in e1 and de1 at the first iteration
% once your algorithm has converged, create the model as follows: oemodel = idpoly(1,[0 b],1,1,[1 f],0,id.Ts);

end % main function