% 240310
% Inverse Matrix Calculation for Gauss-Seidel Method

function L_Inv = inverse_Matrix_GS(L_Mat, U_Mat, P, L)
    
    [rows, ~] = size(L);

    L_Inv = zeros(rows);  % Inverse Matrix
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
    
        L_Inv(:,k) = tmp_Mat(:,k);
    
        for i = rows:-1:1
            for j = rows:-1:2
                if j == i
                    break;
                end
                L_Inv(i,k) = L_Inv(i,k) - U_Mat(i,j) * L_Inv(j,k);
            end
            L_Inv(i,k) = L_Inv(i,k) / U_Mat(i,i);
        end
    end
    
    L_Inv = L_Inv*P;

    fprintf('<Inverse Matrix of Input Matrix>\n');
    disp(L_Inv);
    
    disp('<역행렬 알고리즘 점검(내장함수 inv() 사용)>');
    disp(inv(L));

end