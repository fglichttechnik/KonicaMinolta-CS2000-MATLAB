% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.



function [Lp, Lm, Ls] = calcLuminance(spectralData)

% define variables
Km = 683;
Km_strich = 1699;
V = load('colordata.mat', 'V');
V_strich = load('colordata.mat', 'V_strich');
k = 1 : 1 : 81;

% V(lambda) is given in an intervall of 5nm
j = 1 : 5 : 401; 
specData = spectralData(j);

% calc photopic, scotopic luminance using V(lambda) & V'(lambda) functions
Lp = Km * 5 *(specData(k) * V.V(k));
Ls = Km_strich * 5 * (specData(k) * V_strich.V_strich(k));

%calc mesopic luminance with intermediate model
[Lm, ~] = mesopicLuminance_intermediate(Lp,Ls);

end