% 240310
% 입력된 행렬에서 LU Decomposition을 수행함

function [A, P, L_Mat, U_Mat, b_Mat] = LU_Decomposition_L(A, L)

    cnt = 0;
    [rows, ~] = size(L);
    L_Mat = eye(rows);
    U_Mat = zeros(rows);
    b_Mat = zeros(rows,1);
    P = eye(rows);          % Permutation Matrix

    for i = 1:rows
        b_Mat(i,1) = A(i,end);
    end

    for i = 1:rows
        max = abs(L(i,i));
        max_idx = i;

        for j = (i+1):rows
            if abs(L(j,i)) > max && L(i,j)~=0      % Partial Pivoting
                max = abs(L(j,i));
                max_idx = j;
            end
        end

        if max_idx ~= i
            L([i, max_idx], :) = L([max_idx, i], :);
            P([i, max_idx], :) = P([max_idx, i], :);
            b_Mat([i, max_idx], :) = b_Mat([max_idx, i], :);
            
            L_Mat([i, max_idx], 1:i-1) = L_Mat([max_idx, i], 1:i-1);

            fprintf('<Partial Pivoting 수행, (%d행 <-> %d행) 교환>\n', i, max_idx);
            cnt = cnt + 1;
            fprintf("[%d iteration]\n", cnt);
            disp(L);    % 실시간 행렬 변화 출력
        end


        for j = (i+1):rows
            if L(j,i) ~= 0
                L_Mat(j,i) = L(j,i) / L(i,i);
                fprintf('<%d행 - (%d행 x %d) 연산 수행>\n', j, i, L_Mat(j,i));
                L(j,:) = L(j,:) - L_Mat(j,i) * L(i,:);
                cnt = cnt + 1;
                fprintf("[%d iteration]\n", cnt);
                disp(L);    % 실시간 행렬 변화 출력
            end
        end
    end
    
    for i = 1:rows
        U_Mat(:,i) = L(:,i);
    end

    fprintf('<REF Matrix + Partial Pivoting>\n');
    disp(L);

    fprintf('<L Matrix>\n');
    disp(L_Mat);
    
    fprintf('<U Matrix>\n');
    disp(U_Mat);

    fprintf('<b Matrix>\n');
    disp(b_Mat);

    fprintf("<Permutation Matrix>\n");
    disp(P);    
    
end