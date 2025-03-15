PassMark (TM) Software's BurnInTest for Linux
Copyright (C) 2024 PassMark Software
All Rights Reserved
https://www.passmark.com

Overview
========
Passmark's BurnInTest for Linux is a software tool that allows all
the major sub-systems of a computer to be simultaneously
tested for reliability and stability.
<For more details see PDF format help file>


Status
======
This is a shareware program.
This means that you need to buy it if you would like
to continue using it after the evaluation period.


What's in the "burnintest" folder?
====================================
	BITErrorClassification.txt (see documentation how to customize your errors).
 	help folder (html based help)
	bit_gui_x64 (BurnInTest Linux GUI 64 bit version, double-click to launch app).
	bit_cmd_line_x64 (BurnInTest Linux command line 64 bit version).
	cmdline_config.txt (Text based config file for command line version)
	savedkey.dat (to get you started with the unregistered shareware version)
	BurnInTest_Linux_CLI_EULA.txt
	readme.txt
 	burnintest.sh (a script to check for 64 bit libraries and launch BurnInTest)
	plugin_example folder (containing example code for using an external plugin with burnintest)

Installation
============
1.	Uninstall any previous version of BurnInTest Linux by
	deleting it's folder.
2.	Copy the new "burnintest" folder to your desired location
	or copy the contents of the new "burnintest" folder
	to your desired folder
	(I shall call this the destination_folder throughout this documentation).
3.	Make sure you have read write permission for the destination_folder.
	This can be done with a CTL-I when you select the destination_folder's icon
	and changing the permission to read/write for owner, group and others.
	This can also be done via the command line with
	"chmod 774 destination_folder". 
	You can only do this if you are the owner of the destination_folder
	or if you logged in as root user.
	(To change ownership of files/folders, use
	"chown user_name:user_group file_name".
	Type "man chmod" or "man chown" if you need assistance.)
4.	Also make sure you have read/write permission for the "savedkey.dat"
	file and "LastUsed.cfg" file by following step (3).

UnInstallation
==============
Delete the folder that it was previously installed in or delete
the contents of the folder.


How to launch application
==========================
1.	Application can be launched by double-clicking on the "burnintest.sh" icon, or 
	choosing a specific instance of BurnInTest to run.

2.	To run application via the command line, from your terminal:
	i)	Change the current working directory to the destination_folder by
		typing "cd path_to_destination_folder"  (There is an easy way to copy
		path by dragging the destination_folder's icon into the terminal).
	ii)	To be sure you have changed your working directory to destination_folder,
		issue a "pwd" command on the command line.  This will print the path
		of the working directory.  In this case, "path_to_destination_folder"
		should be the output.
	iii)	Run the launch script by typing "./burnintest.sh" which will determine 
		if you are using 64 bit linux, if the required libraries are 
		available and launch BurnInTest	
3.	To choose which versions of BurnInTest to run (64 bit, GUI/command line)	
	i)	Change the current working directory to the destination_folder by
		typing "cd path_to_destination_folder"  (There is an easy way to copy
		path by dragging the destination_folder's icon into the terminal).
	ii)	To be sure you have changed your working directory to destination_folder,
		issue a "pwd" command on the command line.  This will print the path
		of the working directory.  In this case, "path_to_destination_folder"
		should be the output.	
	iii)	Launch the application by typing 
		"./bit_gui_x64" for 64 bit GUI version,
		"./bit_cmd_line_x64" for 64 bit command line version
	

Hardware Requirements
======================
-	Intel and AMD compatible CPU.
-	Recommended 256MB of memory.
-	10MB Disk space (more is required to run the disk test).
-	Optional serial and parallel loop back plugs for port testing.
-	A network connection for network testing.
-	A CD ROM + 1 Music CD or Data CD to run the CD test.
-	Optional specialized PassMark test CD/DVDs to run PassMark's CD/DVD test.
-	Optional PassMark USB2/USB3 test plugs for usb test


Software Requirements:  	
======================
- 64bit Linux
- Linux kernel 4.16 or higher
- glibc 2.25 or higher
- Qt 5.9.4 and higher
- Open GL 1.2 and higher (for 3D graphics test plus working Open GL drivers
  for your video card).
- libusb 1.0
- Administrator privilleges are required for certain tests.


Linux distributions that meet these requirement (GUI version):  	
=========================================================
So far, the following distributions have been tested (or reported) that
met these requirements:

Fedora 26 with Qt 5.9.4 installed

The command line version requires far less libraries and should work on most distributions.


For a more comprehensive list, please refer to:
https://www.passmark.com/support/bitlinux_faq.htm#software_requirement

To aid us in making the software better for you, please e-mail to
help@passmark.com if you have tested successfully in another Linux distribution
of if you encountered issues with running BurnInTest for Linux
on your system.


Version History
===============
See below link for all changes:
https://www.passmark.com/products/burnintest/bitlinux_history.php


Documentation
=============
All the documentation is included in HTML format in the help directory in the
32bit and 64bit folders. It can be accessed from the help menu in the GUI version.


Support
=======
For technical support, questions, suggestions, please check the help file for 
our email address or visit our web page at https://www.passmark.com


FAQs
=======
Visit our web page at https://www.passmark.com/support/bitlinux_faq.htm
for the BurnInTest Linux FAQ page.


Ordering / Registration
=======================
All the details are in the help file documentation
or you can visit our sales information page
https://www.passmark.com/sales


Compatibility issues with the BurnInTest Linux
===========================================================
You need to have administrator privileges to run the following test:
1.	Serial Port Test:
	Linux character devices are usually root access only.
	For this test, we might be accessing /dev/ttyS0 - /dev/ttyS63 depending on your configuration.
2.	Parallel Port Test:
	Root access is required to access memory location for the parallel ports.
	(lp0 @ 0x378, p1 @ 0x278 or lp2 @ 0x3BC)
3.	Memory Test:
	As we are locking physical memory to prevent caching, root access is needed to call this function.
4.	Network Test:
	Root access is required to create raw sockets for the address family AF_INET.


Enjoy..
The PassMark Development team
