
index = 6; % initialize some dummy index here

%% exercise 1 - vector operations
vec = 30:-1:1;
vec(1:2:end)=sin(vec(1:2:end));
vec(2:2:end)=sort(vec(2:2:end));
v = vec;

%% exercise 2 - function approximation

x = 0:0.25:4;
y = 2*exp(-x.^2) + 2*sin(0.67*x + 0.1);
yhat =2.2159 + 1.2430.*x - 2.6002.*x.^2 + 1.7223.*x.^3 - 0.4683.*x.^4 + 0.0437.*x.^5;

% use function plot to create graphs, together with xlabel, ylabel, and legend to annotate your graph

figure, plot(x,y), hold on
plot(x,yhat)
legend("True values (y)","Approximate values (yhat)")
hold off

e = y - yhat;
mse=1/length(x) * sum((y-yhat).^2);
figure, plot(x,e), title("MSE" + mse);

% don't forget to create variables v, y, and yhat so they can be returned by the function


