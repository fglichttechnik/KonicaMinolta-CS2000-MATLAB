% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.

function addPathWithSubpathes
%Run this function to add all subpathes to MATLAB search path.
%Run before using the functions in this folder.

currentWorkingDirectory = pwd;

addpath(genpath(currentWorkingDirectory));

addpath(genpath('C:\Programme\MATLAB\R2010a\toolbox\SaliencyToolbox'));
addpath(genpath('C:\Programme\MATLAB\R2010a\gbvs'));


