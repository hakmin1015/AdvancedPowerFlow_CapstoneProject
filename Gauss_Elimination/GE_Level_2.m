% Gauss Elimination Level 2
% 231229
% 대각 원소가 0이 아니도록 설정한 행렬을 지정하고 G-E를 수행
% 임의의 크기에 대응하도록 코드를 변경

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