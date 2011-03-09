function message = CS2000_initConnection(comPort)
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
global s

a = exist('Temp', 'dir');
if a ~= 7
    [success, mess, messid] = mkdir('Temp');
    if success == 0    
        disp(mess);
        disp('not connected');  
    end
end

if length(instrfind) > 0 
    fclose(instrfind);
    delete(instrfind);
end
   
if(nargin == 0)
    s = serial('COM4');
else
    s = serial(comPort);
end    
    
s.Terminator = 'LF'; 
s.InputBufferSize = 1024;
s.BytesAvailableFcnMode = 'terminator'; 
s.BytesAvailableFcn = @instrcallback;
s.Timeout = 240;

fopen(s);
fprintf(s,'RMTS,1');
ErrorCheckCode = fscanf(s);                   
[tf, errOutput] = CS2000_errMessage(ErrorCheckCode); 
    
if tf == 1
    message = 'connected';    
else
    message = errOutput;   
end
disp(message);
end   










