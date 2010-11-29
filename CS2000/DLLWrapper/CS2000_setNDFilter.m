function CS2000_setNDFilter(filter)
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
% NDFS: Sets which external ND filter (if any) is attached to the
% instrument. Setting is stored in flash ROM, and is maintainded even if
% instrument power is switched off.

global s

fprintf(s,['NDFS,', num2str(filter)]);

% Get instrument error-check code:
ErrorCheckCode = fscanf(s);
[tf, errOutput] = CS2000_errMessage(ErrorCheckCode);
if tf == 1
    disp(['Filter ', num2str(filter), ' has been set.']);
if tf ~=1
    disp(errOutput);
end
    
end