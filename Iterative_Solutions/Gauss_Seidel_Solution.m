% Iterative Solutions to Linear Algebraic Equations
% Gauss-Seidel Solution
% 240310

clear; clc;

tic
[A, init_A] = input_Matrix();   % 행렬을 입력받음    
% A -> Augmented / init_A -> not Augmented

[A, L] = Nonzero_Diagonal_GS(A);   % D의 역행렬을 구하기 위한 절차1
% A -> 대각원소 nonzero / L -> 바뀐 A에 대한 Lower Triangular Portion

[A, P, L_Mat, U_Mat, b_Mat] = LU_Decomposition_L(A, L);  % L의 역행렬을 구하기 위한 절차2

L_Inv = inverse_Matrix_GS(L_Mat, U_Mat, P, L);        % L의 역행렬을 구하기 위한 절차3

Gauss_Seidel_Method(L_Inv, L, A);        % Gauss-Seidel Method를 통한 해 구하기
toc