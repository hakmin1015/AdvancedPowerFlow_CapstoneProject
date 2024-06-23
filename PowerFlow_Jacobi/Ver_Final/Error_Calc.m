% Calculation of Approximate Percent Relative Error

function err_V = Error_Calc(SIZE,ITERATION,i,V)

    err_V = zeros(SIZE,ITERATION);

    for j = 1:SIZE
        if V(j,i+1) == 0
            err_V(j,i) = 0;
            
        else
            err_V(j,i) = abs((V(j,i+1)-V(j,i))/V(j,i+1));     % 근사 상대오차
            err_V(j,i) = err_V(j,i)*100;        % 근사 백분율 상대오차
        end
    end
    
end