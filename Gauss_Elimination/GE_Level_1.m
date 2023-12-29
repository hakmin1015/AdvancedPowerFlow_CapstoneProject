% Gauss Elimination Level 1
% 231229
% 대각 원소가 0이 아니도록 설정한 행렬을 지정하고 G-E를 수행
% PowerSystem Example 6.2 참고

clear; clc;

M = [2 3 -1; -4 6 8; 10 12 14];

for i = 1:3
    for j = (i+1):3
        d = M(j,i) / M(i,i);
        for k = 1:3
            M(j,k) = M(j,k) - d * M(i,k);
        end
        disp(M);    % 실시간 행렬 변화 출력
    end
end