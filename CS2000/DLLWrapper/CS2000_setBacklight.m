% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.



function message = CS2000_setBacklight(norm, bl)
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