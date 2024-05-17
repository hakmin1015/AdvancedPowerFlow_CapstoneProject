% Line Flow Calculation

function LF_data = Line_Flow_Calc(L_Mat,i,V,Delta,Y)

    L_Mat = repelem(L_Mat,2,1);
    [rows,~] = size(L_Mat);
    
    LF_data = zeros(rows,6);     % Line Flow Data

    LF_data(:,1) = L_Mat(:,1);
    
    for j = 1:rows            % Bus to Bus
        if mod(j,2) == 0
            LF_data(j,2) = L_Mat(j,3);
            LF_data(j,3) = L_Mat(j,2);
        else 
            LF_data(j,2) = L_Mat(j,2);
            LF_data(j,3) = L_Mat(j,3);
        end
    end
    
    V_vector = V(1,:,i+1) .* exp(Delta(1,:,i+1)*(sqrt(-1)*(pi/180)));

    for j = 1:rows      % P, Q, S

        E = (V_vector(LF_data(j,2)) - V_vector(LF_data(j,3)));    % Vs - Vr
        I = conj(-1*Y(LF_data(j,2),LF_data(j,3)))*conj(E);
        S = V_vector(LF_data(j,2))*I + V_vector(LF_data(j,2))*conj(V_vector(LF_data(j,2))*(L_Mat(j,6)+L_Mat(j,7)*sqrt(-1))/2);

        LF_data(j,4) = real(S);     % P
        LF_data(j,5) = imag(S);     % Q
        LF_data(j,6) = abs(S);      % S
    end
end