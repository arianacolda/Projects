%% PART I: FITTING AN UNKNOWN FUNCTION
%% 
clear
f = load('proj_fit_01.mat');
p = f.id;
q = f.val;

%% IDENTIFICATION

x1 = p.X{1};       
x2 = p.X{2};
y = p.Y;
surf(x1,x2,y), title('Identification data')
%%
for m = 1:100
% m=1;
    index_x1 = 1; 
    index_x2 = 1;
    x=ones((length(p.X{1})^2),sum(1:(m+1)));
    for i = 1:length(p.X{1})^2
        if index_x2==42
           index_x1 = index_x1 + 1;
           index_x2 = 1;
        end
        contor_putere_x1 = 0;
        contor_putere_x2 = -1;
        copie_m = m;
        for j = 1:(sum(1:(m+1)))
            contor_putere_x2 = contor_putere_x2+1;
            x(i,j) = ((x1(index_x1))^(contor_putere_x1))*((x2(index_x2))^(contor_putere_x2));
            if contor_putere_x2==copie_m
               contor_putere_x2 = -1;
               copie_m = copie_m - 1;
               contor_putere_x1 = contor_putere_x1 + 1;
            end
        end
        index_x2=index_x2+1;  
    end
end

 %%
index = 1;
for i = 1:41
    for j = 1:41
        y_array(index) = y(i,j);
        index = index+1;
    end
end
y_array = transpose(y_array);
%%
A = x\y_array;
%% VALIDATION

x1val = q.X{1};       
x2val = q.X{2};
yval = q.Y;
surf(x1val,x2val,yval), title('Validation')
%%
for m = 1:100
    index_x1val = 1; 
    index_x2val = 1;
    xval = ones((length(q.X{1})^2),sum(1:(m+1)));
    for i = 1:length(q.X{1})^2
        if index_x2val==72
           index_x1val = index_x1val+1;
           index_x2val = 1;
        end
        contor_putere_x1val = 0;
        contor_putere_x2val = -1;
        copie_mval = m;
        for j = 1:(sum(1:(m+1)))
            contor_putere_x2val = contor_putere_x2val + 1;
            xval(i,j)=((x1val(index_x1val))^(contor_putere_x1val))*((x2val(index_x2val))^(contor_putere_x2val));
            if contor_putere_x2val==copie_mval
               contor_putere_x2val = -1;
               copie_mval = copie_mval - 1;
               contor_putere_x1val = contor_putere_x1val+1;
            end
        end
        index_x2val = index_x2val + 1;  
    end
end

 %%
index = 1;
for i = 1:71
    for j = 1:71
        yval_array(index) = yval(i,j);
        index = index + 1;
    end
end
yval_array = transpose(yval_array);

%%
y_obtained = xval * A; 
%% MEAN-SQURED ERROR
mse = 1/5041*sum((yval_array-y_obtained).^2)

