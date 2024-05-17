% V,Delta,P,Q의 수렴 여부에 따라 Iteration을 중지하는 신호를 생성
% err에 Q 추가

function STOP = STOP_SIGNAL(i,err_V,err_Delta,err_Q,thd)

    if ( (err_V(1,:,i) < thd) & (err_Delta(1,:,i) < thd) & (err_Q(1,:,i) < thd) )
        STOP = 1;
    else
        STOP = 0;
    end

end