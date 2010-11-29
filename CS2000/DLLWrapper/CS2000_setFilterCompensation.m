function CS2000_setFilterCompensation()
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
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