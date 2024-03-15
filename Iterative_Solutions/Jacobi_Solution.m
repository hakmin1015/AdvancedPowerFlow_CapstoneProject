% Iterative Solutions to Linear Algebraic Equations
% Jacobi Solution
% 240302

clear; clc;

tic
[A, init_A] = input_Matrix();   % 행렬을 입력받음    
% A -> Augmented / init_A -> not Augmented

[A, P, D] = Nonzero_Diagonal(A);   % D의 역행렬을 구하기 위한 절차1
% A -> 대각원소 nonzero / P -> 바뀐 순서에 대한 정보 / D -> 바뀐 A에 대한 대각행렬

[L_Mat, U_Mat, b_Mat] = LU_Decomposition_D(A, D);  % D의 역행렬을 구하기 위한 절차2

D_Inv = inverse_Matrix(L_Mat, U_Mat, P, D);        % D의 역행렬을 구하기 위한 절차3

Jacobi_Method(D_Inv, D, A);        % Jacobi Method를 통한 해 구하기
toc