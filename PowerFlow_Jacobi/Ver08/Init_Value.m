% import Bus Data from xlsx(csv) file
% Bus Number / Bus Type / V / Delta / P_G / Q_G / P_L / Q_L / Q_max / Q_min
% Initial Value

function [SIZE,V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type,Switch_Sig] = Init_Value(ITERATION)

    % file = 'example6.10_bus.xlsx';
    % file = 'example6.38_bus.xlsx';
    % file = 'ieee5bus_bus.xlsx';
    file = 'ieee14bus_bus.xlsx';

    sheet = 1;
    raw_B_data = xlsread(file, sheet);

    [SIZE, ~] = size(raw_B_data);

    [raw_B_data] = BusType_Init(raw_B_data,SIZE);

    V = zeros(1,SIZE,ITERATION);
    Delta = zeros(1,SIZE,ITERATION);
    P_G = zeros(1,SIZE,ITERATION);
    Q_G = zeros(1,SIZE,ITERATION);
    P_L = zeros(1,SIZE,ITERATION);
    Q_L = zeros(1,SIZE,ITERATION);
    Q_Gmax = zeros(1,SIZE);
    Q_Gmin = zeros(1,SIZE);
    Bus_Type = zeros(1,SIZE,ITERATION);
    Switch = zeros(1,SIZE);

    V(1,:,1) = transpose(raw_B_data(:,3));
    Delta(1,:,1) = transpose(raw_B_data(:,4));
    P_G(1,:,1) = transpose(raw_B_data(:,5));
    Q_G(1,:,1) = transpose(raw_B_data(:,6));
    P_L(1,:,1) = transpose(raw_B_data(:,7));
    Q_L(1,:,1) = transpose(raw_B_data(:,8));
    Q_Gmax(1,:) = transpose(raw_B_data(:,9));
    Q_Gmin(1,:) = transpose(raw_B_data(:,10));

    Switch_Sig = zeros(1,SIZE,ITERATION);
    Switch_Sig(1,:,:) = repmat(Switch,1,1,ITERATION);      % iteration시 정보 전달 조건

    Bus_Type(1,:,1) =  transpose(raw_B_data(:,2));
    Bus_Type(1,:,:) = repmat(Bus_Type(1,:,1),1,1,ITERATION);


    fprintf('[Bus Data]\n');
    fprintf('    Bus Num    Bus Type   V          Delta      P_G       Q_G     P_L      Q_L      Q_max      Q_min\n')
    fprintf('-----------------------------------------------------------------------------------------------------\n')
    disp(raw_B_data);
     
    P = P_G - P_L;
    Q = Q_G - Q_L;
end