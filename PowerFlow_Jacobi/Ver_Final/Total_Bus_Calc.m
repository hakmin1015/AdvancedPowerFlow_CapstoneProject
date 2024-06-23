% Total Bus Calculation Module

function [V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Bus_Type,Switch_Sig] ...
            = Total_Bus_Calc(i,k,SIZE,Y,V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Bus_Type,Switch_Sig)

    switch Bus_Type(k,i)
        case 0  % For Slack Bus (Swing)
            V(k,i+1) = V(k,i);  % V = 1R0 (초기 설정)을 계속 유지
            Delta(k,i+1) = Delta(k,i+1);
            P_G(k,i+1) = P_G(k,i);
            Q_G(k,i+1) = Q_G(k,i);
            P_L(k,i+1) = P_L(k,i);
            Q_L(k,i+1) = Q_L(k,i);
            P(k,i+1) = P_G(k,i+1) - P_L(k,i+1);
            Q(k,i+1) = Q_G(k,i+1) - Q_L(k,i+1);

        case 1  % For PV Bus (Gen)
            [Q,Q_G,Q_L] = PV_Q_Calc(k,i,Y,V,Delta,Q_G,Q_L,Q,SIZE);
            P_G(k,i+1) = P_G(k,i);
            P_L(k,i+1) = P_L(k,i);
            P(k,i+1) = P_G(k,i+1) - P_L(k,i+1);

            [Delta,V] = PV_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);

        case 2  % For PQ Bus (Load)
            P_G(k,i+1) = P_G(k,i);
            P_L(k,i+1) = P_L(k,i);
            Q_G(k,i+1) = Q_G(k,i);
            Q_L(k,i+1) = Q_L(k,i);
            P(k,i+1) = P_G(k,i+1) - P_L(k,i+1);
            Q(k,i+1) = Q_G(k,i+1) - Q_L(k,i+1);

            [V,Delta] = PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);

        case 3   % For PV -> PQ Bus (for keep voltage value)
            P_G(k,i+1) = P_G(k,i);
            P_L(k,i+1) = P_L(k,i);
            Q_L(k,i+1) = Q_L(k,i);
            P(k,i+1) = P_G(k,i+1) - P_L(k,i+1);

            if Switch_Sig(k,i) == 1
                Q_G(k,i) = Q_Gmin(k,1);
                Q(k,i) = Q_G(k,i) - Q_L(k,i);
                Q_G(k,i+1) = Q_G(k,i);
                Q(k,i+1) = Q_G(k,i+1) - Q_L(k,i+1);

            elseif Switch_Sig(k,i) == 2
                Q_G(k,i) = Q_Gmax(k,1);
                Q(k,i) = Q_G(k,i) - Q_L(k,i);
                Q_G(k,i+1) = Q_G(k,i);
                Q(k,i+1) = Q_G(k,i+1) - Q_L(k,i+1);

            else
                Q_G(k,i+1) = Q_G(k,i);
                Q(k,i+1) = Q_G(k,i+1) - Q_L(k,i+1);
            end

            [V,Delta] = PV2PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);
    end
end