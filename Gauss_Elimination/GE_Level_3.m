% Gauss Elimination Level 3
% 231229
% 대각 원소가 0이 아니도록 설정한 행렬을 지정하고 G-E를 수행
% 대각 원소를 제외한 모든 원소가 0이 되도록 코드 추가
% Augmented Matrix 연산으로 해를 구하는 과정에서 효과를 발휘할 수 있음.
% 이미 0인 비대각원소에 대하여 계산을 생략하도록 하여 코드 최적화 가능

clear; clc;

M = [1 1 0 0 0;
     4 1 0 0 0;
     0 0 16 4 1;
     1 0 -8 -1 0;
     0 0 64 8 1];

SIZE = length(M);

for i = 1:SIZE
    for j = (i+1):SIZE
        d = M(j,i) / M(i,i);
        for k = 1:SIZE
            M(j,k) = M(j,k) - d * M(i,k);
        end
        disp(M);    % 실시간 행렬 변화 출력
    end
end

fprintf("===========================================================\n\n");

for i = SIZE:-1:1
    for j = (i-1):-1:1
        d = M(j,i) / M(i,i);
        for k = 1:SIZE
            M(j,k) = M(j,k) - d * M(i,k);
        end
        disp(M);    % 실시간 행렬 변화 출력
    end
end
