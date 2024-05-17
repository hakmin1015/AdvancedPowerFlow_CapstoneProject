% Total Bus Calculation Module

function [V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Bus_Type,Switch_Sig] ...
            = Total_Bus_Calc(i,k,SIZE,Y,V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Bus_Type,Switch_Sig)

    switch Bus_Type(1,k,i)
        case 0  % For Slack Bus
            V(1,k,i+1) = V(1,k,i);  % V = 1R0 (초기 설정)을 계속 유지
            Delta(1,k,i+1) = Delta(1,k,i+1);
            P_L(1,k,i+1) = P_L(1,k,i);
            Q_L(1,k,i+1) = Q_L(1,k,i);

        case 1  % For PV Bus (Gen)
            [Q,Q_L,Q_G] = PV_Qg_Calc(k,i,Y,V,Delta,Q_G,Q_L,Q,Q_Gmax,Q_Gmin,SIZE,Switch_Sig);
            P(1,k,i+1) = P(1,k,i);  % P value not changed after iteration
            P_G(1,k,i+1) = P_G(1,k,i);
            P_L(1,k,i+1) = P_L(1,k,i);
            [Delta,V] = PV_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,Switch_Sig);

        case 2  % For PQ Bus (Load)
            P(1,k,i+1) = P(1,k,i);
            Q(1,k,i+1) = Q(1,k,i);      % P,Q values not changed after iteration
            P_G(1,k,i+1) = P_G(1,k,i);
            P_L(1,k,i+1) = P_L(1,k,i);
            Q_L(1,k,i+1) = Q_L(1,k,i);
            Q_G(1,k,i+1) = Q_G(1,k,i);

            [V,Delta] = PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);

        case 3   % For PV -> PQ Bus (for keep voltage value)
            P(1,k,i+1) = P(1,k,i);
            Q(1,k,i+1) = Q(1,k,i);      % P,Q values not changed after iteration
            P_G(1,k,i+1) = P_G(1,k,i);
            P_L(1,k,i+1) = P_L(1,k,i);
            Q_L(1,k,i+1) = Q_L(1,k,i);
            Q_G(1,k,i+1) = Q_G(1,k,i);

            [V,Delta] = PV2PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);
    end
end