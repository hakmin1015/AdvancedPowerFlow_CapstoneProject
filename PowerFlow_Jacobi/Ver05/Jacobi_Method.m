% Jacobi Method

function [V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_P,err_Q] ...
    = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin)

    for i = 1:ITERATION

        if i == ITERATION       % Q Bus 수렴 여부 판단 / 모두 발산하면 연산불가처리, Q만 발산하면 Load Bus로 전환 실시
            break;
        end
    
        for k = 1:SIZE      % Bus1 ~ Bus(SIZE)
            [V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Bus_Type] = Total_Bus_Calc(i,k,SIZE,Y,V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Bus_Type);
        end
        
        [err_V, err_Delta, err_P, err_Q] = Error_Calc(SIZE,ITERATION,i,V,Delta,P,Q);
        STOP = STOP_SIGNAL(i,SIZE,err_V,err_Delta,err_P,err_Q,thd);

        if STOP == 1            % STOP signal이 발생하면 Slack Bus의 P,Q를 계산
            for k = 1:SIZE
                if Bus_Type(1,k,i+1) == 0
                    [P,Q,P_G,Q_G] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,P_G,Q_G,P_L,Q_L);
                end
            end
            break;
        end
    end
end