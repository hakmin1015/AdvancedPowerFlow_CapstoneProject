% Initial Value
% Bus별로 Unknowns가 다르므로 Type별 구분 필요

function [V,Delta,P_G,Q_G,P_L,Q_L,Q_Gmax,Q_Gmin,P,Q,Bus_Type] = Init_Value(SIZE,ITERATION)

    % fprintf('\n[Initial Value of Voltage(V)]\n');
    % V = zeros(1,SIZE,ITERATION);
    % 
    % for i = 1:SIZE
    %     V(1,i,1) = input(sprintf('V%d(0) : ',i));
    % end
    % 
    % fprintf('\n[Initial Value of Phase(Deg)]\n');
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
    P_G(1,:,1) = [0 0 5.2 0 0];
    Q_G(1,:,1) = [0 0 0 0 0];
    P_L(1,:,1) = [0 8 0.8 0 0];
    Q_L(1,:,1) = [0 2.8 0.4 0 0];
    Q_Gmax(1,:) = [0 0 4.0 0 0];
    Q_Gmin(1,:) = [0 0 -2.8 0 0];

    % fprintf('\n[Bus Type]\n');      % Bus Type 지정 모듈 분리 필요
    Bus_Type = zeros(1,SIZE,ITERATION);
    
    for i = 1:SIZE
        % Bus_Type(1,i,1) =  input(sprintf('Bus%d (Slack : 0, Gen(PV) : 1, Load(PQ) : 2) : ',i)); % 자동화 필요
        % Bus_Type(1,:,:) = repmat(Bus_Type(1,i,1),1,1,ITERATION);
        Bus_Type(1,:,:) = repmat([0 2 1 2 2],1,1,ITERATION);
    
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
    
            case 2      % PQ Bus (Load)
                V(1,i,1) = 1;
                Delta(1,i,1) = 0;
        end
    end
    
    P = P_G - P_L;
    Q = Q_G - Q_L;
end