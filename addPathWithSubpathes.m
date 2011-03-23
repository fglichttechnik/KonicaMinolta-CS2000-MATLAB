function addPathWithSubpathes
%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%Run this function to add all subpathes to MATLAB search path.
%Run before using the functions in this folder.

currentWorkingDirectory = pwd;

addpath(genpath(currentWorkingDirectory));

addpath(genpath('C:\Programme\MATLAB\R2010a\toolbox\SaliencyToolbox'));
addpath(genpath('C:\Programme\MATLAB\R2010a\gbvs'));


