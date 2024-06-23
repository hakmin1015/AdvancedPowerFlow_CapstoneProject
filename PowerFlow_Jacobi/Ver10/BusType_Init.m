% BusType Initialization

function [raw_B_data] = BusType_Init(raw_B_data,SIZE)

    for i = 1:SIZE
        if isnan(raw_B_data(i,3)) && isnan(raw_B_data(i,4)) % PQ Bus
            raw_B_data(i,2) = 2;    % Bus Type
            raw_B_data(i,3) = 1.0;  % V
            raw_B_data(i,4) = 0;    % Phase
            raw_B_data(i,9) = 0; raw_B_data(i,10) = 0;  % Q_G limit

        elseif ~(isnan(raw_B_data(i,9)) || isnan(raw_B_data(i,10)))    % PV Bus
            raw_B_data(i,2) = 1;    % Bus Type
            raw_B_data(i,4) = 0;    % Phase

        else    % Slack Bus
            raw_B_data(i,2) = 0;    % Bus Type
            raw_B_data(i,5) = 0;    % P_G
            raw_B_data(i,6) = 0;    % Q_G
            raw_B_data(i,9) = 0; raw_B_data(i,10) = 0;  % Q_G limit
        end
    end

end