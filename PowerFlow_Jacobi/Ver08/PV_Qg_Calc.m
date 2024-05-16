% Calculate PV Bus' Q_G
% PV Bus면 limit 수렴 여부에 상관 없이 무조건 테스트를 거쳐야 함.

function [Q,Q_L,Q_G] = PV_Qg_Calc(k,i,Y,V,Delta,Q_G,Q_L,Q,Q_Gmax,Q_Gmin,SIZE,Switch_Sig)

    Q_L(1,k,i+1) = Q_L(1,k,i);
                
    Sum_YVsin = 0;
    for n = 1:SIZE
        Sum_YVsin = Sum_YVsin + abs(Y(k,n)) * V(1,n,i) ...
                    * sin((Delta(1,k,i) - Delta(1,n,i) - angle(Y(k,n))*(180/pi)) * (pi/180));
    end
    
    switch Switch_Sig(1,k,i)   % i+1 전달 과정에서 덮어씌워지는거 방지, Gmax로 바뀐 위치를 기억해서 그 이후부터 바뀌도록 해야함.
        case 0
            Q(1,k,i+1) = V(1,k,i)*Sum_YVsin;
            Q_G(1,k,i+1) = Q(1,k,i+1) + Q_L(1,k,i+1);

        case 1
            Q_G(1,k,i+1) = Q_Gmin(1,k);
            Q(1,k,i+1) = Q_G(1,k,i+1) - Q_L(1,k,i+1);
            
        case 2
            Q_G(1,k,i+1) = Q_Gmax(1,k);
            Q(1,k,i+1) = Q_G(1,k,i+1) - Q_L(1,k,i+1);
    end
end