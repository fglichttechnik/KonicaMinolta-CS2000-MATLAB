function plotDataFromCellArray(measurements,options,filename)
%author Jan Winter TU Berlin
%email j.winter@tu-berlin.de
%options might be 'time'

SAVEFIGURES = 1;    %figures will be saved if ~0

%add directories for CS2000
currentPath = pwd;
if(ispc)    
    addpath([currentPath, '\CS2000\classes']);
elseif(isunix)
    addpath([currentPath, '/CS2000/classes']);
end

%load data
%might be measurements (cell with CS2000 data)
%ketihley data
%LMK data

N = length(measurements);


if(exist('gpibMeasurements'))
    gpibMeasurements = gpibMeasurements(1:N);
end


x = [1 : N];
lambda = [380 : 780];
%ticks = [380;400;450;500;550;600;650;700;750;780];
ticks = [380;420;460;500;540;580;620;660;700;740;780];

%analyze options
if(exist('options'))
    %generate time array
    if(strcmp(options,'time'))
        if(N > 1)
            tArray = zeros(N,1);
            for i = 2 : N
                t = measurements{i}.timeStamp - measurements{1}.timeStamp;
                timeBetweenMeasurementsInSeconds = t(6) + t(5) * 60 + t(4) * 3600 + t(3) * 3600 * 24;
                tArray(i) = timeBetweenMeasurementsInSeconds;
            end            
            t = tArray;
            %time in minutes
            %t = t * timeBetweenMeasurementsInSeconds / 60;
            t = t / 60;
        end
    end
end

%%analyze Lv data
LvArray = zeros(N,1);
for i = 1 : N
    try
        LvArray(i) = measurements{i}.colorimetricData.Lv;
    end
end
meanLv = mean(LvArray);
stdLv = std(LvArray);
uXLv = stdLv / sqrt(N);
disp(sprintf('mean of Lv: %10.10f',meanLv));
disp(sprintf('std of Lv: %10.10f',stdLv));
disp(sprintf('std in per cent of mean: %3.5f',stdLv / meanLv * 100));


%Lv Plot
figure;
if(exist('t'))
    %errorbar(t, LvArray, stdLv * ones(N,1));
    plot(t, LvArray);
    hold on;
    plot(t, meanLv * ones(N,1), 'r');
    plot(t, (meanLv - stdLv) * ones(N,1), 'gr');
    plot(t, (meanLv - uXLv) * ones(N,1), 'm');
    plot(t, (meanLv + stdLv) * ones(N,1), 'gr');
    
    plot(t, (meanLv + uXLv) * ones(N,1), 'm');
    hold off;
    xlabel('time in minutes');
else
    %errorbar(x, LvArray, stdLv * ones(N,1));
    plot(x, LvArray);
    hold on;
    plot(x, meanLv * ones(N,1), 'r');
    plot(x, (meanLv - stdLv) * ones(N,1), 'gr');
    plot(x, (meanLv - uXLv) * ones(N,1), 'm');
    plot(x, (meanLv + stdLv) * ones(N,1), 'gr');
    
    plot(x, (meanLv + uXLv) * ones(N,1), 'm');
    hold off;
    xlabel('Measurement i');
end
l = legend('$$v_{i}$$','$$\overline{v_{i}}$$','$$\overline{v_{i}} \pm s$$','$$\overline{v_{i}} \pm u(x)$$');
set(l,'Interpreter','latex');
title(sprintf('Set of %d Measurements',N));
ylabel('Lv in cd/m^{2}');
axis('tight');
if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_Lv'),'epsc');
    saveas(gcf,strcat(filename,'_Lv'),'fig');
end

%histogram
figure
hist(LvArray);


%%analyze xy data
xyArray = zeros(N,2);
for i = 1 : N
    try
        xyArray(i,1) = measurements{i}.colorimetricData.x;
        xyArray(i,2) = measurements{i}.colorimetricData.y;
    end
end

%xy Plot
figure;
if(exist('t'))
    plot(t, xyArray(:,1));
    hold on;
    plot(t, xyArray(:,2),'r');
    hold off;
    xlabel('time in minutes');
else
    plot(x, xyArray(:,1));
    hold on;
    plot(x, xyArray(:,2),'r');
    hold off;
    xlabel('Measurement i');
