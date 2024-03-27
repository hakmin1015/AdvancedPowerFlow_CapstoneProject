% Slack(Swing) Bus Calculation

function [P,Q] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q)
    
    for n = 1:SIZE
        P(1,k,i+1) = P(1,k,i+1) + abs(Y(1,n))*V(1,n,i)*cos((Delta(1,n,i)+angle(Y(1,n)))*(pi/180));
    end

    for n = 1:SIZE
        Q(1,k,i+1) = Q(1,k,i+1) + abs(Y(1,n))*V(1,n,i)*sin((Delta(1,n,i)+angle(Y(1,n)))*(pi/180));
    end
    Q(1,k,i) = -Q(1,k,i);

end