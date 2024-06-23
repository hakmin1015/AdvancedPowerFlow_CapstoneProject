% Calculate PV Bus' Q

function [Q,Q_G,Q_L] = PV_Q_Calc(k,i,Y,V,Delta,Q_G,Q_L,Q,SIZE)

    Sum_YVsin = 0;
    for n = 1:SIZE
        Sum_YVsin = Sum_YVsin + abs(Y(k,n)) * V(n,i) ...
                    * sin((Delta(k,i) - Delta(n,i) - angle(Y(k,n))*(180/pi)) * (pi/180));
    end

    Q(k,i+1) = V(k,i) * Sum_YVsin;
    Q_L(k,i+1) = Q_L(k,i);
    Q_G(k,i+1) = Q(k,i+1) + Q_L(k,i+1);

end

