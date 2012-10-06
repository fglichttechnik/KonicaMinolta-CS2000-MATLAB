% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.


global path

path = pwd;

% delete these 3 lines when making a standalone application (.exe):
% addpath([path, '\Wrapper']);
% addpath([path, '\GUI']);
% addpath([path, '\classes']);


% a = exist Temp
% if a == 7
    [s, mess, messid] = mkdir('Temp');
    if s ~= 1
        disp('error');
    end
% end


CS2000_choseCom;
uiwait(CS2000_choseCom);
message = evalin( 'base', 'message' );
if ~(strcmp( message, 'Sorry, no connection.'))
    CS2000_menue;
else
    disp('CS-2000 not connected.');
end