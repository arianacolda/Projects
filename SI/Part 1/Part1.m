%% PART I: FITTING AN UNKNOWN FUNCTION
%% 
clear
f = load('proj_fit_01.mat');
p = f.id;
q = f.val;

% read and plot the identification data
x1 = p.X{1};       
x2 = p.X{2};
y = p.Y;
surf(x1,x2,y), title('Identification data');
xlabel('x1')
ylabel('x2')
zlabel('y')

% read and plot the validation data
x1val = q.X{1};       
x2val = q.X{2};
yval = q.Y;
figure, surf(q.X{1},q.X{2},q.Y), title('Validation data');
xlabel('x1')
ylabel('x2')
zlabel('y')

msevector = [];

for m = 1:10
    % for identification
    % computing the matrix phi noted with x
    index_x1 = 1; 
    index_x2 = 1;
    x = ones((length(p.X{1})^2),sum(1:(m+1)));
    for i = 1:length(p.X{1})^2
        if index_x2==42
           index_x1 = index_x1+1;
           index_x2 = 1;
        end
        power_x1 = 0;
        power_x2 = -1;
        copy_m = m;
        for j = 1:(sum(1:(m+1)))
            power_x2 = power_x2+1;
            x(i,j) = ((x1(index_x1))^(power_x1))*((x2(index_x2))^(power_x2));
            if power_x2==copy_m
               power_x2 = -1;
               copy_m = copy_m-1;
               power_x1 = power_x1+1;
            end
        end
        index_x2 = index_x2+1;  
    end
    
    % modify y form a matrix to a column
    index = 1;
    for i = 1:41
        for j = 1:41
            y_array(index) = y(i,j);
            index = index+1;
        end
    end
    y_column = transpose(y_array);

    % using linear regression to obtain theta
    theta = x\y_column;

    % compute MSE for identification data
    yhat_id = x*theta;
    mse_id = 1/1681*sum((y_column-yhat_id).^2);
    mse_id_v(m) = mse_id;

    index_m = 1; 
    yhat_id_matrix = ones(41,41);
    for i = 1:41
        for j = 1:41
            yhat_id_matrix(i,j) = yhat_id(index_m);
            index_m = index_m+1;
        end
    end

    % plot the true values compared to the approximator output
    figure, surf(x1,x2,y)
    hold on
    mesh(x1,x2,yhat_id_matrix), title(['True Values Compared to Approximator Outputs - Identification , MSE =',num2str(mse_id_v(m))]);
    xlabel('x1')
    ylabel('x2')
    zlabel('yhat')

    % for validation
    % computing the matrix phi_val noted with xval 
    index_x1val = 1; 
    index_x2val = 1;
    xval = ones((length(q.X{1})^2),sum(1:(m+1)));
    for i = 1:length(q.X{1})^2
        if index_x2val==72
            index_x1val = index_x1val+1;
            index_x2val = 1;
        end
        power_x1val = 0;
        power_x2val = -1;
        copy_mval = m;
        for j = 1:(sum(1:(m+1)))
            power_x2val = power_x2val+1;
            xval(i,j)=((x1val(index_x1val))^(power_x1val))*((x2val(index_x2val))^(power_x2val));
            if power_x2val==copy_mval
                power_x2val = -1;
                copy_mval = copy_mval-1;
                power_x1val = power_x1val+1;
            end
        end
        index_x2val = index_x2val+1;  
    end
    
    % modify yval form a matrix to a column
    index = 1;
    for i = 1:71
        for j = 1:71
            yval_array(index) = yval(i,j);
            index = index+1;
        end
    end
    yval_column = transpose(yval_array);

    y_hat = xval * theta;

    index = 1; 
    y_hat_matrix = ones(71,71);
    for i = 1:71
        for j = 1:71
            y_hat_matrix(i,j) = y_hat(index);
            index = index+1;
        end
    end

    % compute MSE for validation
    mse = 1/5041*sum((yval_column-y_hat).^2);
    msevector(m) = mse

    % plot the true values compared to the approximator output
    figure, surf(x1val,x2val,yval)
    hold on
    mesh(x1val,x2val,y_hat_matrix), title(['True Values Compared to Approximator Outputs - Validation, MSE =',num2str(msevector(m))]);
    xlabel('x1')
    ylabel('x2')
    zlabel('yhat')

end

% finding the minimum MSE for validation and the most accurate m
mse_minim = msevector(1);
M_mse_minim = 1;
for i = 2:m
    if msevector(i)<mse_minim
        mse_minim = msevector(i);
        M_mse_minim = i;
    end
end

figure, plot(mse_id_v), title('MSE Identification');
xlabel('m');
ylabel('mse');
figure, plot(msevector), title('MSE Validation');
xlabel('m');
ylabel('mse');

mse_minim
M_mse_minim

