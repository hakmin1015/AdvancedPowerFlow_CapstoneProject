% PV(Gen) Bus Calculation  

function [Delta,V] = PV_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,Switch_Sig)

    I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i+1)) / (V(1,k,i)*exp(-sqrt(-1)*Delta(1,k,i)*(pi/180)));    % I_k = (P_k - jQ_k) / V_k(i)*
    
    Sum_YV_1 = 0;
    Sum_YV_2 = 0;
    
    for n = 1:k-1
        Sum_YV_1 = Sum_YV_1 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
    end
    
    for n = k+1:SIZE
        Sum_YV_2 = Sum_YV_2 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
    end
    
    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);    % k모선의 i번째 iteration 값 계산
    
    Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);
    if Switch_Sig == 0
        V(1,k,i+1) = V(1,k,i);  % V value never change if it's PV Bus
    else
        V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
    end
end