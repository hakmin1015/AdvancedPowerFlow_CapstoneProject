% Power Flow Calculation (Jacobi Method)
% Ver10
% Main Code에서 raw data file을 바꿀 수 있도록 코드 수정함.
% Line Output Data가 보여지도록 Line Flow 계산 과정을 추가함.

% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

format short

% ITERATION = input('Iteration Limit : ');
ITERATION = 500;      % [Iteration-1] of Repeat

% thd = input(Threshold Value of Approximate Relative Error[%] : ");
thd = 0.01;        % Percent[%]

% import Bus Data File
% bus_file = 'example6.10_bus.xlsx';
% bus_file = 'example6.38_bus.xlsx';
% bus_file = 'ieee5bus_bus.xlsx';
% bus_file = 'ieee9bus_bus.xlsx';
bus_file = 'ieee14bus_bus.xlsx';
% bus_file = 'ieee30bus_bus.xlsx';

% import Line Data File
% line_file = 'example6.10_line.xlsx';
% line_file = 'example6.38_line.xlsx';
% line_file = 'ieee5bus_line.xlsx';
% line_file = 'ieee9bus_line.xlsx';
line_file = 'ieee14bus_line.xlsx';
% line_file = 'ieee30bus_line.xlsx';

% Initialize Values
[SIZE,V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type,Switch_Sig] = Init_Value(bus_file,ITERATION);

% Set Line Data (Combination of TL & TR data)
[L_Mat,L_data] = import_L_Data(line_file,SIZE);

% Y matrix Calculation
Y = Y_Mat_Calc(SIZE,L_data);

% Bus Unknowns Calculation (Jacobi Method)
[V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_Q,Switch_Sig] ...
    = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Switch_Sig);

% Print Result
Prt_Result(i,ITERATION,SIZE,Y,err_V,err_Delta,err_Q,V,Delta,P_G,Q_G,P_L,Q_L,L_Mat);