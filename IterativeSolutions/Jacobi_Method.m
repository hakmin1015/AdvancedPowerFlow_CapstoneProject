% Iterative Solutions to Linear Algebraic Equations
% Jacobi Method
% Gauss-Elimination Code Used
% 240219

clear; clc;

% Augmented Matrix (Power System Analysis and Design 6th ed. EX 6.3)
A = [10 5 6;
    2 9 3];

[rows, cols] = size(A);

D_Mat = zeros(rows);    % Diagonal Matrix
A_Mat = zeros(rows);    % A Matrix      (Ax = y form)
y_Mat = zeros(rows,1);

for i = 1:rows
    y_Mat(i,1) = A(i,end);
end

for i = 1:rows
    D_Mat(i,i) = A(i,i);
end

for i = 1:rows
    A_Mat(:,i) = A(:,i);
end

disp('<Augmented Matrix>');
disp(A);

% Diagonal Matrix
fprintf('<Diagonal Matrix>\n');
disp(D_Mat);

% 식 순서 재배치 (대각원소에 0이 위치하지 않도록 함.)

L_Mat = eye(rows);
U_Mat = zeros(rows);

inv_D_Mat = zeros(rows);    % Inverse Matrix
tmp_Mat = eye(rows);  % Temporary Matrix for Inverse Matrix Calculation

for i = 1:rows
    if D_Mat(i,i) == 0
        if i == rows
            for j = rows:-1:1
                if D_Mat(j,i)~=0 && D_Mat(i,j)~=0
                    D_Mat([i, j], :) = D_Mat([j, i], :);
                    break;
                elseif j == 1
                    error('ERROR 대각원소가 0인 행이 남아있어 프로그램을 종료합니다.');
                end
            end

        else
            for j = 1:rows
                if D_Mat(j,i)~=0 && D_Mat(i,j)~=0
                    D_Mat([i, j], :) = D_Mat([j, i], :);
                    break;
                elseif j == rows
                    error('ERROR 대각원소가 0인 행이 남아있어 프로그램을 종료합니다.');
                end
            end
        end
    end
end

disp('<Matrix of NonZero Diagonal Element>');
disp(D_Mat);
fprintf('\n');

% REF 수행
cnt = 0;

for i = 1:rows
    for j = (i+1):rows
        if D_Mat(j,i) ~= 0
            fprintf('%d행 - (%d행 x %d) 연산 수행\n', j, i, D_Mat(j,i))
            a = D_Mat(j,i) / D_Mat(i,i);
            D_Mat(j,:) = D_Mat(j,:) - a * D_Mat(i,:);
            L_Mat(j,i) = a;
            
            cnt = cnt + 1;
            fprintf("<%d iteration>\n", cnt);
            disp(D_Mat);    % 실시간 행렬 변화 출력
            fprintf('\n');
        end
    end
end

for i = 1:rows
    U_Mat(:,i) = D_Mat(:,i);
end

fprintf('==================================================================\n\n\n')

% LU Decomposition
fprintf('\n<L Matrix of Diagonal Matrix>\n');
disp(L_Mat);

fprintf('\n<U Matrix of Diagonal Matrix>\n');
disp(U_Mat);

% Inverse Matrix Calculation for Diagnonal Matrix
for k = 1:rows
    for i = 1:rows
        for j = (i-1):-1:1
            if j < 1
                break;
            end
            tmp_Mat(i,k) = tmp_Mat(i,k) - tmp_Mat(j,k) * L_Mat(i,j);
        end
    end

    inv_D_Mat(:,k) = tmp_Mat(:,k);

    for i = rows:-1:1
        for j = rows:-1:2
            if j == i
                break;
            end
            inv_D_Mat(i,k) = inv_D_Mat(i,k) - U_Mat(i,j) * inv_D_Mat(j,k);
        end
        inv_D_Mat(i,k) = inv_D_Mat(i,k) / U_Mat(i,i);
    end
end

fprintf('<Inverse of Diagonal Matrix>\n');
disp(inv_D_Mat);

% Jacobi Method : iterative solution to linear algebraic equations
M_Mat = inv_D_Mat*(D_Mat-A_Mat);      % x(i+1) = M*x(i) + D^(-1)*y;

i = 1;
lmt = 15;       % Iteration Limit
x_Mat = zeros(rows, lmt);

while true
    x_Mat(:,i+1) = M_Mat*x_Mat(:,i) + inv_D_Mat*y_Mat;

    err1 = abs(x_Mat(1,i+1)-x_Mat(1,i))/x_Mat(1,i+1);     % 근사 상대오차
    err2 = abs(x_Mat(2,i+1)-x_Mat(2,i))/x_Mat(2,i+1);

    if i>lmt || (err1<0.0001 && err2<0.0001)
        break;
    end

    i = i+1;
end

fprintf('=========================Jacobi Solution=========================\n\n')

for k = 1:i
    fprintf('<Iteration %d>\n', k-1);
    fprintf('x1(%d) = %f\nx2(%d) = %f\n\n', k-1, x_Mat(1,k), k-1, x_Mat(2,k));
end

fprintf('<Final Approximate Percent Relative Error>\n');
fprintf('err1 = %f[%%]\nerr2 = %f[%%]\n', err1*100, err2*100);
