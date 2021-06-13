% write your code here
load('lab5_2.mat');

% identification data
x_id = id.u;
y_id = id.y;
t_id = tid;

N = length(x_id);

x_id = detrend(x_id,0);
y_id = detrend(y_id,0);
figure, plot(t_id, x_id, t_id, y_id), title('Identification after detrend');

% validation data
x_val = val.u;
y_val = val.y;
t_val = tval;
figure, plot(t_val,x_val,t_val, y_val), title('Validation');

M = 50;

% compute ru
tau = 0:N/2;
in = 1;
for b = 1:length(tau)
    sum = 0;
    for k =1:N-tau(b)
        sum = sum + x_id(k+tau(b))*x_id(k);
    end
    ru(in) = sum/N;
    in = in+1; 
end

ru50 = [ru(1) ru(2) ru(3) ru(4) ru(5) ru(6) ru(7) ru(8) ru(9) ru(10) ru(11)]';

% compute ryu
tau = -N/2:N/2;
in = 1;
for b = 1:length(tau)
    sum = 0;
    for k = 1:N-abs(tau(b))
        sum = sum + y_id(k+abs(tau(b)))*x_id(k);
    end
    ryu(in) = sum/N;
    in = in+1;
end

ryu50 = [ryu(1251) ryu(1252) ryu(1253) ryu(1254) ryu(1255) ryu(1256) ryu(1257) ryu(1258) ryu(1259) ryu(1260) ryu(1261)]';

% compute matrix
M = 50;
T = N/2-M-1;

ryu=ryu(1251:end);
 
ru_m = ones(T,M);
ryu_m = ones(T,1);

in = 1;
for i = 0:T-1
    ryu_m(in) = ryu(i+1);
    in = in+1;
end


for i=0:T-1
    for j=0:M-1
        ru_m(i+1,j+1)=ru(abs(i-j)+1);
    end
end

% using linear regression to obtain h
h = ru_m\ryu_m;
fir50 = h;


