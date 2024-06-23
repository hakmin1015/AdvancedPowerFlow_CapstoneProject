% Slack(Swing) Bus Calculation

function [P,Q,P_G,Q_G] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,P_G,Q_G,P_L,Q_L)

    for n = 1:SIZE
        P(k,i+1) = P(k,i+1) + V(k,1)*abs(Y(1,n))*V(n,i+1)*cos((Delta(n,i+1)+angle(Y(1,n))*(180/pi))*(pi/180));
    end

    for n = 1:SIZE
        Q(k,i+1) = Q(k,i+1) + V(k,1)*abs(Y(1,n))*V(n,i+1)*sin((Delta(n,i+1)+angle(Y(1,n))*(180/pi))*(pi/180));
    end
    Q(k,i+1) = -Q(k,i+1);

    P_G(k,i+1) = P(k,i+1) - P_L(k,i+1);
    Q_G(k,i+1) = Q(k,i+1) - Q_L(k,i+1);

end