end
legend('x','y');
title(sprintf('Set of %d Measurements',N));
ylabel('x,y in %');
axis('tight');
if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_xy1'),'epsc');
    saveas(gcf,strcat(filename,'_xy1'),'fig');
end

%second xy plot
figure;
plot(xyArray(:,1),xyArray(:,2),'o');
xlabel('x in %');
title(sprintf('Set of %d Measurements',N));
ylabel('y in %');
axis('tight');
if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_xy2'),'epsc');
    saveas(gcf,strcat(filename,'_xy2'),'fig');
end

%evaluate spectral data
SpectralArray = zeros(length(measurements),401);
for i = 1 : N
    try
        SpectralArray(i,:) = measurements{i}.spectralData;
    end
end
meanSpectral = mean(SpectralArray);
stdSpectral = std(SpectralArray);

%
figure
plot(lambda,SpectralArray(1,:))

%errorbar(x, meanSpectral, stdSpectral);
% figure;
% semilogy(lambda, meanSpectral);
% %plot(x, meanSpectral + stdSpectral, 'r');
% title(sprintf('Mean of %d Measurements',N));
% xlabel('\lambda in nm');
% ylabel('\Phi_{e\lambda} in W / nm');
% axis('tight');
% figure;
% semilogy(lambda, stdSpectral);
% title(sprintf('Std of %d Measurements',N));
% xlabel('\lambda in nm');
% ylabel('\Phi_{e\lambda} in W / nm');
% axis('tight');

%mean and std
figure;
semilogy(lambda, meanSpectral,'r');
hold on;
%semilogy(lambda, meanSpectral + stdSpectral,'gr');
%semilogy(lambda, meanSpectral + stdSpectral / sqrt(N),'m');
%semilogy(lambda, meanSpectral - stdSpectral,'gr');
%semilogy(lambda, meanSpectral - stdSpectral / sqrt(N),'m');

hold off;
title(sprintf('Set %d Measurements',N));
%l = legend('$$\overline{v_{i}}(\lambda)$$','$$\overline{v_{i}}(\lambda) \pm s$$','$$\overline{v_{i}}(\lambda) \pm u(x)$$');
%set(l,'Interpreter','latex');
xlabel('\lambda in nm');
ylabel('L_{e}(\lambda) in W / sr m^{2}');
set(gca,'XTick',ticks);
set(gca,'XTickLabel',ticks);
%legend('mean','std');
axis('tight');
if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_Le1'),'epsc');
    saveas(gcf,strcat(filename,'_Le1'),'fig');
end

%mesh
if(N > 1)
    figure
    if(exist('t'))
        mesh(t, lambda, SpectralArray');
        xlabel('t in minutes');
    else
        mesh(x, lambda, SpectralArray');
        xlabel('measurement i');
    end
    title(sprintf('CS2000 L_{e}: %d Measurements, %s',N,filename));
    ylabel('\lambda in nm');
    zlabel('L_{e}(\lambda) in W / sr m^{2} nm');
    set(gca,'YTick',ticks);
    set(gca,'YTickLabel',ticks);
    axis('tight');
    set(gca,'ZScale','log');
    %view(-90,0)
    view(65,45)
    if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_Le2'),'epsc');
    saveas(gcf,strcat(filename,'_Le2'),'fig');
end
end

%std / mean
figure;
semilogy(lambda, stdSpectral ./ meanSpectral * 100);
title(sprintf('CS2000 L_{e}: Std / Mean of %d Measurements',N));
xlabel('\lambda in nm');
ylabel('std of mean in %');
set(gca,'XTick',ticks);
set(gca,'XTickLabel',ticks);
axis('tight');
if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_Le3'),'epsc');
    saveas(gcf,strcat(filename,'_Le3'),'fig');
end


%keithley data
if(exist('gpibMeasurements'))
    figure;
    if(exist('t'))
        plot(t,gpibMeasurements);
    else
        plot(x,gpibMeasurements);
    end
    title(sprintf('Keithley-199 %s: Set of %d Measurements',unit,N));
    xlabel('time in minutes');
    ylabel(sprintf('%s',unit));
    axis('tight');
    if(SAVEFIGURES)
    saveas(gcf,strcat(filename,'_U'),'epsc');
    saveas(gcf,strcat(filename,'_U'),'fig');
end
end



