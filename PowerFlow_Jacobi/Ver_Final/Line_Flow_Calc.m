% Line Flow Calculation

function LineOutputData = Line_Flow_Calc(L_Mat,i,V,Delta,Y)

    L_Mat = repelem(L_Mat,2,1);
    [rows,~] = size(L_Mat);
    
    LineOutputData = zeros(rows,6);     % Line Flow Data

    LineOutputData(:,1) = L_Mat(:,1);
    
    for j = 1:rows            % Bus to Bus
        if mod(j,2) == 0
            LineOutputData(j,2) = L_Mat(j,3);
            LineOutputData(j,3) = L_Mat(j,2);
        else 
            LineOutputData(j,2) = L_Mat(j,2);
            LineOutputData(j,3) = L_Mat(j,3);
        end
    end
    
    V_vector = V(:,i+1) .* exp(Delta(:,i+1)*(sqrt(-1)*(pi/180)));

    for j = 1:rows      % P, Q, S

        E = (V_vector(LineOutputData(j,2)) - V_vector(LineOutputData(j,3)));    % Vs - Vr
        I = conj(-1*Y(LineOutputData(j,2),LineOutputData(j,3)))*conj(E);
        S = V_vector(LineOutputData(j,2))*I + V_vector(LineOutputData(j,2))*conj(V_vector(LineOutputData(j,2))*(L_Mat(j,6)+L_Mat(j,7)*sqrt(-1))/2);

        LineOutputData(j,4) = real(S);     % P
        LineOutputData(j,5) = imag(S);     % Q
        LineOutputData(j,6) = abs(S);      % S
    end
end