% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.

function plotDataFromFile(filename,options)
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


