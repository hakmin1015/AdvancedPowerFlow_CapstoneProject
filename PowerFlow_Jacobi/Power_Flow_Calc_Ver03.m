% Power Flow Calculation (Jacobi Method)
% Ver03 : 모선 별 미지수 값 계산 코드
% Bus Type을 자동 구분하도록 개선해야 함.
% 모선 계산 과정 모듈화 필요.
% Load Bus 전환이 즉시 이루어지도록 설계한 코드(수렴값에 따라 움직이도록 수정 필요)


% S_base = 100[MVA]
% V_base = 15[kV] at Bus 1,3
% V_base = 345[kV] at Bus 2,4,5

clear; clc;

% SIZE = input('Number of Bus : ');
% ITERATION = input('Iteration Limit : ');

SIZE = 5;           % Number of Bus
ITERATION = 1000;      % [Iteration-1] 회 반복 수행함
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

V = zeros(1,SIZE,ITERATION);
Delta = zeros(1,SIZE,ITERATION);
P_G = zeros(1,SIZE,ITERATION);
Q_G = zeros(1,SIZE,ITERATION);
P_L = zeros(1,SIZE,ITERATION);
Q_L = zeros(1,SIZE,ITERATION);
Q_Gmax = zeros(1,SIZE);
Q_Gmin = zeros(1,SIZE);

V(1,:,1) = [1 1 1.05 1 1];
Delta(1,:,1) = [0 0 0 0 0];
P_G(1,:,1) = [4 0 5.2 0 0];     % [0 0 5.2 0 0] 원래는 4로 입력 받으나 Slack Bus 지정 후 0으로 바뀌도록 구조화
Q_G(1,:,1) = [0 0 0 0 0];
P_L(1,:,1) = [0 8 0.8 0 0];
Q_L(1,:,1) = [0 2.8 4.0 0 0];
Q_Gmax(1,:) = [0 0 4.0 0 0];
Q_Gmin(1,:) = [0 0 -2.8 0 0];

% fprintf('\n[Bus Type]\n');
Bus_Type = zeros(1,SIZE,ITERATION);

for i = 1:SIZE
    % Bus_Type(1,i,1) =  input(sprintf('Bus%d (Slack : 0, Gen(PV) : 1, Load(PQ) : 2) : ',i)); % 자동화 필요
    Bus_Type(1,:,1) = [0 2 1 2 2];

    switch Bus_Type(1,i,1)      % Initialize
        case 0      % Slack Bus : V = 1R0, P_G, Q_G = Unknowns(0), P_L, Q_L = 0, Q_Gmax,min = 0 
            V(1,i,1) = 1;
            Delta(1,i,1) = 0;
            P_G(1,i,1) = 0;
            Q_G(1,i,1) = 0;
            P_L(1,i,1) = 0;
            Q_L(1,i,1) = 0;
            Q_Gmax(1,i) = 0;
            Q_Gmin(1,i) = 0;

        case 1      % PV Bus (Gen)
            Delta(1,i,1) = 0;
            Q_G(1,i,1) = 0;
            Q_L(1,i,1) = 0;

        case 2      % PQ Bus (Load)
            V(1,i,1) = 1;
            Delta(1,i,1) = 0;
    end
end

P = P_G - P_L;
Q = Q_G - Q_L;

