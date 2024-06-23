% PV(Gen) Bus Calculation  

function [Delta,V] = PV_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q)

    I_k = (P(k,i)-sqrt(-1)*Q(k,i+1)) / (V(k,i)*exp(-sqrt(-1)*Delta(k,i)*(pi/180)));
    
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

    V(k,i+1) = V(k,i);  % V value never change if it's PV Bus
end