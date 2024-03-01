% 240301
% Bus의 Matrix 정보를 직접 입력 받도록 함

function [matrix, init_A] = input_Matrix()

    % rows = input('Bus의 수를 입력하세요: ');
    % 
    % % 각 행의 요소를 입력 받아 행렬 만들기
    % matrix = zeros(rows, rows+1);
    % for i = 1:rows
    %     row_input = input(sprintf('%d번째 Bus의 요소를 입력하세요 (공백으로 구분): ', i), 's');
    %     row_elements = sscanf(row_input, '%f'); % 숫자로 변환
    %     matrix(i, 1:numel(row_elements)) = row_elements; % 행렬에 할당
    % end

    % Example Matrix (수치해석 기말고사 2번 문제)
    matrix = [1 1 0 0 0 4;
        4 1 0 0 0 5;
        0 0 16 4 1 5;
        0 0 64 8 1 2;
        1 0 -8 -1 0 0];
    % matrix = [3 8 1 ; 5 2 0; 6 1 12];

    [rows, ~] = size(matrix);

    % 입력받은 행렬 출력
    disp('입력된 행렬:');
    disp(matrix);
    
    init_A = zeros(rows);
    
    for i = 1:rows
        init_A(:,i) = matrix(:,i);
    end

end