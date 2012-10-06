AUTHOR: Jan Winter, TU Berlin, FG Lichttechnik,
	j.winter@tu-berlin.de, www.li.tu-berlin.de
LICENSE: free to use at your own risk. Kudos appreciated.

This is a framework for MATLAB to communicate with a KonicaMinolta CS-2000 spectroradiometer. Also provided is a GUI. 

% start the GUI with this function:
CS2000_startGUI();

% measurements from command line:
comPort = 'COM4';
CS2000_initConnection( comPort );
[message1, message2, cs2000Measurement, colorimetricNames] = CS2000_measure();
CS2000_terminateConnection();
