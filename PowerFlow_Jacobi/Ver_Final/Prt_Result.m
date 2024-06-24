% Print Result

function [BusOutputData,LineOutputData] = Prt_Result(i,ITERATION,SIZE,Y,err_V,V,Delta,P_G,Q_G,P_L,Q_L,raw_L_data)

    if i == ITERATION
        fprintf('\nERROR : Bus Output Data does not converge\n');
    
    else
        fprintf('[Y Bus Matrix]\n');
        fprintf('-----------------------------------------------------------------------------------------------\n')
        disp(Y);

        fprintf('\n<Final Approximate Percent Relative Error>\n');
        fprintf('--------------------------------------------\n')

        for k = 1:SIZE
            fprintf('err_V(Bus%d) = %.10f[%%]\n', k, err_V(k,i));
        end

        fprintf('\n<Bus Output Data for the Power System>\n\n');
        fprintf('  Bus# | Voltage Magnitude(p.u.) | Phase Angle(Deg) | P_G(p.u.) | Q_G(p.u.) | P_L(p.u.) | Q_L(p.u.)\n');
        fprintf('=====================================================================================================\n');
        
        BusOutputData = zeros(SIZE,7);

        for k = 1:SIZE
            for n = 1:7
                switch n
                    case 1
                        BusOutputData(k,n) = k;
                    case 2
                        BusOutputData(k,n) = V(k,i+1);
                    case 3
                        BusOutputData(k,n) = Delta(k,i+1);
                    case 4
                        BusOutputData(k,n) = P_G(k,i+1);
                    case 5
                        BusOutputData(k,n) = Q_G(k,i+1);
                    case 6
                        BusOutputData(k,n) = P_L(k,i+1);
                    case 7
                        BusOutputData(k,n) = Q_L(k,i+1);
                end
            end
            fprintf('%4d   | %15.4f         | %12.4f     | %7.4f   | %7.4f   | %7.4f   | %7.4f\n', BusOutputData(k,:));
            fprintf('-----------------------------------------------------------------------------------------------------\n');
        end
        fprintf('                ----- TOTAL -----                   | %7.4f   | %7.4f   | %7.4f   | %7.4f\n', ...
            sum(P_G(:,i+1)), sum(Q_G(:,i+1)), sum(P_L(:,i+1)), sum(Q_L(:,i+1)));
        fprintf('-----------------------------------------------------------------------------------------------------\n');
        
        LineOutputData = Line_Flow_Calc(raw_L_data,i,V,Delta,Y);
        
        fprintf('\n<Line Output Data for the Power System>\n\n');
        fprintf('   Line#   |   Bus to Bus   |        P        |        Q        |       S\n');
        fprintf('================================================================================\n');
        fprintf('  %4d     |%5d  %5d    |     %7.4f     |     %7.4f     |    %7.4f\n', transpose(LineOutputData));

        fprintf('--------------------------------------------------------------------------------\n');
    end

    % x모선의 n번째 iteration 결과
    values = input('\nx모선의 n번째 iteration 결과(x,n) / (0,0)을 눌러 종료 : ', 's');
    
    % 쉼표를 기준으로 입력 문자열을 분리
    split_values = strsplit(values, ',');
    x = str2double(split_values{1});
    n = str2double(split_values{2});

    if x == 0 & n == 0
        fprintf('프로그램을 종료합니다.\n');
    elseif (x<1 | x>SIZE) | (n<0 | n>i)
        fprintf('정보를 잘못 입력하였습니다. 프로그램을 종료합니다.\n');
    else
        fprintf('\n<%d모선의 %d번째 iteration 결과>\n',x,n);
        fprintf('Voltage Magnitude(p.u.) | Phase Angle(Deg) |   P(p.u.)   |   Q(p.u.)\n');
        fprintf('%15.4f         | %11.4f      |   %7.4f   |   %7.4f\n',V(x,n+1),Delta(x,n+1), P_G(x,n+1)-P_L(x,n+1),Q_G(x,n+1)-Q_L(x,n+1));
    end
end
