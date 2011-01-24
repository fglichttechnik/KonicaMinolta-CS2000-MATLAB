function message = CS2000_setBacklight(norm, bl)
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
global s

fprintf(s, ['BALS,', num2str(norm),',', num2str(bl)]);
ErrorCheckCode = fscanf(s);

[tf, errOutput] = CS2000_errMessage(ErrorCheckCode);
    
if tf == 1
    message = CS2000_readBacklight;
else
    message = errOutput;
    disp(message);
end

end