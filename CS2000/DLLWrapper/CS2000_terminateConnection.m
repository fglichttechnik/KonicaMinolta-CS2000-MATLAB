% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.



function message = CS2000_terminateConnection()
global s

%-----------------------------------------------------------------%

%set ND Filter to initial state
CS2000_setNDFilter(0);

%Delete from Workspace
fclose(s);
delete(s);

message = 'disconnected';

disp(message);


[stat, mess, id] = rmdir('Temp','s');

if stat == 0
    disp(mess);
end

end