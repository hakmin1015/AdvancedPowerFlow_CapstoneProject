% Power Flow Calculation (Jacobi Method)
% Ver07 : 결과 출력 부분 모듈화, excel raw data에서 Line, Bus data를 불러오도록 개선함.
% Base 정보를 바탕으로 Real Value를 계산해야 함.

% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

format short

% ITERATION = input('Iteration Limit : ');
ITERATION = 300;      % [Iteration-1] of Repeat

% thd = input(Threshold Value of Approximate Relative Error[%] : ");
thd = 0.001;        % Percent[%]

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