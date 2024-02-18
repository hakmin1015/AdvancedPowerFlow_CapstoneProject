% Gauss Elimination Level 7
% 240218
% LU Decomposition을 이용한 Inverse Matrix 계산

clear; clc;

% Example Matrix (수치해석 기말고사 2번 문제)
M = [1 1 0 0 0 4;
    4 1 0 0 0 5;
    0 0 16 4 1 5;
    0 0 64 8 1 2;
    1 0 -8 -1 0 0];

% M = [3 -0.1 -0.2;
%     0.1 7 -0.3;
%     0.3 -0.2 10];

disp('<입력받은 행렬>');
disp(M);
fprintf('\n');

% 식 순서 재배치 (대각원소에 0이 위치하지 않도록 함.)
[rows, cols] = size(M);

L_Mat = eye(rows);
U_Mat = zeros(rows);
b_Mat = zeros(rows,1);
A_Mat = zeros(rows);    % Diagonal Matrix
Inv_Mat = zeros(rows);    % Inverse Matrix
tmp_Mat = eye(rows);  % Temporary Matrix for Inverse Matrix Calculation

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

Check_Mat = zeros(rows);
for i = 1:rows
    Check_Mat(:,i) = M(:,i);
end

for i = 1:rows
    A_Mat(i,i) = M(i,i);
end

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

fprintf('==================================================================\n\n\n')

% Diagonal Matrix
fprintf('<A Matrix>\n');
disp(A_Mat);

% LU Decomposition
fprintf('\n<L Matrix>\n');
disp(L_Mat);

fprintf('\n<U Matrix>\n');
disp(U_Mat);

% Solution
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
    
    disp('해는 다음과 같습니다.');
    
    for i = 1:rows
        fprintf('x%d = %d\n', i, x(i,1));
    end
    fprintf('\n');
end

% Inverse Matrix Calculation
for k = 1:rows
    for i = 1:rows
        for j = (i-1):-1:1
            if j < 1
                break;
            end
            tmp_Mat(i,k) = tmp_Mat(i,k) - tmp_Mat(j,k) * L_Mat(i,j);
        end
    end

    Inv_Mat(:,k) = tmp_Mat(:,k);

    for i = rows:-1:1
        for j = rows:-1:2
            if j == i
                break;
            end
            Inv_Mat(i,k) = Inv_Mat(i,k) - U_Mat(i,j) * Inv_Mat(j,k);
        end
        Inv_Mat(i,k) = Inv_Mat(i,k) / U_Mat(i,i);
    end
end

fprintf('<Inverse Matrix>\n');
disp(Inv_Mat);

disp('<역행렬 알고리즘 점검(내장함수(inv) 사용)>');
disp(inv(Check_Mat));