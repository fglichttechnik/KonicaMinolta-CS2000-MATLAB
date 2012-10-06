% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.

function message = CS2000_readBacklight()
%Reads the setting of control of external display backlight during
%measurement.
% 
%Output: message = string containing information of the backlight mode that
%                  has been set.


global s 

fprintf(s, 'BALR');

% Get instrument answer into file:
answer = fscanf(s);
    
fid = fopen('Temp\answers.tmp', 'w');
fprintf(fid, answer);
fclose(fid);
    
% Get instrument error-check code:
fid = fopen('Temp\answers.tmp','r');
ErrorCheckCode = fscanf(fid,'%c',4);
[tf, errOutput] = CS2000_errMessage(ErrorCheckCode);

if tf ~= 1
    blnorm = errOutput; 
    blmeas = ' ';
end
    
% Get backlight settings:
if tf == 1 
    garbage = fscanf(fid, '%c',1);
    blnorm = fscanf(fid, '%c',1);
    garbage = fscanf(fid, '%c',1);
    blmeas = fscanf(fid, '%c',1);
    switch blnorm
        case '0'
            stat = 'off';
        case '1' 
            stat = 'on';
        otherwise
            stat = 'Error';
    end    
    
    switch blmeas 
        case '0'
            all = 'off';
        case '1'
            all = 'on';
        otherwise
            all = 'error';
    end
    message = ['Backlight has been set ´', all,...
        '´ during measurement.'];
    disp(message);
end  

fclose(fid);

end
