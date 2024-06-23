% V의 수렴 여부에 따라 Iteration을 중지하는 신호를 생성

function STOP = STOP_SIGNAL(i,err_V,thd)

    if err_V(:,i) < thd
        STOP = 1;
    else
        STOP = 0;
    end

end