% 모선 별 미지수 계산 (Jacobi Method)
for i = 1:ITERATION
    if i == ITERATION
        break;
    end

    for k = 1:SIZE      % Bus1 ~ Bus(SIZE)
        switch Bus_Type(1,k,i)
            case 0  % For Slack Bus
                V(1,k,i+1) = V(1,k,i);  % V = 1R0 (초기 설정)을 계속 유지
                P(1,k,i+1) = P(1,k,i);
                Q(1,k,i+1) = Q(1,k,i);
                
                if i==ITERATION-1
                    for n = 1:SIZE
                        P(1,k,i+1) = P(1,k,i+1) + abs(Y(1,n))*V(1,n,i)*cos((Delta(1,n,i)+angle(Y(1,n)))*(pi/180));
                    end

                    for n = 1:SIZE
                        Q(1,k,i+1) = Q(1,k,i+1) + abs(Y(1,n))*V(1,n,i)*sin((Delta(1,n,i)+angle(Y(1,n)))*(pi/180));
                    end
                    Q(1,k,i) = -Q(1,k,i);

                end

            case 1  % For PV Bus (Gen)
                Q_L(1,k,i+1) = Q_L(1,k,i);

                Sum_YVsin = 0;
                for n = 1:SIZE
                    Sum_YVsin = Sum_YVsin + abs(Y(k,n)) * V(1,n,i) ...
                                * sin((Delta(1,k,i) - Delta(1,n,i) - angle(Y(k,n))*(180/pi)) * (pi/180));
                    Bus_Type(1,k,i+1) = Bus_Type(1,k,i);
                end

                Q(1,k,i+1) = V(1,k,i)*Sum_YVsin;

                if Q(1,k,i+1) + Q_L(1,k,i+1) > Q_Gmax(1,k)     % PQ Bus로 전환되었을 때 - 1
                    Q(1,k,i+1) = Q_Gmax(1,k);   % PQ Bus로 V, Delta 계산
                    P(1,k,i+1) = P(1,k,i);   % P value not changed after iteration
                    
                    % I_k = (P_k - jQ_k) / V_k(i)*
                    I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i+1)) / (V(1,k,i)*exp(-sqrt(-1)*Delta(1,k,i)*(pi/180)));
                    
                    Sum_YV_1 = 0;
                    Sum_YV_2 = 0;
                    
                    for n = 1:k-1
                        Sum_YV_1 = Sum_YV_1 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                    end
                    
                    for n = k+1:SIZE
                        Sum_YV_2 = Sum_YV_2 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                    end
    
                    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);    % k모선의 i번째 iteration 값 계산
                    V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
                    Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);

                    % Recalculation
                    I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i+1)) / (V(1,k,i+1)*exp(-sqrt(-1)*Delta(1,k,i+1)*(pi/180)));
                    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);
                    V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
                    Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);

                    Bus_Type(1,k,i+1) = 2;

                elseif Q(1,k,i+1) + Q_L(1,k,i+1) < Q_Gmin(1,k) % PQ Bus로 전환되었을 때 - 2
                    Q(1,k,i+1) = Q_Gmin(1,k);% PQ Bus로 V, Delta 계산
                    P(1,k,i+1) = P(1,k,i);   % P value not changed after iteration
                    
                    % I_k = (P_k - jQ_k) / V_k(i)*
                    I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i+1)) / (V(1,k,i)*exp(-sqrt(-1)*Delta(1,k,i)*(pi/180)));
                    
                    Sum_YV_1 = 0;
                    Sum_YV_2 = 0;
                    
                    for n = 1:k-1
                        Sum_YV_1 = Sum_YV_1 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                    end
                    
                    for n = k+1:SIZE
                        Sum_YV_2 = Sum_YV_2 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                    end
    
                    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);    % k모선의 i번째 iteration 값 계산
                    V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
                    Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);
                    
                    % Recalculation
                    I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i+1)) / (V(1,k,i+1)*exp(-sqrt(-1)*Delta(1,k,i+1)*(pi/180)));
                    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);
                    V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
                    Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);

                    Bus_Type(1,k,i+1) = 2;
                    

                else    % PV Bus 조건이 유지될 때
                    V(1,k,i+1) = V(1,k,i);
                    P(1,k,i+1) = P(1,k,i);  % P value not changed after iteration
                    
                    % I_k = (P_k - jQ_k) / V_k(i)*
                    I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i+1)) / (V(1,k,i)*exp(-sqrt(-1)*Delta(1,k,i)*(pi/180)));
                    
                    Sum_YV_1 = 0;
                    Sum_YV_2 = 0;
                    
                    for n = 1:k-1
                        Sum_YV_1 = Sum_YV_1 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                    end
                    
                    for n = k+1:SIZE
                        Sum_YV_2 = Sum_YV_2 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                    end
    
                    V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);    % k모선의 i번째 iteration 값 계산

                    V(1,k,i+1) = V(1,k,i);      % PV Bus는 V의 크기가 바뀌지 않음.
                    Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);
                end
                    

            case 2  % For PQ Bus (Load)
                P(1,k,i+1) = P(1,k,i);
                Q(1,k,i+1) = Q(1,k,i);      % P,Q values not changed after iteration
                Bus_Type(1,k,i+1) = Bus_Type(1,k,i);
                
                % I_k = (P_k - jQ_k) / V_k(i)*
                I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i)) / (V(1,k,i)*exp(-sqrt(-1)*Delta(1,k,i)*(pi/180)));
                
                Sum_YV_1 = 0;
                Sum_YV_2 = 0;
                
                for n = 1:k-1
                    Sum_YV_1 = Sum_YV_1 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                end
                
                for n = k+1:SIZE
                    Sum_YV_2 = Sum_YV_2 + Y(k,n) * (V(1,n,i)*exp(sqrt(-1)*Delta(1,n,i)*(pi/180)));
                end

                V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);    % k모선의 i번째 iteration 값 계산
                V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
                Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);

                % Recalculation
                I_k = (P(1,k,i)-sqrt(-1)*Q(1,k,i)) / (V(1,k,i+1)*exp(-sqrt(-1)*Delta(1,k,i+1)*(pi/180)));
                V_k = (1/Y(k,k)) * (I_k - Sum_YV_1 - Sum_YV_2);
                V(1,k,i+1) = sqrt(power(real(V_k),2) + power(imag(V_k),2));
                Delta(1,k,i+1) = atan(imag(V_k) / real(V_k)) * (180/pi);
        end
    end
end
