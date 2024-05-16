% Calculation of Approximate Percent Relative Error

function [err_V, err_Delta,err_Q] = Error_Calc(SIZE,ITERATION,i,V,Delta,Q)

    err_V = Approximate_Relative_Error(SIZE,ITERATION,i,V);
    err_Delta = Approximate_Relative_Error(SIZE,ITERATION,i,Delta);
    err_Q = Approximate_Relative_Error(SIZE,ITERATION,i,Q);
    
    % fprintf('<Error of %d Iteration>\n',i);     % 매 Iteration마다 근사백분율상대오차를 표시해줌
    % 
    % for k = 1:SIZE
    %     fprintf('<Bus%d>\n',k);
    %     fprintf('err_V(Bus%d)=%f[%%] err_Delta(Bus%d)=%f[%%] err_Q(Bus%d)=%f[%%]\n', k, err_V(1,k,i), k, err_Delta(1,k,i), k, err_Q(1,k,i), k);
    % end
    % 
    % fprintf('===============================================================================================\n\n');

end