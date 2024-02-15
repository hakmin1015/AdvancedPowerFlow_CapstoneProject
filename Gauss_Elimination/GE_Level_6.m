% Gauss Elimination Level 6
% 240215
% LU Decomposition 버전

clear; clc;

% Example Matrix (수치해석 기말고사 2번 문제)
M = [1 1 0 0 0 4;
    4 1 0 0 0 5;
    0 0 16 4 1 5;
    0 0 64 8 1 2;
    1 0 -8 -1 0 0];

A = M;

disp('<입력받은 행렬>');
disp(M);
fprintf('\n');

% 식 순서 재배치 (대각원소에 0이 위치하지 않도록 함.)
[rows, cols] = size(M);

L_Mat = eye(rows);
U_Mat = zeros(rows);
b_Mat = zeros(rows,1);

for i = 1:rows
    if M(i,i) == 0
        if i == rows
            for j = rows:-1:1
                if M(j,i)~=0 && M(i,j)~=0
                    M([i, j], :) = M([j, i], :);
                    break;
                elseif j == 1
                    error('ERROR 대각원소가 0인 행이 남아있어 프로그램을 종료합니다.');
                end
            end

        else
            for j = 1:rows
                if M(j,i)~=0 && M(i,j)~=0
                    M([i, j], :) = M([j, i], :);
                    break;
                elseif j == rows
                    error('ERROR 대각원소가 0인 행이 남아있어 프로그램을 종료합니다.');
                end
            end
        end
    end
end

disp('<대각원소에 0이 위치하지 않도록 순서를 교환한 행렬>');
disp(M);
fprintf('\n');

for i = 1:rows
    b_Mat(i,1) = M(i,end);
end

% REF 수행
cnt = 0;

for i = 1:rows
    for j = (i+1):rows
% % Partial Pivoting 적용 시 L Matrix의 행 순서가 맞지 않게 되는 문제 발생.
        % if abs(M(j,i)) > abs(M(i,i))      % Partial Pivoting
        %     M([i, j], :) = M([j, i], :);
        %     fprintf('<Partial Pivoting 수행 후 행렬, %d행 <-> %d행 교환>\n', i, j);
        %     disp(M);
        %     fprintf('\n\n');
        % end

        if M(j,i) ~= 0
            fprintf('%d행 - (%d행 x %d) 연산 수행\n', j, i, M(j,i))
            a = M(j,i) / M(i,i);
            M(j,:) = M(j,:) - a * M(i,:);
            L_Mat(j,i) = a;
            
            cnt = cnt + 1;
            fprintf("<%d iteration>\n", cnt);
            disp(M);    % 실시간 행렬 변화 출력
            fprintf('\n');
        end
    end
end

for i = 1:rows
    U_Mat(:,i) = M(:,i);
end

% LU Decomposition
fprintf('\n<L Matrix>\n');
disp(L_Mat);

fprintf('\n<U Matrix>\n');
disp(U_Mat);

% Solution
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

disp('해는 다음과 같습니다.');

for i = 1:rows
    fprintf('x%d = %d\n', i, x(i,1));
end