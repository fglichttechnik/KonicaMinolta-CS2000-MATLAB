<<<<<<< HEAD
function addPathWithSubpathes
%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%Run this function to add all subpathes to MATLAB search path.
%Run before using the functions in this folder.
=======
%======================================================================
%> @brief Brief description of the function
%>
%> More detailed description.
%>
%> @param arg1 First argument
%> @param arg2 Second argument
%>
%> @retval out1 return value for the first output variable
%> @retval out2 return value for the second output variable
%======================================================================
function addPathWithSubpathes
%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
>>>>>>> 879dccd863b086d972b98ce165bffc9388334006

currentWorkingDirectory = pwd;

addpath(genpath(currentWorkingDirectory));
<<<<<<< HEAD
addpath(genpath('C:\Programme\MATLAB\R2010a\toolbox\SaliencyToolbox'));
addpath(genpath('C:\Programme\MATLAB\R2010a\gbvs'));

=======
>>>>>>> 879dccd863b086d972b98ce165bffc9388334006

