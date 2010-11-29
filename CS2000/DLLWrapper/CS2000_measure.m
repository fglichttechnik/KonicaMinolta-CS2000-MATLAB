%-----------------------------------------------------------------%
%Function MEAS (Measure)
%Performs only measurement (measurement data are not output). Measurement
%starts when MEAS,1 is input. A pre-measurement is taken to determine the
%required measurment time (and notification of this time is sent from the
%CS-2000 to PC) and then the actual measurement begins automatically. When
%measurement has been completed, the instrument returns an error-check
%code (OK00 if measurement was completed successfully). To cancel a
%measurement in progress, MEAS,0 can be input after the pre-measurement
%has been completed. No commands will be accepted during pre-measurement.
%During actual measurement, commands other than MEAS,0 will result in a
%response of ER00.

%-----------------------------------------------------------------%
%Function MEDR (Measurement Data Read)
%Reads measurement data from instrument.
%Data are output as comma-delimited. When measurement button is enabled:
%- Reading all 4 blocks of spectral data or reading any set of colorimetric
%data clears the measurment data from the instrument's buffer.
%- If an error occurs during measurement, the corresponding error-check ist
%output but no measurement data are output. When the error-check code ist
%read, measurement data are cleared form the instrument's buffer.


%function [message1, message2, spectralData, colorimetricData, colorimetricNames] =  measure()
function [message1, message2, measuredData, colorimetricNames] =  CS2000_measure()
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
global s


    
    % ------------------------start measurement-------------------------------
    fprintf(s,'MEAS,1');
    answer = fscanf(s);                 

    fid = fopen('Temp\answers.tmp', 'w');
    fprintf(fid, answer);
    fclose(fid);

    [ErrorCheckCode, PreMeasTime] = textread('Temp\answers.tmp','%s %d','delimiter',',');
    [tf, errOutput] = CS2000_errMessage(ErrorCheckCode);

    if tf == 1
        message1 = 'Pre-Measurement has been completed.';
        message2 = ['Pre-Measurement time was: ',num2str(PreMeasTime),' seconds.'];
        ErrorCheckCode = fscanf(s,'%s');
        [tf, errOutput] = CS2000_errMessage(ErrorCheckCode);
    
        if tf == 1
            message1 = 'Measurement has been completed.';
        else
            message1 = errOutput;
        end
    disp(message1);
    disp(message2);
    else
        message1 = errOutput;
        disp(message1);

    end

    

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
            disp(errOutput);    
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


end




