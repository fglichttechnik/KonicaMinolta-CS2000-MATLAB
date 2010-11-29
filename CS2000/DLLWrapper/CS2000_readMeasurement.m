function [measuredData, colorimetricNames] = CS2000_readMeasurement()
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%Function MEDR (Measurement Data Read)
    %Reads measurement data from instrument.
    %Data are output as comma-delimited. When measurement button is enabled:
    %- Reading all 4 blocks of spectral data or reading any set of colorimetric
    %data clears the measurment data from the instrument's buffer.
    %- If an error occurs during measurement, the corresponding error-check ist
    %output but no measurement data are output. When the error-check code ist
    %read, measurement data are cleared form the instrument's buffer.
    
global s

%---------------read spectral data 380...780nm from instrument------------
p = 1;
for n = 1:4
    
    fprintf(s,['MEDR,1,0,', num2str(n)]);
    
    %Get instrument answer into file:
    answer = fscanf(s);
    
    fid = fopen('Temp\answers.tmp', 'w');
    fprintf(fid, answer);
    fclose(fid);
    
    %Get instrument error-check code:
    fid = fopen('Temp\answers.tmp','r');
    ErrorCheckCode = fscanf(fid,'%c',4);
    [tf, errOutput] = CS2000_errMessage(ErrorCheckCode);
    if tf ~= 1
        spectralData = errOutput;   
    
    %Get spectral data:
    elseif tf == 1
        if n == 4
            l = 101;
        else
            l = 100;
        end
        for m = p:((p+l)-1)
            garbage = fscanf(fid,'%c',1);
            spectralData{m} = fscanf(fid,'%e',8);
        end
    end    
    fclose(fid);   
    
    p = p+100;
end

spectralData = cell2mat(spectralData);


%------------------------Read Colorimetric data:----------------------------

fprintf(s,'MEDR,2,0,00'); %00 = read all colometric data

%Get instrument answer into file:
answer = fscanf(s);

fid = fopen('Temp\answers.tmp', 'w');
fprintf(fid, answer);
fclose(fid);

%Get instrument error-check code:
fid = fopen('Temp\answers.tmp','r');
ErrorCheckCode = fscanf(fid,'%c',4);
for k = 1:24
    garbage = fscanf(fid,'%c',1);
    colorData{k} = fscanf(fid,'%e');
end
fclose(fid);

%Get colorimetric data:
[tf, errOutput] = CS2000_errMessage(ErrorCheckCode);
if tf == 1
    for p = 1:24        
        colorimetricData{p} = colorData{p};
    end
else
    colorimetricData = errOutput;
end


%create CS2000Measurement object:
measuredData = CS2000Measurement(clock, spectralData, colorimetricData);
colorimetricNames = properties(measuredData.colorimetricData);


%-----------------------Plot all spectral data:---------------------------
plot(measuredData);

%-----------------------Read aperture:------------------------------------
measuredData.aperture = CS2000_readApertureStop;

end