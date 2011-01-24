function [Lmes, imgVisualization] = mesopicLuminance_intermediate(Lp,Ls)
%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%calculates the mesopic luminance according to the INTERMEDIATE SYSTEM
%Lp, Ls might be single values or matrices
%Lp = photopic luminance
%Ls = scotopic luminance
%implemented regarding to CIE Report TC1-58

%hack: remove zero pixels
% Lp = Lp(1:end-2,1:end-2);
% Ls = Ls(1:end-2,1:end-2);

%preferences
STARTWERT = 0.5;
STOP_CRITERION = 0.01;  %deprecated
NUMBER_OF_ITERATIONS = 10;  %10 looks to be a good value, as it converges fast

%nothing needs to be modified below
UPPER_VALUE_FOR_MESOPIC = 3;       %values above will be photopic luminances
LOWER_VALUE_FOR_MESOPIC = 0.01;    %values below will be scotopic luminances

if(size(Lp) ~= size(Ls))
    disp('mesopicLuminance: Lp and Ls must have the same size!');
    return;
end

%variables
a = 0.807;
b = 0.404;
Kp = 683;
Ks = 1699;
V_strich_lambda0 = Kp / Ks;

m_20 = ones(size(Lp)) * STARTWERT;
Lmes_n = zeros(size(Lp));
Lmes_n_1 = Lmes_n;

%calc mesopic luminance
m_2n_1 = m_20;
for i = 1 : NUMBER_OF_ITERATIONS
    numerator = m_2n_1 .* Lp + (1 - m_2n_1) .* Ls .* V_strich_lambda0;
    denominator = m_2n_1 + (1 - m_2n_1) .* V_strich_lambda0;
    Lmes_n = numerator ./ denominator;
    
    m_2n = a + b * log10(Lmes_n);
    m_2n_1 = m_2n;
    
    %keep photopic luminances above UPPER_VALUE_FOR_MESOPIC
    valuesAbove = (Lmes_n >= UPPER_VALUE_FOR_MESOPIC);
    m_2n_1(valuesAbove) = 1;
    
    %keep scotopic luminances below LOWER_VALUE_FOR_MESOPIC
    valuesBelow = (Lmes_n <= LOWER_VALUE_FOR_MESOPIC);
    m_2n_1(valuesBelow) = 0;
end

Lmes = Lmes_n;

%hack:
Lmes = abs(Lmes_n);

%keep photopic luminances above UPPER_VALUE_FOR_MESOPIC
valuesAbove = (Lmes >= UPPER_VALUE_FOR_MESOPIC);
Lp_keep = Lp .* valuesAbove;

%keep scotopic luminances below LOWER_VALUE_FOR_MESOPIC
valuesBelow = (Lmes <= LOWER_VALUE_FOR_MESOPIC);
Ls_keep = Ls .* valuesBelow;

%merge into mesopic values
Lmes(valuesAbove) = Lp_keep(valuesAbove);
Lmes(valuesBelow) = Ls_keep(valuesBelow);

%%%
% visual output of luminance type
% unneeded for normal use...

%prepare visualization image
imgVisualization = ones(size(Lp)) * 2;
imgVisualization(valuesAbove) = 1;
imgVisualization(valuesBelow) = 3;

%photopic luminances are red
%mesopic luminances are green
%scotopic luminances are blue
map = [1.0,0,0;0,1.0,0;0,0,1.0];
imgVisualization = ind2rgb(imgVisualization, map);
%imshow(imgVisualization);
%colormap(map);
%colorbar('YTick',[1;2;3],'YTickLabel',...
    %{'Photopic','Mesopic','Scotopic'});



