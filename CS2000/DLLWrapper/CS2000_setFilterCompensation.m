% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.



function CS2000_setFilterCompensation()
global s

angle = 0;
filter = 1;
wavelength = 380;
compfactor = 0.1;

fprintf(s, ['NFCS,', num2str(angle), num2str(filter), ...
    num2str(wavelength), num2str(compfactor)]);

answer = fscanf(s)

fprintf(s, 'NFCS,3');

answer = fscanf(s)

end