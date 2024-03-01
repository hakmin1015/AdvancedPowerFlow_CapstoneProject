% 240301
% Inverse Matrix Calculation
% PA = LU에서 LU의 역행렬을 구한 후 A^(-1)을 계산하도록 설계되었음.

function M_Inv = inverse_Matrix(L_Mat, U_Mat, P, init_A)
    
    [rows, ~] = size(init_A);

    M_Inv = zeros(rows);    % Inverse Matrix
    tmp_Mat = eye(rows);  % Temporary Matrix for Inverse Matrix Calculation
    
    for k = 1:rows
        for i = 1:rows
            for j = (i-1):-1:1
                if j < 1
                    break;
                end
                tmp_Mat(i,k) = tmp_Mat(i,k) - tmp_Mat(j,k) * L_Mat(i,j);
            end
        end
    
        M_Inv(:,k) = tmp_Mat(:,k);
    
        for i = rows:-1:1
            for j = rows:-1:2
                if j == i
                    break;
                end
                M_Inv(i,k) = M_Inv(i,k) - U_Mat(i,j) * M_Inv(j,k);
            end
            M_Inv(i,k) = M_Inv(i,k) / U_Mat(i,i);
        end
    end
    
    M_Inv = M_Inv*P;

    fprintf('<Inverse Matrix of Input Matrix>\n');
    disp(M_Inv);
    
    % disp(init_A);
    disp('<역행렬 알고리즘 점검(내장함수 inv() 사용)>');
    disp(inv(init_A));

end