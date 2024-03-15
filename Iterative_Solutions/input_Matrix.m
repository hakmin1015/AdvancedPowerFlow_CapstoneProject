% 240302
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
    % matrix = [1 1 0 0 0 4;
    %         4 1 0 0 0 5;
    %         0 0 16 4 1 5;
    %         0 0 64 8 1 2;
    %         1 0 -8 -1 0 0];

    % matrix = [3 8 1 ; 5 2 0; 6 1 12];

    % matrix = [10 5 6; 2 9 3];   % Augmented Matrix (Power System Analysis and Design 6th ed. EX 6.3)

    % matrix = [5 1 1 1;
    %           1 4 1 2;
    %           2 3 6 3];
    % https://www.emathhelp.net/en/calculators/linear-algebra/gauss-jordan-elimination-calculator/?i=%5B%5B5%2C1%2C1%2C1%5D%2C%5B1%2C4%2C1%2C2%5D%2C%5B2%2C3%2C6%2C3%5D%5D&reduced=on
    
    % matrix = [5 1 0 0 0 1;
    %           1 6 1 0 0 2;
    %           0 1 7 1 0 3;
    %           0 0 1 8 1 4;
    %           0 0 0 1 9 5];
    % https://www.emathhelp.net/en/calculators/linear-algebra/gauss-jordan-elimination-calculator/?i=%5B%5B5%2C1%2C0%2C0%2C0%2C1%5D%2C%5B1%2C6%2C1%2C0%2C0%2C2%5D%2C%5B0%2C1%2C7%2C1%2C0%2C3%5D%2C%5B0%2C0%2C1%2C8%2C1%2C4%5D%2C%5B0%2C0%2C0%2C1%2C9%2C5%5D%5D&reduced=on

    matrix = [10 1 1 1 0 0 0 0 0 1;
              1 11 1 1 1 0 0 0 0 2;
              0 1 12 1 1 1 0 0 0 3;
              0 0 1 13 1 1 1 0 0 4;
              0 0 0 1 14 1 1 1 0 5;
              0 0 0 0 1 15 1 1 1 6;
              0 0 0 0 0 1 16 1 1 7;
              0 0 0 0 0 0 1 17 1 8;
              0 0 0 0 0 0 0 1 18 9];
    % https://www.emathhelp.net/en/calculators/linear-algebra/gauss-jordan-elimination-calculator/?i=%5B%5B10%2C1%2C1%2C1%2C0%2C0%2C0%2C0%2C0%2C1%5D%2C%5B1%2C11%2C1%2C1%2C1%2C0%2C0%2C0%2C0%2C2%5D%2C%5B0%2C1%2C12%2C1%2C1%2C1%2C0%2C0%2C0%2C3%5D%2C%5B0%2C0%2C1%2C13%2C1%2C1%2C1%2C0%2C0%2C4%5D%2C%5B0%2C0%2C0%2C1%2C14%2C1%2C1%2C1%2C0%2C5%5D%2C%5B0%2C0%2C0%2C0%2C1%2C15%2C1%2C1%2C1%2C6%5D%2C%5B0%2C0%2C0%2C0%2C0%2C1%2C16%2C1%2C1%2C7%5D%2C%5B0%2C0%2C0%2C0%2C0%2C0%2C1%2C17%2C1%2C8%5D%2C%5B0%2C0%2C0%2C0%2C0%2C0%2C0%2C1%2C18%2C9%5D%5D&reduced=on

    [rows, ~] = size(matrix);

    % 입력받은 행렬 출력
    disp('입력된 행렬:');
    disp(matrix);
    init_A = zeros(rows);

    for i = 1:rows
        init_A(:,i) = matrix(:,i);
    end

end