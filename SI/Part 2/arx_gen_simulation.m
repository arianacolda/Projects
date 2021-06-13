function [ysim] = arx_gen_simulation(na,nb,nk,m,y_val,x_val,theta)

N=length(x_val);               
% PHI=[];
ysim(1)=0;

for i = 2:N
    aux = []; 
    row = [];
    for j = 1:(na+nb)
        if j<=na
           if (i-j)<=0
               row(1,j) = 0;
           else
               row(1,j) = ysim(i-j);
           end
        else
            k = j-na;
            if (i-k)<=0
                row(1,j) = 0;
            else
                row(1,j) = x_val(i-k);
            end
        end
    end
    
    complete_row = row;
    if m>=2
        aux = row;
        c = 2;
        r = 1;
        added_columns = [];
        v = ones(1,na+nb+1);
        for j = 1:(na+nb)
            for k = j:length(aux)
                new_column = [];
                new_column = row(j).*aux(k); 
                r = r+1;
                added_columns = [added_columns,new_column];
            end
            v(1,c) = r;
            c = c+1;
        end
        v(end) = [];
        complete_row = [complete_row,added_columns];
        
        p = 3;
        while p<=m
              aux = added_columns;
              added_columns = [];
              c = 1;
              r = 1;
              v(end+1) = 0;
              copy_v = v;
              for j = 1:(na+nb)
                  for k = v(c):length(aux)
                      new_column = [];
                      new_column = row(j).*aux(k); 
                      r = r+1;
                      added_columns = [added_columns,new_column];
                  end
                  c = c+1;
                  copy_v(1,c) = r;
              end
              v(end) = [];
              v = copy_v;
              complete_row = [complete_row,added_columns];
              p = p+1;      
        end     
    end
    complete_row = [complete_row,1];
    ysim(i) = complete_row*theta;
%     if i==1
%         PHI=zeros(1,length(complete_row));
%     end
%     PHI=[PHI; complete_row];
end
% PHI(1,:) = [];
end