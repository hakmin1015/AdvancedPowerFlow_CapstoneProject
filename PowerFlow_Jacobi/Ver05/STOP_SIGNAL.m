% V,Delta,P,Q의 수렴 여부에 따라 Iteration을 중지하는 신호를 생성

function STOP = STOP_SIGNAL(i,SIZE,err_V,err_Delta,err_P,err_Q,thd)

    if ( (err_V(1,:,i) < thd) & (err_Delta(1,:,i) < thd) & (err_P(1,:,i) < thd) & (err_Q(1,:,i) < thd) )
            STOP = 1;
            fprintf('<Final Approximate Percent Relative Error>\n');
            for k = 1:SIZE
                fprintf('err_V(Bus%d)=%f[%%] err_Delta(Bus%d)=%f[%%] err_P(Bus%d)=%f[%%] err_Q(Bus%d)=%f[%%]\n', k, err_V(1,k,i), k, err_Delta(1,k,i), k, err_P(1,k,i), k, err_Q(1,k,i));
            end
    else
        STOP = 0;
    end

end