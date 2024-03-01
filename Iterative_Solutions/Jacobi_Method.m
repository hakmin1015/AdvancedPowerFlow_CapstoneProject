% 240302
% Jacobi Method : iterative solution to linear algebraic equations

function Jacobi_Method(D_Inv, D, A)
    
    [rows, ~] = size(A);
    AA = zeros(rows);

    for i = 1:rows
        AA(:,i) = A(:,i);
    end

    M = D_Inv*(D-AA);           % M = D^(-1)*(D-A)
    
    i = 1;
    lmt = 30;       % Iteration Limit
    
    x_Mat = zeros(rows,lmt);
    y_Mat = A(:,end);
    err = zeros(rows,1);
    
    while true
        x_Mat(:,i+1) = M*x_Mat(:,i) + D_Inv*y_Mat;
        
        for k = 1:rows
            err(k) = abs((x_Mat(k,i+1)-x_Mat(k,i))/x_Mat(k,i+1));     % 근사 상대오차
        end
    
        i = i+1;

        if i>lmt || sum(err>=0.0001) == 0
            break;
        end
    
    end
    
    fprintf('=========================Jacobi Solution=========================\n\n')
    
    for k = 1:i
        fprintf('<Iteration %d>\n', k-1);
        for m = 1:rows
            fprintf('x%d(%d) = %f\n', m, k-1, x_Mat(m,k));
        end
        fprintf('\n');
    end
    
    fprintf('<Final Approximate Percent Relative Error>\n');
    for k = 1:rows
        fprintf('err(%d) = %f[%%]\n', k, err(k)*100);
    end
end