% PV->PQ Bus Calculation

function [V,Delta] = PV2PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q)

    I_k = (P(k,i)-sqrt(-1)*Q(k,i)) / (V(k,i)*exp(-sqrt(-1)*Delta(k,i)*(pi/180)));
    
    Sum_YV_1 = 0;
    Sum_YV_2 = 0;
    
    for n = 1:k-1
        Sum_YV_1 = Sum_YV_1 + Y(k,n) * (V(n,i)*exp(sqrt(-1)*Delta(n,i)*(pi/180)));
    end
    
    for n = k+1:SIZE
        Sum_YV_2 = Sum_YV_2 + Y(k,n) * (V(n,i)*exp(sqrt(-1)*Delta(n,i)*(pi/180)));
    end
    
    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);    % k모선의 i번째 iteration 값 계산
    Delta(k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);
    V(k,i+1) = V(k,i);  % 원래 PV Bus였으면 PQ Bus로 전환되었다고해도 전압은 유지되어야 함.
    
    % Recalculation
    I_k = (P(k,i)-sqrt(-1)*Q(k,i)) / (V(k,i+1)*exp(-sqrt(-1)*Delta(k,i+1)*(pi/180)));
    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);
    Delta(k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);

end