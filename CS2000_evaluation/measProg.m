% AUTHOR:	Jan Winter, Sandy Buschmann, TU Berlin, FG Lichttechnik,
% 			j.winter@tu-berlin.de, www.li.tu-berlin.de
% LICENSE: 	free to use at your own risk. Kudos appreciated.


%this script takes every N seconds a CS2000 and a Keithley 199 measurement

%



%measuremode

%NUMBER: make N measurements

%TIME: measure for TIME_MINUTES

MEASURE_MODE = 'NUMBER';



%either time or N is used depending on MEASURE_MODE

N = 50;            %total number of measurements

TIME_MINUTES = 30;          %We want to measure that long



%preferences

WAITSECONDS = 0;    %time to leave the lab

TIME_BETWEEN_MEASUREMENTS = 0; %min time in seconds between measurements, can't be guaranteed, that it isn't (much - 260s) longer

COMMENTS_FOR_MEASUREMENT = 'CS2000 aufgewärmt;';

LIGHTSOURCE = 'iPhone4 LED';

FILENAME = 'iPhone4_LED_APERTUREFILL_DATE_TMP.mat';   %_APERTUREFILL_DATE_TMP.mat

PLAYSOUND = 1; %if != 0 a sound is played after each measurement

KEITHLEY = 0; %if != 0 the keithley 199 is used to aquire data

SAVEDATA = 1; %if != 0 the data will be saved

MEASUREMENTS_PATH = 'measurements'; %measured data will be saved here

ND_FILTER = 0;    %0 => 0, 10 => 1, 100 => 2



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%no adjustments need to be done below



%create measurements directory

if(SAVEDATA)

    if(~exist(MEASUREMENTS_PATH,'dir'))

        mkdir(MEASUREMENTS_PATH);

    end

end



%add directories for CS2000

currentPath = pwd;

if(ispc)    

    addpath([currentPath, '\CS2000\Wrapper']);

    addpath([currentPath, '\CS2000\classes']);

    addpath([currentPath, '\Keithley199']);

elseif(isunix)

    addpath([currentPath, '/CS2000/Wrapper']);

    addpath([currentPath, '/CS2000/classes']);

    addpath([currentPath, '/Keithley199']);

end



%init

measurements = cell(N,1);

if(KEITHLEY)

    Keithley199_gpibMeasurements = zeros(N,1);

end



%%indicate when finished

Fs = 44100;

f = 500;

lenSeconds = .5;

beepSound = sin(2 * pi * f * linspace(0,lenSeconds ,Fs * lenSeconds));



%time to leave the lab or prepare measurements

pause(WAITSECONDS);

if(PLAYSOUND)

    sound(beepSound,Fs);

    if(WAITSECONDS)

        pause(5)

    end

end



%init connection data



CS2000_initConnection;

if(KEITHLEY)

    gpibObj = Keithley199_initGPIBConnection;

end



%set backlight off while measuring

CS2000_setBacklight(1,0);



%get aperture angle

aperture = CS2000_readApertureStop;



%set ND filter

CS2000_setNDFilter(ND_FILTER);



%set filename to preferences name

filename = FILENAME;



%adjust filename according to aperture

if(aperture)

    aperture = regexprep(aperture,'°','');

    aperture = regexprep(aperture,'\.','');

    if(strcmp(aperture,'1'))

        aperture = '10';

    end

    filename = regexprep(filename,'APERTUREFILL',aperture);

end



%adjust filename according to date

dateString = datestr(now);

dateString = regexprep(dateString,' ','_');

dateString = regexprep(dateString,':','-');

filename = regexprep(filename,'DATE',dateString);

filename = strcat(MEASUREMENTS_PATH,'/',filename);



%init timer

tic;

timeBetweenMeasurements = TIME_BETWEEN_MEASUREMENTS;



try    

    % for i = 1 : N

    %prepare while loop

    startTime = clock();

    time_elapsed = 0;

    i = 1;

    while_condition = 1;

    

    while(while_condition)

        %cs2000 measurement

        [a,b,measuredData,colormetricNames]= CS2000_measure;

        measuredData.comments = COMMENTS_FOR_MEASUREMENT;

        measuredData.lightSource = LIGHTSOURCE;

        measuredData.aperture = aperture;

        measurements{i} = measuredData;

        if(PLAYSOUND)

            sound(beepSound,Fs);

        end

        disp(measuredData.colorimetricData.Lv);

        disp(i);

        

        %plot data for supervising purposes during the experiment

        semilogy(linspace(380,780,401),measuredData.spectralData);

        pause(.1);

        

        %gpib measurement

        if(KEITHLEY)

            [gpibMeasurements(i), unit] = Keithley199_measValGPIB(gpibObj);

        end

        

        %pause for timeBetweenMeasurements

        pauseInterval = timeBetweenMeasurements - toc;

        if (pauseInterval > 0)

            disp(pauseInterval);

            pause(pauseInterval);

        end

        

        %save tmp measurements to file

        if(SAVEDATA)            

            if(KEITHLEY)

                save(filename,'measurements','gpibMeasurements','unit','N','TIME_BETWEEN_MEASUREMENTS');

            else

                save(filename,'measurements');

            end

        end

        

        %reset timer

        tic;

        

        %time elapsed

        time_elapsed = clock() - startTime;

        disp('time elapsed');

        disp(time_elapsed(5));

        i = i + 1;

        

        %modify while condition

        if(strcmp(MEASURE_MODE,'TIME'))

            while_condition = ((time_elapsed(5) < TIME_MINUTES) && (time_elapsed(5) >= 0));

        else

            while_condition = (i <= N);

        end

    end

    

    CS2000_terminateConnection;

    if(KEITHLEY)

        Keithley199_terminateGPIB(gpibObj);

    end

    

catch exception

    CS2000_terminateConnection;

    if(KEITHLEY)

        Keithley199_terminateGPIB(gpibObj);

    end

    disp(exception.message);

end



pause(1);

if(PLAYSOUND)

    sound(beepSound,Fs);

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%crop measurements array if not all measurements are available (cause we crashed before finishing)

for i = N : -1 : 1

    if(isempty(measurements{i}))

        Nnew = i;

    end

end

if(exist('Nnew'))

    N = Nnew - 1;

end

measurementsNew = cell(N,1);

for i = 1 : N

    measurementsNew{i} = measurements{i};

end

measurements = measurementsNew;



%replace TMP

filenameTMP = filename;

filename = regexprep(filename,'_TMP','');

%filename = strcat(MEASUREMENTS_PATH,'/',filename);



%save measurements to file

if(SAVEDATA)

    if(KEITHLEY)

        save(filename,'measurements','gpibMeasurements','unit','N','TIME_BETWEEN_MEASUREMENTS');

    else

        save(filename,'measurements');

    end

end

%delete TMP file

delete(filenameTMP);



%plot data if measurements are available

if(length(measurements))

    plotDataFromFile(filename,'time');

end



%clear all;





