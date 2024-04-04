% Slack(Swing) Bus Calculation

function [P,Q,P_G,Q_G] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,P_G,Q_G,P_L,Q_L)

    for n = 1:SIZE
        P(1,k,i+1) = P(1,k,i+1) + abs(Y(1,n))*V(1,n,i+1)*cos((Delta(1,n,i+1)+angle(Y(1,n))*(180/pi))*(pi/180));
    end

    for n = 1:SIZE
        Q(1,k,i+1) = Q(1,k,i+1) + abs(Y(1,n))*V(1,n,i+1)*sin((Delta(1,n,i+1)+angle(Y(1,n))*(180/pi))*(pi/180));
    end
    Q(1,k,i+1) = -Q(1,k,i+1);

    P_G(1,k,i+1) = P(1,k,i+1) - P_L(1,k,i+1);
    Q_G(1,k,i+1) = Q(1,k,i+1) - Q_L(1,k,i+1);

end