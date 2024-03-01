% 240301
% Matrix Calculation

clear; clc;

[M, init_A] = input_Matrix();   % 1. 행렬을 입력받음

[M, P] = Nonzero_Diagonal(M);   % 2. 대각원소에 0이 있지 않도록 행 순서 교환

[M, P, L_Mat, U_Mat, b_Mat] = LU_Decomposition(M, P);   % 3. Partial Pivoting + REF + LU 분해

[M, sol] = calc_Solution(M, L_Mat, U_Mat, b_Mat);       % 4. LU Decomposition 결과를 이용하여 해를 계산

inverse_Matrix(L_Mat, U_Mat, P, init_A);        % 5. LU Decomposition 결과를 이용한 역행렬 계산