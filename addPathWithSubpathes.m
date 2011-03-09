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

currentWorkingDirectory = pwd;

addpath(genpath(currentWorkingDirectory));

