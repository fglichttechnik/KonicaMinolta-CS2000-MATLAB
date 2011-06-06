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