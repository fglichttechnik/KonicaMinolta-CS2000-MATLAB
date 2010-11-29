%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%filenames of measurements to evaluate

filenames = {
    'Data\halogenNormal_center_monitorON_apertureNO_10',...
    'Data\halogenNormal_center_monitorOFF_apertureNO_10',...
    'Data\halogenNormal_center_monitorOFF_apertureYES3_10.mat'
    }

numberMeasurements = length(filenames);

measurementSet = cell(numberMeasurements,1);

for i = 1 : numberMeasurements
    measurementSet{i} = load(filenames{i});
end

%m01 = load('halogenNormal_center_monitorON_apertureNO_10');
%m02 = load('halogenNormal_center_02.mat');
%m10 = load('halogenNormal_center_10.mat');


%evaluation
len = length(measurementSet{1}.measurements);
LvArray = zeros(len, numberMeasurements);
for i = 1 : numberMeasurements
for j = 1 : len
    LvArray(j,i) = measurementSet{i}.measurements{j}.colorimetricData.Lv;
    %LvArray(j,2) = m02.measurements{i}.colorimetricData.Lv;
    %LvArray(j,3) = m10.measurements{i}.colorimetricData.Lv;
end
end

%plots
errorbar([1:len], LvArray(:,1), std(LvArray(:,1)) * ones(len,1), 'b');
hold on;
errorbar([1:len], LvArray(:,2), std(LvArray(:,2)) * ones(len,1), 'r');
errorbar([1:len], LvArray(:,3), std(LvArray(:,3)) * ones(len,1), 'gr');
hold off;

% plot([1:len], LvArray(:,1), 'b');
% hold on;
% plot([1:len], LvArray(:,2), 'r');
% plot([1:len], LvArray(:,3), 'gr');
% hold off;

%legend('0.1 degree','0.2 degree','1.0 degree');
%title(sprintf('Set of Measurements %s %s', measurementSet{1}.measurements{i}.comments, measurementSet{1}.measurements{i}.lightSource));

legend(measurementSet{1}.measurements{1}.comments,measurementSet{2}.measurements{1}.comments,measurementSet{3}.measurements{1}.comments);
title('Set of Measurements');
xlabel('Measurement i');
ylabel('Lv in cd/m^{2}');
axis('tight');

