% Switching Bus

function [V,Delta,P,Q,Q_L,Bus_Type] = Switching_Bus(SIZE,k,i,Y,V,Delta,P,Q,Q_L,Q_Gmax,Q_Gmin,Bus_Type)

    [Q,Q_L] = PV_Qg_Calc(k,i,Y,V,Delta,Q_L,Q,SIZE);
    
    if Q(1,k,i+1) + Q_L(1,k,i+1) > Q_Gmax(1,k)     % Gmax 초과

        P(1,k,i+1) = P(1,k,i);   % P value not changed after iteration
        Q(1,k,i) = Q_Gmax(1,k);
        Q(1,k,i+1) = Q_Gmax(1,k);
        Bus_Type(1,k,i+1) = 2;      % PQ Bus로 전환

        [V,Delta] = PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);
        
    elseif Q(1,k,i+1) + Q_L(1,k,i+1) < Q_Gmin(1,k) % Gmin 미만

        P(1,k,i+1) = P(1,k,i);   % P value not changed after iteration
        Q(1,k,i+1) = Q_Gmin(1,k);
        Bus_Type(1,k,i+1) = 2;      % PQ Bus로 전환

        [V,Delta] = PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);
    
    else    % PV Bus 조건이 유지될 때
        V(1,k,i+1) = V(1,k,i);  % V is fixed value
        P(1,k,i+1) = P(1,k,i);  % P value not changed after iteration
        Bus_Type(1,k,i+1) = Bus_Type(1,k,i);
        
        [Delta,Q] = PV_Bus_Calc(k,i,V,Delta,P,Q);
    end

end