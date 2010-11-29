function plotDataFromFile(filename,options)
%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%options might be 'time'

%add directories for CS2000
currentPath = pwd;
if(ispc)    
    addpath([currentPath, '\CS2000\classes']);
elseif(isunix)
    addpath([currentPath, '/CS2000/classes']);
end

%load data
%might be measurements (cell with CS2000 data)
%ketihley data
%LMK data
load(filename);

%remove unnecessary .mat ending
filename = regexprep(filename,'.mat','');



plotDataFromCellArray(measurements,options,filename);


