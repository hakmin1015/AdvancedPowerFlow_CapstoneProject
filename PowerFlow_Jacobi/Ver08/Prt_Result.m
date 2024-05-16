% Print Result

function Prt_Result(i,ITERATION,SIZE,Y,err_V,err_Delta,err_Q,V,Delta,P_G,Q_G,P_L,Q_L)

    if i == ITERATION
        fprintf('\nERROR : Bus Output Data does not converge\n');
    
    else
        fprintf('[Y Bus Matrix]\n');
        fprintf('-----------------------------------------------------------------------------------------------\n')
        disp(Y);

        fprintf('\n<Final Approximate Percent Relative Error>\n');
        fprintf('---------------------------------------------------------------------------\n')

        for k = 1:SIZE
            fprintf('err_V(Bus%d)=%f[%%] err_Delta(Bus%d)=%f[%%] err_Q(Bus%d)=%f[%%]\n', k, err_V(1,k,i), k, err_Delta(1,k,i), k, err_Q(1,k,i));
        end

        fprintf('\n<Bus Output Data for the Power System>\n\n');
        fprintf('  Bus# | Voltage Magnitude(p.u.) | Phase Angle(Deg) | P_G(p.u.) | Q_G(p.u.) | P_L(p.u.) | Q_L(p.u.)\n');
        fprintf('=====================================================================================================\n');
        
        for k = 1:SIZE
            fprintf('%4d   | %15.4f         | %12.4f     | %7.4f   | %7.4f   | %7.4f   | %7.4f\n', ...
                k,V(1,k,i+1),Delta(1,k,i+1), P_G(1,k,i+1),Q_G(1,k,i+1),P_L(1,k,i+1),Q_L(1,k,i+1));
            fprintf('-----------------------------------------------------------------------------------------------------\n');
        end
        fprintf('                ----- TOTAL -----                   | %7.4f   | %7.4f   | %7.4f   | %7.4f\n', ...
            sum(P_G(1,:,i+1)), sum(Q_G(1,:,i+1)), sum(P_L(1,:,i+1)), sum(Q_L(1,:,i+1)));
        fprintf('-----------------------------------------------------------------------------------------------------\n');

        % fprintf('\n<Line Output Data for the Power System>\n\n');
        % fprintf('  Line# | Bus to Bus | P | Q | S\n');
        % fprintf('=====================================================================================================\n');
    end
end