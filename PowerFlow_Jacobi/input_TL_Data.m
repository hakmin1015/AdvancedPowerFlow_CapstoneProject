% Input Transmission Line Data      
% Bus2Bus / R'pu / X'pu / G'pu / B'pu / Maximum MVA pu
% 추후 엑셀에서 자동으로 데이터 불러오는 방식 적용 예정

function TL_data = input_TL_Data(SIZE)          % #RowsofData = (SIZE)*(SIZE)
    
    TL_data = zeros(SIZE,5,SIZE);
    key = 1;

    % while(1)
    %     fprintf('[Input Transmission Line Data]\n');
    %     Bus_from = input('Bus(from) : ');
    %     Bus_to = input('Bus(to) : ');
    %     TL = zeros(1,5);
    %     fprintf('\n<Bus%d to Bus%d TL data>\n', Bus_from, Bus_to);
    % 
    %     for i=1:5
    %         switch i
    %             case 1
    %                 TL(1,i) = input('R''pu : ');
    %             case 2
    %                 TL(1,i) = input('X''pu : ');
    %             case 3
    %                 TL(1,i) = input('G''pu : ');
    %             case 4
    %                 TL(1,i) = input('B''pu : ');
    %             case 5
    %                 TL(1,i) = input('Max_MVA_pu : ');
    %         end
    %         TL_data(Bus_from,:,Bus_to) = TL(1,:);
    %         TL_data(Bus_to,:,Bus_from) = TL(1,:);
    %     end  
    % 
    %     fprintf('\n');
    %     key = input('Transmission Line data를 계속 입력하시겠습니까? (Yes : 1, No : 0) : ');
    %     fprintf('\n');
    % 
    %     if key==0
    %         break;
    %     end
    % end
    TL_data(2,:,4) = [0.009 0.1 0 1.72 12.0];
    TL_data(4,:,2) = [0.009 0.1 0 1.72 12.0];
    TL_data(2,:,5) = [0.0045 0.05 0 0.88 12.0];
    TL_data(5,:,2) = [0.0045 0.05 0 0.88 12.0];
    TL_data(4,:,5) = [0.00225 0.025 0 0.44 12.0];
    TL_data(5,:,4) = [0.00225 0.025 0 0.44 12.0];
end