% Gauss Elimination Level 5
% 240215
% Leading Entry가 1인 RREF를 수행하도록 코드를 수정함.
% 비대각원소가 0인 경우 계산을 생략하도록 하여 코드 효율성을 개선함.

clear; clc;

% Example Matrix (수치해석 기말고사 2번 문제)
M = [1 1 0 0 0 4;
    4 1 0 0 0 5;
    0 0 16 4 1 5;
    0 0 64 8 1 2;
    1 0 -8 -1 0 0];

disp('<입력받은 행렬>');
disp(M);
fprintf('\n\n');

% 식 순서 재배치 (대각원소에 0이 위치하지 않도록 함.)
[rows, cols] = size(M);

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
fprintf('\n\n');

% REF 수행
cnt = 0;

for i = 1:rows
    for j = (i+1):rows
% % % Leading Entry == 1 적용 시 Partial Pivoting 의미X
%         if abs(M(j,i)) > abs(M(i,i))      % Partial Pivoting
%             M([i, j], :) = M([j, i], :);
%             fprintf('<Partial Pivoting 수행 후 행렬, %d행 <-> %d행 교환>\n', i, j);
%             disp(M);
%             fprintf('\n\n');
%         end
        
        if M(i,i) ~= 1          % 대각 원소가 1이 아닌 경우가 더 많기 때문에 코드의 효율성에 대한 재고 필요
            fprintf('%d행을 %d로 나누었음 (Leading Entry == 1)\n', i, M(i,i));
            M(i,:) = M(i,:) / M(i,i);   % for Leading Entry == 1
        end

        if M(j,i) ~= 0
            fprintf('%d행 - (%d행 x %d) 연산 수행\n', j, i, M(j,i))
            M(j,:) = M(j,:) - M(j,i) * M(i,:);
            cnt = cnt + 1;
            fprintf("\n<%d iteration>\n", cnt);
            disp(M);    % 실시간 행렬 변화 출력
            fprintf('\n\n');
        end
    end
end

fprintf("============================ RREF ============================\n\n\n\n");

for i = rows:-1:1
    for j = (i-1):-1:1
        
        if M(i,i) ~= 1
            fprintf('%d행을 %d로 나누었음 (Leading Entry == 1)\n', i, M(i,i));
            M(i,:) = M(i,:) / M(i,i);   % for Leading Entry == 1
        end

        if M(j,i) ~= 0
            fprintf('%d행 - (%d행 x %d) 연산 수행\n', j, i, M(j,i))
            M(j,:) = M(j,:) - M(j,i) * M(i,:);
            cnt = cnt + 1;
            fprintf("\n<%d iteration>\n", cnt);
            disp(M);    % 실시간 행렬 변화 출력
            fprintf('\n\n');
        end
    end
end

% Solution
disp('해는 다음과 같습니다.');
for i = 1:rows
    fprintf('x%d = %d\n', i, M(i,end));
end
