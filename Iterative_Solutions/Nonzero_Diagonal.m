% 240302
% 행렬의 대각원소에 0이 위치하지 않도록 순서를 교환하고 불가한 경우 error 출력

function [M, P, D] = Nonzero_Diagonal(M)

    [rows, ~] = size(M);
    P = eye(rows);          % Permutation Matrix

    for i = 1:rows
        if M(i,i) == 0
            if i == rows
                for j = rows-1:-1:1
                    if M(j,i)~=0 && M(i,j)~=0
                        M([i, j], :) = M([j, i], :);
                        P([i, j], :) = P([j, i], :);
                        break;
                    elseif j == 1
                        error('대각원소에 0이 위치하지 않도록 행렬의 순서를 교환할 수 없습니다.');
                    end
                end
    
            else
                for j = 1:rows
                    if M(j,i)~=0 && M(i,j)~=0
                        M([i, j], :) = M([j, i], :);
                        P([i, j], :) = P([j, i], :);
                        break;
                    elseif j == rows
                        error('대각원소에 0이 위치하지 않도록 행렬의 순서를 교환할 수 없습니다.');
                    end
                end
            end
        end
    end
    disp('대각원소에 0이 위치하지 않도록 행렬의 순서를 교환할 수 있습니다.');
    disp('<Nonzero Diagonal Matrix>');
    disp(M);

    D = zeros(rows);
    
    for i = 1:rows
        D(i,i) = M(i,i);
    end
    
end