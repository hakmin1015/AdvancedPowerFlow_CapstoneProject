% Transformer Input Data

function TR_data = input_TR_Data(SIZE)

    TR_data = zeros(SIZE,6,SIZE);
    key = 1;
    
    % while(1)
    %     fprintf('[Input Transformer Data]\n');
    %     Bus_from = input('Bus(from) : ');
    %     Bus_to = input('Bus(to) : ');
    %     TR = zeros(1,6);
    %     fprintf('\n<Bus%d to Bus%d TR data>\n', Bus_from, Bus_to);
    % 
    %     for i=1:6
    %         switch i
    %             case 1
    %                 TR(1,i) = input('Rpu : ');
    %             case 2
    %                 TR(1,i) = input('Xpu : ');
    %             case 3
    %                 TR(1,i) = input('Gc_pu : ');
    %             case 4
    %                 TR(1,i) = input('Bm_pu : ');
    %             case 5
    %                 TR(1,i) = input('Max_MVA_pu : ');
    %             case 6
    %                 TR(1,i) = input('Max_TAP_setting_pu : ');
    %         end
    %         TR_data(Bus_from,:,Bus_to) = TR(1,:);
    %         TR_data(Bus_to,:,Bus_from) = TR(1,:);
    %     end
    % 
    %     fprintf('\n');
    %     key = input('Transformer data를 계속 입력하시겠습니까? (Yes : 1, No : 0) : ');
    %     fprintf('\n');
    % 
    %     if key==0
    %         break;
    %     end
    % end
    TR_data(1,:,5) = [0.0015 0.02 0 0 6.0 0];
    TR_data(5,:,1) = [0.0015 0.02 0 0 6.0 0];
    TR_data(3,:,4) = [0.00075 0.01 0 0 10.0 0];
    TR_data(4,:,3) = [0.00075 0.01 0 0 10.0 0];
end