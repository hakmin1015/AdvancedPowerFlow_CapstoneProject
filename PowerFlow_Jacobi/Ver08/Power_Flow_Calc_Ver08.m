% Power Flow Calculation (Jacobi Method)
% Ver08
% PV Bus가 여러 개일 때 Bus Switching이 정상적으로 동작하도록 코드를 수정.
% raw data의 정보로부터 Bus Type을 자동으로 구분하도록 코드를 추가.

% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

format short

% ITERATION = input('Iteration Limit : ');
ITERATION = 300;      % [Iteration-1] of Repeat

% thd = input(Threshold Value of Approximate Relative Error[%] : ");
thd = 0.01;        % Percent[%]

% Initial Value
[SIZE,V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type,Switch_Sig] = Init_Value(ITERATION);

% Import Line Data (Combination of TL & TR data)
L_data = import_L_Data(SIZE);

% Y matrix Calculation
Y = Y_Mat_Calc(SIZE,L_data);

% Bus Unknowns Calculation (Jacobi Method)
[V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_Q,Switch_Sig] ...
    = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Switch_Sig);

% Print Result
Prt_Result(i,ITERATION,SIZE,Y,err_V,err_Delta,err_Q,V,Delta,P_G,Q_G,P_L,Q_L);

