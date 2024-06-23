% Unknowns Calculation using Jacobi Method

function [V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,Switch_Sig] ...
    = Unknowns_Calc(SIZE,ITERATION,thd,Y,V,Delta,Bus_Type,P,Q,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Switch_Sig)
    
    Recal = 0;

    for i = 1:ITERATION

        if i == ITERATION
            break;
        end
    
        for k = 1:SIZE      % Bus1 ~ Bus(SIZE)
            [V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Bus_Type,Switch_Sig] ...
            = Total_Bus_Calc(i,k,SIZE,Y,V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Bus_Type,Switch_Sig);
        end
        
        err_V = Error_Calc(SIZE,ITERATION,i,V);
        STOP = STOP_SIGNAL(i,err_V,thd);

        if STOP == 1            % STOP signal이 발생하면 Slack Bus의 P,Q를 계산
            for k = 1:SIZE
                if Bus_Type(k,i+1) == 0
                    [P,Q,P_G,Q_G] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,P_G,Q_G,P_L,Q_L);
                end
            end
            
            for k = 1:SIZE          % Q_G limit 벗어날 시 PQ Bus 전환 계산
                if Bus_Type(k,i+1) == 1 & (Q_G(k,i+1) < Q_Gmin(k,1) | Q_G(k,i+1) > Q_Gmax(k,1))  % PV Bus에만 적용, 최종 결과의 Q_G 수렴 여부를 판단
                    Recal = 1;
                    for n = 1:ITERATION
                        if Q_G(k,n) < Q_Gmin(k,1)   % Bus별 Q_G의 min limit 미만 최초 위치를 찾음
                            Switch_Sig(k,n-1) = 1;
                            Bus_Type(k,n-1:ITERATION) = 3;  % Load Bus로 전환
                            break;

                        elseif Q_G(k,n) > Q_Gmax(k,1) % Bus별 Q_G의 max limit 초과 최초 위치를 찾음
                            Switch_Sig(k,n-1) = 2;
                            Bus_Type(k,n-1:ITERATION) = 3;  % Load Bus로 전환
                            break;
                        end
                    end
                end
            end
            break;
        end
    end

    if Recal == 1
        
        for i = 1:ITERATION     % 바뀐 Bus Type으로 재계산
    
            if i == ITERATION
                break;
            end
        
            for k = 1:SIZE      % Bus1 ~ Bus(SIZE)
                [V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Bus_Type,Switch_Sig] ...
                    = Total_Bus_Calc(i,k,SIZE,Y,V,Delta,P,Q,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Bus_Type,Switch_Sig);
            end
            
            err_V = Error_Calc(SIZE,ITERATION,i,V);
            STOP2 = STOP_SIGNAL(i,err_V,thd);
    
            if STOP2 == 1            % STOP signal이 발생하면 Slack Bus의 P,Q를 계산
                for k = 1:SIZE
                    if Bus_Type(k,i+1) == 0
                        [P,Q,P_G,Q_G] = Slack_Bus_Calc(SIZE,k,i,Y,V,Delta,P,Q,P_G,Q_G,P_L,Q_L);
                    end
                end
                break;
            end
        end
    end
end