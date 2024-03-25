% Power Flow Calculation (Jacobi Method)
% Ver02 : 모선 별 초기값 지정 코드 추가
% Bus Type을 자동 구분하도록 개선해야 함.


% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

% SIZE = input('Number of Bus : ');
% ITERATION = input('Iteration Limit : ');

SIZE = 5;           % Number of Bus
ITERATION = 3;      % 실제 Iteration은 얼마나 갈지 모르니까 나중에 없애야 함. 3차원 배열 크기 지정X, 경고문 무시
key = 1;

% Transmission Line Input Data      
% Bus2Bus / R'pu / X'pu / G'pu / B'pu / Maximum MVA pu

TL_data = zeros(SIZE,5,SIZE);          % #RowsofData = (SIZE)*(SIZE)

% 추후 엑셀에서 자동으로 데이터 불러오는 방식 적용 예정
% while(1)
%     fprintf('[Input Transmission Line Data]\n');
%     Bus_from = input('Bus(from) : ');
%     Bus_to = input('Bus(to) : ');
%     TL = zeros(1,5);
%     fprintf('\n<Bus%d to Bus%d TL data>\n', Bus_from, Bus_to);
% 
%     for i=1:5
%         switch i
%             case 1
%                 TL(1,i) = input('R''pu : ');
%             case 2
%                 TL(1,i) = input('X''pu : ');
%             case 3
%                 TL(1,i) = input('G''pu : ');
%             case 4
%                 TL(1,i) = input('B''pu : ');
%             case 5
%                 TL(1,i) = input('Max_MVA_pu : ');
%         end
%         TL_data(Bus_from,:,Bus_to) = TL(1,:);
%         TL_data(Bus_to,:,Bus_from) = TL(1,:);
%     end  
% 
%     fprintf('\n');
%     key = input('Transmission Line data를 계속 입력하시겠습니까? (Yes : 1, No : 0) : ');
%     fprintf('\n');
% 
%     if key==0
%         break;
%     end
% end
% 
% key = 1;        % key값 원상복구

% Transformer Input Data
TR_data = zeros(SIZE,6,SIZE);

% while(1)
%     fprintf('[Input Transformer Data]\n');
%     Bus_from = input('Bus(from) : ');
%     Bus_to = input('Bus(to) : ');
%     TR = zeros(1,6);
%     fprintf('\n<Bus%d to Bus%d TR data>\n', Bus_from, Bus_to);
% 
%     for i=1:6
%         switch i
%             case 1
%                 TR(1,i) = input('Rpu : ');
%             case 2
%                 TR(1,i) = input('Xpu : ');
%             case 3
%                 TR(1,i) = input('Gc_pu : ');
%             case 4
%                 TR(1,i) = input('Bm_pu : ');
%             case 5
%                 TR(1,i) = input('Max_MVA_pu : ');
%             case 6
%                 TR(1,i) = input('Max_TAP_setting_pu : ');
%         end
%         TR_data(Bus_from,:,Bus_to) = TR(1,:);
%         TR_data(Bus_to,:,Bus_from) = TR(1,:);
%     end
% 
%     fprintf('\n');
%     key = input('Transformer data를 계속 입력하시겠습니까? (Yes : 1, No : 0) : ');
%     fprintf('\n');
% 
%     if key==0
%         break;
%     end
% end
% 
% key = 1;

TL_data(2,:,4) = [0.009 0.1 0 1.72 12.0];
TL_data(4,:,2) = [0.009 0.1 0 1.72 12.0];
TL_data(2,:,5) = [0.0045 0.05 0 0.88 12.0];
TL_data(5,:,2) = [0.0045 0.05 0 0.88 12.0];
TL_data(4,:,5) = [0.00225 0.025 0 0.44 12.0];
TL_data(5,:,4) = [0.00225 0.025 0 0.44 12.0];

TR_data(1,:,5) = [0.0015 0.02 0 0 6.0 0];
TR_data(5,:,1) = [0.0015 0.02 0 0 6.0 0];
TR_data(3,:,4) = [0.00075 0.01 0 0 10.0 0];
TR_data(4,:,3) = [0.00075 0.01 0 0 10.0 0];

% Y matrix Calculation

Y = zeros(SIZE);

