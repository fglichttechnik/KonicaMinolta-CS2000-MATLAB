% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.



function meansOfMeasurements = CS2000_calcMeansOfMeasuredData(measurements)

% declare variables
spectralData = zeros(1,401);
colorimetricData = zeros(24,1);
colData = zeros(24,1);
colNames = fieldnames(measurements{1,1}.colorimetricData);
i = 1 : 401;
k = 1 : 24;
l = length(measurements);

% calculate means of spectral and colorimetric data
for j = 1 : l
    
    spectralData(1,i) = spectralData(1,i) + ...
        measurements{j,1}.spectralData(i);    
    
    for m = 1:24
        colData(m,1) = getfield(measurements{j,1}.colorimetricData, colNames{m});
    end
    colorimetricData(k) = colorimetricData(k) + colData(k,1);

end
spectralData(1,i) = spectralData(1,i) / l;
colorimetricData(k) = colorimetricData(k) / l;
timeStamp = measurements{l,1}.timeStamp;

% create CS2000Measurement object
colorimetricData = num2cell(colorimetricData);
meansOfMeasurements = CS2000Measurement(timeStamp,spectralData,...
    colorimetricData);
colorimetricNames = properties(colorimetricData);

end