% import Line Data from xlsx(csv) file
% Line Number / from / to / Rpu / Xpu / Gpu / Bpu / Maximum MVA pu / tap / TR exist

function [L_Mat,L_data] = import_L_Data(line_file,SIZE)
    
    raw_L_data = readmatrix(line_file);
    
    fprintf('[Transmission Line Data]\n');
    fprintf('   Line Num    from       to        Rpu       Xpu         Gpu    Bpu        maxMVA      TAP\n')
    fprintf('----------------------------------------------------------------------------------------------\n')
    disp(raw_L_data);
    
    [rows, cols] = size(raw_L_data);
    L_Mat = raw_L_data;
    L_data = zeros(SIZE,cols,SIZE);
    L = zeros(1,cols);
    
    for i = 1:rows
    
        for j = 1:cols
            if j < 4
                L(1,cols-3+j) = raw_L_data(i,j);
            else
                L(1,j-3) = raw_L_data(i,j);
            end
        end
    
        L_data(L(1,8),:,L(1,9)) = L(1,:);
        L_data(L(1,9),:,L(1,8)) = L(1,:);
        
    end
end