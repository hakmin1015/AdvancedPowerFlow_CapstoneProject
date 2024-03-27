% Calculate PV Bus' Q_G
% PV Bus면 limit 수렴 여부에 상관 없이 무조건 테스트를 거쳐야 함.

function [Q,Q_L] = PV_Qg_Calc(k,i,Y,V,Delta,Q_L,Q,SIZE)

    Q_L(1,k,i+1) = Q_L(1,k,i);
                
    Sum_YVsin = 0;
    for n = 1:SIZE
        Sum_YVsin = Sum_YVsin + abs(Y(k,n)) * V(1,n,i) ...
                    * sin((Delta(1,k,i) - Delta(1,n,i) - angle(Y(k,n))*(180/pi)) * (pi/180));
    end
    
    Q(1,k,i+1) = V(1,k,i)*Sum_YVsin;

end