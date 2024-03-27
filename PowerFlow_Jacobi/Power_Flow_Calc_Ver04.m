% Power Flow Calculation (Jacobi Method)
% Ver04 : 모듈화 진행 완료
% Bus Type을 자동 구분하도록 개선해야 함.
% Load Bus 전환이 즉시 이루어지도록 설계한 코드(수렴값에 따라 움직이도록 수정 필요)

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
thd = 0.0001;        % Percent

% Input Transmission Line Data
TL_data = input_TL_Data(SIZE);

% Input Transformer Line Data
TR_data = input_TR_Data(SIZE);

% Y matrix Calculation
Y = Y_Mat_Calc(SIZE,TL_data,TR_data);

% Initial Value
[V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type] = Init_Value(SIZE,ITERATION);

tic
% 모선 별 미지수 계산 (Jacobi Method)
[V,Delta,P,Q,Bus_Type,Q_L,Q_Gmax,Q_Gmin,i,err_V,err_Delta,err_P,err_Q] = Jacobi_Method(SIZE,ITERATION,thd,Y,V,Delta,P,Q,Bus_Type,Q_L,Q_Gmax,Q_Gmin);
toc