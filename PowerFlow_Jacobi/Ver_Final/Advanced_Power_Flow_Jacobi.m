% Advanced Power Flow Capstone Project Team B (Jacobi Method)
% Main Code

clear; clc;

format short

fprintf('<2024-1학기 전기공학전공 자기설계학점 : Advanced Power Flow 캡스톤 프로젝트>\n');
fprintf('[융합전자공학과 201910906 이학민]\n\n');

% import Bus Data File
% bus_file = 'example6.10_bus.xlsx';
% bus_file = 'example6.38_bus.xlsx';
% bus_file = 'ieee5bus_bus.xlsx';
bus_file = 'ieee9bus_bus.xlsx';
% bus_file = 'ieee14bus_bus.xlsx';
% bus_file = 'ieee30bus_bus.xlsx';

if exist(bus_file, 'file')
    disp([bus_file ' 파일을 정상적으로 읽었습니다.']);
else
    disp('파일을 정상적으로 불러올 수 없어 프로그램을 종료합니다.');
end

% import Line Data File
% line_file = 'example6.10_line.xlsx';
% line_file = 'example6.38_line.xlsx';
% line_file = 'ieee5bus_line.xlsx';
line_file = 'ieee9bus_line.xlsx';
% line_file = 'ieee14bus_line.xlsx';
% line_file = 'ieee30bus_line.xlsx';

if exist(line_file, 'file')
    disp([line_file ' 파일을 정상적으로 읽었습니다.']);
else
    disp('파일을 정상적으로 불러올 수 없어 프로그램을 종료합니다.');
end

% ITERATION = input('Iteration Limit : ');
ITERATION = 1000;      % [Iteration-1] of Repeat

thd = input("\nThreshold Value of Approximate Relative Error[%] : ");
% thd = 0.0000001;        % Percent[%]

% Initialize Values
[SIZE,V,Delta,P,Q,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,Bus_Type,Switch_Sig] = Init_Value(bus_file,ITERATION);

% Set Line Data (Combination of TL & TR data)
[raw_L_data,L_data] = import_L_Data(line_file,SIZE);

% Y matrix Calculation
[Y,Ybus] = Y_Mat_Calc(SIZE,L_data);

% Unknowns Calculation (Jacobi Method)
[V,Delta,P,Q,Bus_Type,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,i,err_V,Switch_Sig] ...
    = Unknowns_Calc(SIZE,ITERATION,thd,Y,V,Delta,Bus_Type,P,Q,P_G,P_L,Q_G,Q_L,Q_Gmax,Q_Gmin,Switch_Sig);

% Print Results
[BusOutputData,LineOutputData] = Prt_Result(i,ITERATION,SIZE,Y,err_V,V,Delta,P_G,Q_G,P_L,Q_L,raw_L_data);

% Export Results to Excel File
export_Result(Ybus,BusOutputData,LineOutputData);