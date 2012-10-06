% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.



function data = readJetiExcelFile(filename)
%function data = readJetiExcelFile(filename)
%   reads a Jeti excel file and returns the spectral data

OFFSET = 64;
%[NUMERIC,TXT,RAW]=XLSREAD(filename,1,'b12:b412');
[NUMERIC,TXT,RAW]=XLSREAD(filename);

data = zeros(1,401);
for i = 1 : 401
    %disp(RAW{i + OFFSET, 2})
    data(i) = RAW{i + OFFSET, 2};
end

end