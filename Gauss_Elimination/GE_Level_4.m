% Gauss Elimination Level 4
% 240214
% 대각 원소에 0이 존재할 때 행의 위치를 교환하도록 코드 수정
% 이미 0인 비대각원소는 계산을 생략하도록 하여 코드 최적화 가능
% RREF를 구현하여 계산할 수 있음.

clear; clc;

% Example Matrix (수치해석 기말고사 2번 문제)
M = [1 1 0 0 0 4;
    4 1 0 0 0 5;
    0 0 16 4 1 5;
    0 0 64 8 1 2;
    1 0 -8 -1 0 0];

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
                    error('대각원소가 0인 행이 남아있어 프로그램을 종료합니다.');
                end
            end

        else
            for j = 1:rows
                if M(j,i)~=0 && M(i,j)~=0
                    M([i, j], :) = M([j, i], :);
                    break;
                elseif j == rows
                    error('대각원소가 0인 행이 남아있어 프로그램을 종료합니다.');
                end
            end
        end
    end
end

disp('대각원소에 0이 위치하지 않도록 순서를 교환한 행렬');
disp(M);

% REF 수행
cnt = 0;

for i = 1:rows
    for j = (i+1):rows
        if abs(M(j,i)) > abs(M(i,i))      % Partial Pivoting
            M([i, j], :) = M([j, i], :);
            fprintf('(Partial Pivoting이 수행됨)');
        end

        d = M(j,i) / M(i,i);
        M(j,:) = M(j,:) - d * M(i,:);
        
        cnt = cnt + 1;
        fprintf("%d iteration\n", cnt);
        disp(M);    % 실시간 행렬 변화 출력
    end
end

fprintf("===========================================================\n\n");

for i = rows:-1:1
    for j = (i-1):-1:1

        d = M(j,i) / M(i,i);
        M(j,:) = M(j,:) - d * M(i,:);

        cnt = cnt + 1;
        fprintf("<%d iteration>\n", cnt);
        disp(M);    % 실시간 행렬 변화 출력
    end
end

% Solution
disp('해는 다음과 같습니다.');
x = zeros(rows);            % 배열 x의 공간이 낭비되었음.
for i = 1:rows
    x(i) = M(i,end) / M(i,i);
    fprintf('x%d = %d\n', i, x(i));
end