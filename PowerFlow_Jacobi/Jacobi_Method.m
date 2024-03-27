% Jacobi Method

function [V,Delta,P,Q,Bus_Type,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_P,err_Q] = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,Q_L,Q_Gmax,Q_Gmin)

    for i = 1:ITERATION

        if i == ITERATION       % Q Bus 수렴 여부 판단 / 모두 발산하면 연산불가처리, Q만 발산하면 Load Bus로 전환 실시
            break;
        end
    
        for k = 1:SIZE      % Bus1 ~ Bus(SIZE)
            switch Bus_Type(1,k,i)
                case 0  % For Slack Bus
                    V(1,k,i+1) = V(1,k,i);  % V = 1R0 (초기 설정)을 계속 유지
                    P(1,k,i+1) = P(1,k,i);
                    Q(1,k,i+1) = Q(1,k,i);
                    Bus_Type(1,k,i+1) = Bus_Type(1,k,i);
    
                case 1  % For PV Bus (Gen)
                    [V,Delta,P,Q,Q_L,Bus_Type] = Switching_Bus(SIZE,k,i,Y,V,Delta,P,Q,Q_L,Q_Gmax,Q_Gmin,Bus_Type);
    
                case 2  % For PQ Bus (Load)
                    P(1,k,i+1) = P(1,k,i);
                    Q(1,k,i+1) = Q(1,k,i);      % P,Q values not changed after iteration
                    Bus_Type(1,k,i+1) = Bus_Type(1,k,i);
    
                    [V,Delta] = PQ_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);
            end
        end
        
        [err_V, err_Delta, err_P, err_Q] = Error_Calc(SIZE,ITERATION,i,V,Delta,P,Q);
        STOP = STOP_SIGNAL(i,SIZE,err_V,err_Delta,err_P,err_Q,thd);

        if STOP == 1            % STOP signal이 발생하면 Slack Bus의 P,Q를 계산
            for k = 1:SIZE
                if Bus_Type(1,k,i) == 0
                    [P,Q] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q);
                end
            end
            break;
        end

    end
end