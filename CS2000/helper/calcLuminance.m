function [Lp, Lm, Ls] = calcLuminance(spectralData)


Km = 683;
Km_strich = 1699;
V = load('colordata.mat', 'V');
V_strich = load('colordata.mat', 'V_strich');

j = 1 : 5 : 401;
k = 1 : 1 : 81;
specData = spectralData(j);

Lp = Km * 5 *(specData(k) * V.V(k));
Ls = Km_strich * 5 * (specData(k) * V_strich.V_strich(k));
[Lm, ~] = mesopicLuminance_intermediate(Lp,Ls);

end