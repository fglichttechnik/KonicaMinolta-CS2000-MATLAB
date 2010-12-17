function message = CS2000_terminateConnection()
%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
global s

%-----------------------------------------------------------------%

%set ND Filter to initial state
CS2000_setNDFilter(0);

%Delete from Workspace
fclose(s);
delete(s);

message = 'disconnected';

disp(message);

rmpath([path, '\Temp']);
[stat, mess, id] = rmdir('Temp','s');

if stat == 0
    disp(mess);
end

end