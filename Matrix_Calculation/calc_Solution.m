% 240301
% Backward Substitution for Solution

function [M,x] = calc_Solution(M, L_Mat, U_Mat, b_Mat)
    
    [rows, cols] = size(M);

    if rows ~= cols     % Augmented Matrix일 때만 Solution을 계산하도록 함.
        d = zeros(rows,1);
        x = zeros(rows,1);
        
        d(:,1) = b_Mat(:,1);
        
        for i = 1:rows
            for j = (i-1):-1:1
                if j < 1
                    break;
                end
                d(i,1) = d(i,1) - d(j,1) * L_Mat(i,j);
            end
        end
        
        x(:,1) = d(:,1);
        
        for i = rows:-1:1
            for j = rows:-1:2
                if j == i
                    break;
                end
                x(i,1) = x(i,1) - U_Mat(i,j) * x(j,1);
            end
            x(i,1) = x(i,1) / U_Mat(i,i);
        end
        
        disp('<해는 다음과 같습니다.>');
        
        for i = 1:rows
            fprintf('x%d = %f\n', i, x(i,1));
        end
        fprintf('\n');

    else
        error('Augmented Matrix가 아니므로 해를 계산하지 않습니다.');

    end
end