function aperture = CS2000_readApertureStop()
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%
%Reads the status of the instrument's aperture stop.

global s

fprintf(s, 'STSR');

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
    ap = errOutput;    
    
%Get spectral data:
elseif tf == 1
    garbage = fscanf(fid, '%c',1);
    %== fseek(fid,1,'cof'); %seek from current position of file by 1 byte
    ap = fscanf(fid, '%c',1);
end

fclose(fid);

switch ap
    case '0'
        aperture = '1°';
        disp(['Measurement aperture (aperture stop positiion): ', aperture]);
    case '1'
        aperture = '0.2°';
        disp(['Measurement aperture (aperture stop positiion): ' aperture]);
    case '2'
        aperture = '0.1°';
        disp(['Measurement aperture (aperture stop positiion): ', aperture]);
    otherwise
        aperture = 'error';
        disp(errOutput);
end
end