for i = 1:SIZE          % Diagonal elements
    for j = 1:SIZE
        if i==j
            for k = 1:SIZE
                if complex(TL_data(i,1,k),TL_data(i,2,k)) ~= 0
                    Y(i,j) = Y(i,j) + 1/complex(TL_data(i,1,k),TL_data(i,2,k));

                elseif complex(TR_data(i,1,k),TR_data(i,2,k)) ~= 0
                    Y(i,j) = Y(i,j) + 1/complex(TR_data(i,1,k),TR_data(i,2,k));

                elseif complex(TL_data(i,1,k),TL_data(i,2,k)) ~= 0 && complex(TR_data(i,1,k),TR_data(i,2,k)) ~= 0
                    Y(i,j) = Y(i,j) + 1/complex(TL_data(i,1,k),TL_data(i,2,k)) + 1/complex(TR_data(i,1,k),TR_data(i,2,k));
                end
                Y(i,j) = Y(i,j) + complex(TL_data(i,3,k),TL_data(i,4,k))/2;
            end

        else          % Off-diagonal elements
            if complex(TL_data(i,1,j),TL_data(i,2,j)) ~= 0
                Y(i,j) = -(1/complex(TL_data(i,1,j),TL_data(i,2,j)));

            elseif complex(TR_data(i,1,j),TR_data(i,2,j)) ~= 0
                Y(i,j) = -(1/complex(TR_data(i,1,j),TR_data(i,2,j)));

            elseif complex(TL_data(i,1,j),TL_data(i,2,j)) ~= 0 && complex(TR_data(i,1,j),TR_data(i,2,j)) ~= 0
                Y(i,j) = -(1/complex(TL_data(i,1,j),TL_data(i,2,j)) + 1/complex(TR_data(i,1,j),TR_data(i,2,j)));

            else
                Y(i,j) = 0;
            end
        end
    end
end

% Initial Value                                  % Bus별로 Unknowns가 다르므로 Type별 구분 필요
% fprintf('\n[Initial Value of Voltage(V)]\n');
% V = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     V(1,i,1) = input(sprintf('V%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of Degree(Delta)]\n');
% Delta = zeros(1,SIZE,ITERATION);    % 각도에 대한 초기값은 전부 0인 상태
% 
% for i = 1:SIZE
%     Delta(1,i,1) = input(sprintf('Delta%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of P_Gen]\n');
% P_G = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     P_G(1,i,1) = input(sprintf('P_G%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of Q_Gen]\n');
% Q_G = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     Q_G(1,i,1) = input(sprintf('Q_G%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of P_Load]\n');
% P_L = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     P_L(1,i,1) = input(sprintf('P_L%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of Q_Load]\n');
% Q_L = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     Q_L(1,i,1) = input(sprintf('Q_L%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of Q_Gmax]\n');
% Q_Gmax = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     Q_Gmax(1,i,1) = input(sprintf('Q_Gmax%d(0) : ',i));
% end
% 
% fprintf('\n[Initial Value of Q_Gmin]\n');
% Q_Gmin = zeros(1,SIZE,ITERATION);
% 
% for i = 1:SIZE
%     Q_Gmin(1,i,1) = input(sprintf('Q_Gmin%d(0) : ',i));
% end

V(1,:,1) = [1 1 1.05 1 1];
Delta(1,:,1) = [0 0 0 0 0];
P_G(1,:,1) = [4 0 5.2 0 0];     % [0 0 5.2 0 0] 원래는 4로 입력 받으나 Slack Bus 지정 후 0으로 바뀌도록 구조화
Q_G(1,:,1) = [0 0 0 0 0];
P_L(1,:,1) = [0 8 0.8 0 0];
Q_L(1,:,1) = [0 0 4.0 0 0];
Q_Gmax(1,:,1) = [0 0 4.0 0 0];
Q_Gmin(1,:,1) = [0 0 -2.8 0 0];

fprintf('\n[Bus Type]\n');
Bus_Type = zeros(1,SIZE,ITERATION);

for i = 1:SIZE
    Bus_Type(1,i,1) =  input(sprintf('Bus%d (Slack : 0, Gen(PV) : 1, Load(PQ) : 2) : ',i));

    switch Bus_Type(1,i,1)      % Initialize
        case 0      % Slack Bus : V = 1R0, P_G, Q_G = Unknowns(0), P_L, Q_L = 0, Q_Gmax,min = 0 
            V(1,i,1) = 1;
            Delta(1,i,1) = 0;
            P_G(1,i,1) = 0;
            Q_G(1,i,1) = 0;
            P_L(1,i,1) = 0;
            Q_L(1,i,1) = 0;
            Q_Gmax(1,i,1) = 0;
            Q_Gmin(1,i,1) = 0;

        case 1      % PV Bus (Gen)
            Delta(1,i,1) = 0;
            Q_G(1,i,1) = 0;

        case 2      % PQ Bus (Load)
            V(1,i,1) = 0;
            Delta(1,i,1) = 0;
    end
end

P = P_G - P_L;
Q = Q_G - Q_L;