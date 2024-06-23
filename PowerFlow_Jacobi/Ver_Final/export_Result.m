% Export Ybus, Bus/Line Output data to Excel file

function export_Result(Ybus,BusOutputData,LineOutputData)
    
    result_file = 'Power_Flow_Result.xlsx';
    if exist(result_file, 'file')
        delete(result_file);
    end

    % Y Bus Matrix
    writematrix(Ybus,'Power_Flow_Result.xlsx','sheet','Y Bus Matrix');
    
    % Bus Output Data
    headers = {'Bus#','Voltage Magnitude(p.u.)','Phase Angle(Deg)','P_G(p.u.)','Q_G(p.u.)','P_L(p.u.)','Q_L(p.u.)'};
    BusData = [headers; num2cell(BusOutputData)];
    writecell(BusData,'Power_Flow_Result.xlsx','sheet','Bus Output Data');
    
    % Line Output Data
    headers = {'Line#','from','to','P','Q','S'};
    LineData = [headers; num2cell(LineOutputData)];
    writecell(LineData,'Power_Flow_Result.xlsx','sheet','Line Output Data');

end