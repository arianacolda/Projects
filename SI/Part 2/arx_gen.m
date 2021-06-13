function [PHI] = arx_gen(na,nb,nk,m,y_id,x_id)

N = length(x_id);                     
phi=[];

for i= 1:N
    for j = 1:na
        if (i-j)>0
           phi(i,j) = y_id(i-j);
        else 
           phi(i,j) = 0;
        end
    end
end

for i = 1:N
    for j = 0:(nb-1)
        if (i-nk-j)>0
           phi(i,j+na+1) = x_id(i-nk-j);
        else 
           phi(i,j+na+1) = 0;
        end
    end
end

PHI = phi; 
if m>=2
    v = ones(1,na+nb+1);
    c = 2;
    r = 1;
    aux = phi;
    added_columns = [];
    for j = 1:(na+nb)
        for k = j:size(aux,2)
            new_column = [];
            for p = 1:size(aux,1) 
                new_column(p,1) = phi(p,j).*aux(p,k); 
            end 
            r = r+1;
            added_columns = [added_columns,new_column];
        end
        v(1,c) = r;
        c = c+1;
    end
    v(end) = [];
    PHI = [PHI, added_columns];
    
    i = 3;
    while i<=m
        v(end+1) = 0;
        copy_v = v;
        aux = added_columns;
        added_columns = [];
        c = 1;
        r = 1;
        for j = 1:(na+nb)
            for k = v(c):size(aux,2)
                new_column = [];
                for p = 1:size(aux,1) 
                    new_column(p,1) = phi(p,j).*aux(p,k); 
                end
                r = r+1;
                added_columns = [added_columns,new_column];
            end
            c = c+1;
            copy_v(1,c) = r;
        end
        v(end) = [];
        v = copy_v;
        PHI = [PHI, added_columns];
        i = i+1;
    end
end

PHI = [PHI, ones(size(PHI,1),1)];
end