% 240302
% 입력된 대각 행렬에서 LU Decomposition을 수행함

function [L_Mat, U_Mat, b_Mat] = LU_Decomposition_D(A, D)

    [rows, ~] = size(D);
    L_Mat = eye(rows);
    U_Mat = D;
    b_Mat = zeros(rows,1);

    for i = 1:rows
        b_Mat(i,1) = A(i,end);
    end

    fprintf('<Diagonal Matrix>\n');
    disp(D);

    fprintf('<L Matrix>\n');
    disp(L_Mat);
    
    fprintf('<U Matrix>\n');
    disp(U_Mat);

    fprintf('<b Matrix>\n');
    disp(b_Mat); 
    
end