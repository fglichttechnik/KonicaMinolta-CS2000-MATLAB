I. Using CS2000_gettingStarted.exe as standalone application:
_____________________________________________________________
=============================================================

	
	1. Connecting the instrument to your PC/Installing the USB driver
	=================================================================

	-Turn off both the instrument and the computer.
	-Connect the instrument and the computer via USB cable.
	-Turn on the instrument and the computer.
	-Start Windows on your computer.
	-The "Found New Hardware Wizard" starts up. 
	-Select "Browse my computer for driver software" as the method to search 
	 for the driver.
	-Select the folder where the file Kmsecs2000.inf is located or select the 
	 file Kmsecs2000.inf by itself (depends on your Windows version).
	-The USB driver installation process starts.

	2. COM-Port
	===========

	-Confirm the COm port of the computer to which the instrument is assigned. Select 
	 Control Panel - System from the Start menu. 
	-On the Hardware tab, select Device Manager, and click "Ports (COM & LPT)" to 
	 expand it. 
	-The assigned COM port number is displayed. This COM port number is required when 
	 you start the program and when the instrument ist connected.

	3. Install the MCR Installer 
	============================
	-Double click the MCRInstaller.exe file and follow the instructions.
		
	4. Start the standalone execution file:
	=======================================
	-Double click the CS2000_gettingStarted.exe file.
	-At first you have to chose the COM port to which the instrument is assigned.
	-By success the menue Guide opens and you can start your measurements.

	5. Data format:
	===============
	-By chosing "Save" in the guide the measurement will be saved as .mat-file.



II. Using CS2000_gettingStarted.m with Matlab:
_____________________________________________________________
=============================================================
	
	1. Connecting the instrument to your PC/Installing the USB driver
	=================================================================

	-Turn off both the instrument and the computer.
	-Connect the instrument and the computer via USB cable.
	-Turn on the instrument and the computer.
	-Start Windows on your computer.
	-The "Found New Hardware Wizard" starts up. 
	-Select "Browse my computer for driver software" as the method to search 
	 for the driver.
	-Select the folder where the file Kmsecs2000.inf is located or select the 
	 file Kmsecs2000.inf by itself (depends on your Windows version).
	-The USB driver installation process starts.

	2. COM-Port
	===========

	-Confirm the COm port of the computer to which the instrument is assigned. Select 
	 Control Panel - System from the Start menu. 
	-On the Hardware tab, select Device Manager, and click "Ports (COM & LPT)" to 
	 expand it. 
	-The assigned COM port number is displayed. This COM port number is required when 
	 you start the program and when the instrument ist connected.
		
	3. Start the guide:
	=======================================
	-Start the CS2000_gettingStarted.m file	in the Matlab command window.
	-At first you have to chose the COM port to which the instrument is assigned.
	-By success the menue Guide opens and you can start your measurements.

	4. Data format:
	===============
	-By chosing "Save" in the guide the measurement will be saved as .mat-file.