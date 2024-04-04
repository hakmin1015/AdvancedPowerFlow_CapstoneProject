% Power Flow Calculation (Jacobi Method)
% Ver06 : Q_G의 수렴값이 limit을 넘어가는 경우 PQ Bus로 전환하여 재계산하는 과정 추가
% Line 정보를 변압기 유무를 구분하지 않고 입력받도록 수정함.
% Bus Type을 자동 구분하도록 개선해야함.

% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

format long;

% SIZE = input('Number of Bus : ');
SIZE = 5;           % Number of Bus

% ITERATION = input('Iteration Limit : ');
ITERATION = 700;      % [Iteration-1] 회 반복 수행함.

% thd = input(Threshold Value of Approximate Relative Error[%] : ");
thd = 0.00001;        % Percent[%]

% Input Line Data (Combination of TL & TR data)
L_data = input_L_Data(SIZE);

% Y matrix Calculation
Y = Y_Mat_Calc(SIZE,L_data);

% Initial Value
[V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type,Switch_Sig] = Init_Value(SIZE,ITERATION);

% 모선 별 미지수 계산 (Jacobi Method)
[V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_Q,Switch_Sig] ...
    = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Switch_Sig);

% 출력
if i == ITERATION
    fprintf('\nERROR : Bus Output Data does not converge\n');

else
    fprintf('<Final Approximate Percent Relative Error>\n');
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
end