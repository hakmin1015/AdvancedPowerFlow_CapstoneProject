% Power Flow Calculation (Jacobi Method)
% Ver05 : Load Bus 전환이 되지 않는 코드
% Bus Type을 자동 구분하도록 개선해야함.

% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

format long;

% SIZE = input('Number of Bus : ');
SIZE = 5;           % Number of Bus

% ITERATION = input('Iteration Limit : ');
ITERATION = 600;      % [Iteration-1] 회 반복 수행함.

% thd = input(Threshold Value of Approximate Relative Error[%] : ");
thd = 0.00001;        % Percent[%]

% Input Transmission Line Data
TL_data = input_TL_Data(SIZE);

% Input Transformer Line Data
TR_data = input_TR_Data(SIZE);

% Y matrix Calculation
Y = Y_Mat_Calc(SIZE,TL_data,TR_data);

% Initial Value
[V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type] = Init_Value(SIZE,ITERATION);

% 모선 별 미지수 계산 (Jacobi Method)
[V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_P,err_Q] ...
    = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin);

% 출력
if i == ITERATION
    fprintf('ERROR : Bus Output Data does not converge\n');

else
    fprintf('\n<Bus Output Data for the Power System>\n\n');
    fprintf('  Bus# | Voltage Magnitude(p.u.) | Phase Angle(Deg) | P_G(p.u.) | Q_G(p.u.) | P_L(p.u.) | Q_L(p.u.)\n');
    fprintf('=====================================================================================================\n');
    for k = 1:SIZE
        fprintf('%4d   | %15.4f         | %12.4f     | %7.4f   | %7.4f   | %7.4f   | %7.4f\n', ...
            k,V(1,k,i+1),Delta(1,k,i+1), P_G(1,k,i+1),Q_G(1,k,i+1),P_L(1,k,i+1),Q_L(1,k,i+1));
        fprintf('-----------------------------------------------------------------------------------------------------\n');
    end
end