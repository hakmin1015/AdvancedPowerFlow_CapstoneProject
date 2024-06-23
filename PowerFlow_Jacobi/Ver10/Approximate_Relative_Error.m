% 근사 (백분율) 상대오차

function err_X = Approximate_Relative_Error(SIZE,ITERATION,i,X)

    err_X = zeros(1,SIZE,ITERATION);
    
    for j = 1:SIZE
        if X(1,j,i+1) == 0
            err_X(1,j,i) = 0;
            
        else
            err_X(1,j,i) = abs((X(1,j,i+1)-X(1,j,i))/X(1,j,i+1));     % 근사 상대오차
            err_X(1,j,i) = err_X(1,j,i)*100;        % 근사 백분율 상대오차
        end
    end
end