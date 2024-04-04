% Input Line Data     
% Bus2Bus / Rpu / Xpu / Gpu / Bpu / Maximum MVA pu / TR exist / Line Number
% 추후 엑셀에서 자동으로 데이터 불러오는 방식 적용 예정

function L_data = input_L_Data(SIZE)

    L_data = zeros(SIZE,7,SIZE);
    key = 1;

    % while(1)
    %     fprintf('[Input Transmission Line Data]\n');
    %     Bus_from = input('Bus(from) : ');
    %     Bus_to = input('Bus(to) : ');
    %     L = zeros(1,7);
    % 
    %     fprintf('\n<Bus%d to Bus%d Line data>\n', Bus_from, Bus_to);
    %     fprintf('[Rpu / Xpu / Gpu / Bpu / Max_MVA_pu / TR exist / Line Number]\n')
    % 
    %     for i=1:7
    %         switch i
    %             case 1
    %                 L(1,i) = input('R_pu : ');
    %             case 2
    %                 L(1,i) = input('X_pu : ');
    %             case 3
    %                 L(1,i) = input('G_pu : ');
    %             case 4
    %                 L(1,i) = input('B_pu : ');
    %             case 5
    %                 L(1,i) = input('Max_MVA_pu : ');
    %             case 6
    %                 L(1,i) = input('Transformer exist? (Yes : 1, No : 0) : ');
    %             case 7
    %                 L(1,i) = input('Line Number : ');
    %         end
    %         L_data(Bus_from,:,Bus_to) = L(1,:);
    %         L_data(Bus_to,:,Bus_from) = L(1,:);     % 행렬 대칭
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
    L_data(2,:,4) = [0.009 0.1 0 1.72 12.0 0 1];
    L_data(4,:,2) = [0.009 0.1 0 1.72 12.0 0 1];
    L_data(2,:,5) = [0.0045 0.05 0 0.88 12.0 0 2];
    L_data(5,:,2) = [0.0045 0.05 0 0.88 12.0 0 2];
    L_data(4,:,5) = [0.00225 0.025 0 0.44 12.0 0 3];
    L_data(5,:,4) = [0.00225 0.025 0 0.44 12.0 0 3];
    L_data(1,:,5) = [0.0015 0.02 0 0 6.0 1 4];
    L_data(5,:,1) = [0.0015 0.02 0 0 6.0 1 4];
    L_data(3,:,4) = [0.00075 0.01 0 0 10.0 1 5];
    L_data(4,:,3) = [0.00075 0.01 0 0 10.0 1 5];
end