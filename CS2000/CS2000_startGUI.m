%author Sandy Buschmann, Jan Winter TU Berlin
%email j.winter@tu-berlin.de
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

CS2000_menue;
% uiwait(CS2000_menue);
% rmdir('Temp');
% clear;