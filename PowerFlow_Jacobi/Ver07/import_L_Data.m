% import Line Data from xlsx(csv) file
% Line Number / from / to / Rpu / Xpu / Gpu / Bpu / Maximum MVA pu / tap / TR exist

function L_data = import_L_Data(SIZE)
    
    file = 'example6.10_line.xlsx';
    sheet = 1;
    raw_L_data = xlsread(file, sheet);
    
    fprintf('[Transmission Line Data]\n');
    fprintf('   Line Num    from       to        Rpu       Xpu         Gpu    Bpu     maxMVA         tap  TR exist\n')
    fprintf('------------------------------------------------------------------------------------------------------\n')
    disp(raw_L_data);
    
    [~, cols] = size(raw_L_data);
    L_data = zeros(SIZE,cols,SIZE);
    L = zeros(1,cols);
    
    for i = 1:SIZE
    
        for j = 1:cols
            if j < 4
                L(i,cols-3+j) = raw_L_data(i,j);
            else
                L(i,j-3) = raw_L_data(i,j);
            end
        end
    
        L_data(L(i,9),:,L(i,10)) = L(i,:);
        L_data(L(i,10),:,L(i,9)) = L(i,:);
        
    end
end