function filter = CS2000_readNDFilter()
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
% NDFR: Reads which (if any) external ND filter is attached to the 
% instrument.

global s

disp('Read ND Filter: ')
fprintf(s,'NDFR');

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
    spectralData = errOutput; 
    
% Read current filter:   
else
    garbage = fscanf(fid,'%c',1);
    filter = fscanf(fid,'%c',1);
    filter = str2num(filter);
end

disp('Current ND filter: ');
switch filter
    case 0
        disp('None');
    case 1
        disp('ND1 attached');
    case 2
        disp('ND2 attached');
    otherwise
        disp('Error: ND filter could not be read.');
end

end