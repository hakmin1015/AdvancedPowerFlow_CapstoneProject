% import Bus Data from Excel file
% Bus Number / Bus Type / V / Delta / P_G / Q_G / P_L / Q_L / Q_max / Q_min
% Initial Value Setting from Bus data

function [SIZE,V,Delta,P,Q,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,Bus_Type,Switch_Sig] = Init_Value(bus_file,ITERATION)

    raw_B_data = readmatrix(bus_file);
    
    [SIZE, ~] = size(raw_B_data);

    % Bus Type Initialize
    raw_B_data = BusType_Init(raw_B_data,SIZE);

    V = zeros(SIZE,ITERATION);
    Delta = zeros(SIZE,ITERATION);
    P_G = zeros(SIZE,ITERATION);
    Q_G = zeros(SIZE,ITERATION);
    P_L = zeros(SIZE,ITERATION);
    Q_L = zeros(SIZE,ITERATION);
    Q_Gmax = zeros(SIZE,1);
    Q_Gmin = zeros(SIZE,1);
    Bus_Type = zeros(SIZE,ITERATION);
    Switch = zeros(SIZE,1);

    V(:,1) = raw_B_data(:,3);
    Delta(:,1) = raw_B_data(:,4);
    P_G(:,1) = raw_B_data(:,5);
    Q_G(:,1) = raw_B_data(:,6);
    P_L(:,1) = raw_B_data(:,7);
    Q_L(:,1) = raw_B_data(:,8);
    Q_Gmax(:,1) = raw_B_data(:,9);
    Q_Gmin(:,1) = raw_B_data(:,10);

    P = P_G - P_L;
    Q = Q_G - Q_L;

    Switch_Sig = zeros(SIZE,ITERATION);
    Switch_Sig(:,:) = repmat(Switch,1,ITERATION);      % iteration시 정보 전달 조건

    Bus_Type(:,1) =  raw_B_data(:,2);
    Bus_Type(:,:) = repmat(Bus_Type(:,1),1,ITERATION);

    fprintf('\n[Bus Data]\n');
    fprintf('    Bus Num   Bus Type    V          Delta      P_G       Q_G     P_L      Q_L     Q_Gmax    Q_Gmin\n')
    fprintf('-----------------------------------------------------------------------------------------------------\n')
    disp(raw_B_data);
end