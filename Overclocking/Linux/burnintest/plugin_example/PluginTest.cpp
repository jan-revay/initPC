//PassMark PluginTest (Part of BurnInTest)
//Copyright 2005-2014
//
//Program:  PluginTest
//Author:   Ian Robinson
//Module:   PluginTestInterface.cpp
//
//Description:  
//	This software demonstrates how to interface an external plug-in test module with BurnInTest.
//	
//	BurnInTest will attmpt to start this application when the Plug-in test is run and this application
//	is specified as the Plug-in file.
//
//	BurnInTest will pass a flag that indicates that the test run is still underway 
//	(e.g. has/ has  not been stopped by the user)
//
//	BurnInTest will pass in the Duty cycle.
//
//  Before starting the test, the plugin application must initialise the test parameters and flag that 
//	they have been set.
//
//	Once the test is started, the test result parameters and the test window labels, "OUT_..." may be changed. 
//	Any changes will be picked up by BurnInTest. Specific cases where the plugin must flag to BurnInTest
//	that new parameters are available are for a new labels (as a group flag), error, a new status message and 
//	the user defined strings 1 & 2. You may need to check that BIT has read the old values before writing new values,
//	this sample application does this for changing the window display labels only. 
//
//  See the Interface definition PLUGININTERFACE and the source code for details.
//
//History
//  26-5-14 Updated for linux example, version 4 of PLUGININTERFACE
//  18-2-05 Updated for version 2 of PLUGININTERFACE
//  03-9-04 Module created
//

#define PLUGIN_WRITE "Plug-in write"
#define PLUGIN_READ  "Plug-in read"
#define PLUGIN_WAIT  "Plug-in sleep"

#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include "PluginTestInterface.h"


static PLUGININTERFACE	*BitInterface;
static int	BufferPattern;


//Function prototype
void strn_clean_cpy (char * szTextOut, const char * szTextIn, int iStrLen);


//
//Entry point
//	Expects
//		- Duty cycle setting
int main (int argc, char *argv[]) 
{

	
	unsigned int	Cycle;
	bool	bErrorCondition = false;
	int		iNumWrites = 100;		//for demonstration purposes
	int		i;
	int		iTestPhase;
	char	szTemp[PLUGIN_MAXDISPLAYTEXT];
	bool	bSetLabels = false;
	key_t			sharedMemKey ; 		//Key used to created shared mem ID
	int			sharedMemID = NULL;

	//Check command line is correct
	if (argc != 1)
		return(1);

	//Create shared memory interface
	//Get a key based on filename and an ID, need to sue same ID in client program when opening shared memory
	sharedMemKey = ftok(argv[0], PLUGIN_SHAREDMEM_PROJID); 
	if(sharedMemKey == -1)
	{
	  printf("Failed to get shared memory key\n");
	  return(1);
	}

	//Create shared memory segment and get the shared mem ID
	sharedMemID = shmget(sharedMemKey, sizeof(PLUGININTERFACE),  0777);
	if(sharedMemID == -1)
	{
	  printf("Failed to get shared memory ID\n");
	   return(1); 
	}

	//Get pointer to the shared memory
	BitInterface = (PLUGININTERFACE *) shmat(sharedMemID, NULL, 0);
	if( BitInterface  == NULL)
	{
	  printf("Failed to attach shared memory\n");
		return 1; 
	}
	
	//Set initial test values
	BitInterface->OUT_Plugin_interface_version = PLUGIN_INTERFACE_VERSION;
	BitInterface->OUT_iCycle = 0;
	BitInterface->OUT_iStatus = 0;
	BitInterface->OUT_iErrorCount = 0;
	BitInterface->OUT_iErrorSeverity = 0;
	BitInterface->OUT_i64WriteOps = 0;
	BitInterface->OUT_i64ReadOps = 0;
	BitInterface->OUT_i64VerifyOps = 0; 
	
	strn_clean_cpy(BitInterface->OUT_szUserDefVal1,"0 apples", PLUGIN_MAXDISPLAYTEXT);	
	BitInterface->OUT_bUserDef1 = true;
	BitInterface->OUT_bNewUserDefVal1 = true;

	strn_clean_cpy(BitInterface->OUT_szUserDefVal2,"0 oranges", PLUGIN_MAXDISPLAYTEXT);	
	BitInterface->OUT_bUserDef2 = true;
	BitInterface->OUT_bNewUserDefVal2 = true;

	BitInterface->OUT_bNewError = false;		
	BitInterface->OUT_bNewStatus = false;		
	BitInterface->OUT_bTestStopped = false;	

	// Set the labels that will be displayed on the BurnInTest Plugin Test window
	strn_clean_cpy(BitInterface->OUT_szWindowTitle,"Test plugin", PLUGIN_MAXDISPLAYTEXT);	
	strn_clean_cpy(BitInterface->OUT_szStatus,"Starting", PLUGIN_MAXDISPLAYTEXT);				
	strn_clean_cpy(BitInterface->OUT_szError,"", PLUGIN_MAXERRORTEXT);						
	strn_clean_cpy(BitInterface->OUT_szWriteOps, "Write (MBytes):", PLUGIN_MAXDISPLAYTEXT);						
	strn_clean_cpy(BitInterface->OUT_szReadOps,"Read (MBytes):", PLUGIN_MAXDISPLAYTEXT);							
	strn_clean_cpy(BitInterface->OUT_szVerifyOps, "Verify (MBytes):", PLUGIN_MAXDISPLAYTEXT);
	strn_clean_cpy(BitInterface->OUT_szUserDef1,"Apples:", PLUGIN_MAXDISPLAYTEXT);				
	strn_clean_cpy(BitInterface->OUT_szUserDef2, "Oranges:", PLUGIN_MAXDISPLAYTEXT);	
	BitInterface->OUT_bDisplayTextSet = true;
		

	Cycle = 0;
	iTestPhase = 1;

	//Run the test until BurnInTest flags that the test has been stopped
	//Write , read and verify test data in a loop
	// WARNING: Never perform any activity that takes more than 1 second without 
	// checking the stop condition IN_TestRunning
	while (BitInterface->IN_TestRunning) 
	{
		//////////////////////////////////////////
		//Write
		//////////////////////////////////////////
		strn_clean_cpy(BitInterface->OUT_szStatus, PLUGIN_WRITE, PLUGIN_MAXDISPLAYTEXT);
		BitInterface->OUT_bNewStatus = true;		//flag that a new status string is available

		// .... insert any write operations here 
		// eg. loop writing to disk
		for (i=0;i<iNumWrites;i++)
		{
			usleep(10000);								//insert Write operation
			
			BitInterface->OUT_i64WriteOps += 1;
			
			if (iTestPhase  == 1)
			{
				sprintf(szTemp,"%ld apples", BitInterface->OUT_i64WriteOps);
				strn_clean_cpy(BitInterface->OUT_szUserDefVal1,szTemp, PLUGIN_MAXDISPLAYTEXT);	//Note: you may wait to ensure BIT has read the old value
				BitInterface->OUT_bNewUserDefVal1 = true;
			}
			else if (iTestPhase  == 2)
			{
				sprintf(szTemp,"%ld apes", BitInterface->OUT_i64WriteOps);
				strn_clean_cpy(BitInterface->OUT_szUserDefVal1,szTemp, PLUGIN_MAXDISPLAYTEXT);	//Note: you may wait to ensure BIT has read the old value
				BitInterface->OUT_bNewUserDefVal1 = true;
			}

		}
		// ........................................

		//////////////////////////////////////////
		//Read
		//////////////////////////////////////////
		strn_clean_cpy(BitInterface->OUT_szStatus, PLUGIN_READ ,PLUGIN_MAXDISPLAYTEXT);
		BitInterface->OUT_bNewStatus = true;		//flag that a new status string is available

		// ...... insert any read operations here .
		// eg. loop reading from disk
		for (i=0;i<iNumWrites;i++)
		{
			usleep(10000);								//insert Write operation

			BitInterface->OUT_i64ReadOps  += 1;

					
			
			if (iTestPhase  == 1)
			{
				sprintf(szTemp,"%ld oranges", BitInterface->OUT_i64ReadOps);
				strn_clean_cpy(BitInterface->OUT_szUserDefVal2,szTemp, PLUGIN_MAXDISPLAYTEXT);	//Note: you may wait to ensure BIT has read the old value
				BitInterface->OUT_bNewUserDefVal2 = true;
			}
			else if (iTestPhase  == 2)
			{
				sprintf(szTemp,"%ld monkeys", BitInterface->OUT_i64ReadOps);
				strn_clean_cpy(BitInterface->OUT_szUserDefVal2,szTemp, PLUGIN_MAXDISPLAYTEXT);	//Note: you may wait to ensure BIT has read the old value
				BitInterface->OUT_bNewUserDefVal2 = true;
			}
		}

		//////////////////////////////////////////
		//Verify
		//////////////////////////////////////////

		// ...... insert any read operations here .
		// eg. loop verifying data read from disk
		BitInterface->OUT_i64VerifyOps += 1;

		bErrorCondition = true; //just for demonstration

		if (bErrorCondition)
		{
			//Allow BIT a chance to clear the last error, before passing a new one
			while (BitInterface->IN_TestRunning && BitInterface->OUT_bNewError)
				usleep (500000);	
			
			BitInterface->OUT_iErrorCount++;
			BitInterface->OUT_iErrorSeverity = ERRORINFORMATION;
			strn_clean_cpy(BitInterface->OUT_szError,
							"Plugin specified error message. This may be up to 100 characters long ABCDEFGHIJKLMNOPQRSTUVWXYZ", 
							PLUGIN_MAXERRORTEXT);
			BitInterface->OUT_bNewError = true;
		}

		//////////////////////////////////////////
		//Cycle finished
		//////////////////////////////////////////
		strn_clean_cpy(BitInterface->OUT_szStatus, PLUGIN_WAIT, PLUGIN_MAXDISPLAYTEXT);
		BitInterface->OUT_bNewStatus = true;		//flag that a new status string is available

		BitInterface->OUT_iCycle += 1;	//Update the BIT cycle counter
		

		// Introduc a duty cycle delay (in this case between cycles)
		if (BitInterface->IN_TestRunning)
			usleep ((100 - BitInterface->IN_DutyCycle) * 20000); //For demonstartion purposes. The Duty cycle delay could be inserted anywhere.


		//Check for a change in the test phase. As the test window labels may need to change.
		// Change the test labels for the next type of test
		// Don't write new values until BIT has flagged that it has read the old ones.
		if (BitInterface->OUT_iCycle == 10 && iTestPhase == 1) //10 is just an arbitrary number of cycles for the first test phase
		{
			iTestPhase = 2;
			bSetLabels = false;
			while (BitInterface->IN_TestRunning && !bSetLabels) 
			{
				if (BitInterface->OUT_bDisplayTextSet == false)	//Previous labels not yet read by BIT
				{
					strn_clean_cpy(BitInterface->OUT_szWindowTitle,"Test plugin2", PLUGIN_MAXDISPLAYTEXT);	
					strn_clean_cpy(BitInterface->OUT_szStatus,"Eating Bannanas", PLUGIN_MAXDISPLAYTEXT);				
					strn_clean_cpy(BitInterface->OUT_szWriteOps, "Bannanas Grown:", PLUGIN_MAXDISPLAYTEXT);						
					strn_clean_cpy(BitInterface->OUT_szReadOps,"Banannas Eaten:", PLUGIN_MAXDISPLAYTEXT);							
					strn_clean_cpy(BitInterface->OUT_szVerifyOps, "Bannanas enjoyed:", PLUGIN_MAXDISPLAYTEXT);
					strn_clean_cpy(BitInterface->OUT_szUserDef1,"Gorillas happy:", PLUGIN_MAXDISPLAYTEXT);				
					strn_clean_cpy(BitInterface->OUT_szUserDef2, "Gorillas sad:", PLUGIN_MAXDISPLAYTEXT);	
					BitInterface->OUT_bUserDef2 = false;		//User defined value 2 not used for test phase 2 
					BitInterface->OUT_bDisplayTextSet = true;	//signal to BIT that the labels have been updated and that they should be changed
					bSetLabels = true;
				}
				else
					usleep(1000000);
			}
		}
	}

	//Clean up
	BitInterface->OUT_iStatus = PRE_TEST_PLUGIN_COMPLETED;

	shmdt(BitInterface);
	return (0);
}


//strn_clean_cpy 
// 
// Use this function to cpy any string to the BurnInTest Interface to ensure bonudary lengths are not exceeded
//
// does a strncpy, but cleans the string up first (removes funny characters, '%' and '\' and make them spaces)
//
void strn_clean_cpy (char * szTextOut, const char * szTextIn, int iStrLen)
{
	char	szTextTemp[PLUGIN_MAXERRORTEXT+1];
	bool	bEndString = false;

	if (iStrLen != PLUGIN_MAXERRORTEXTLONG && iStrLen > PLUGIN_MAXERRORTEXT)
		iStrLen  = PLUGIN_MAXERRORTEXT;

	for (int i = 0; i < iStrLen; i++)
	{
		if (szTextIn[i] == '\0' || bEndString)
		{
			szTextTemp[i] = '\0';
			bEndString = true;
		}
		else if (szTextIn[i] < 0x020)
			szTextTemp[i] = ' ';
		else if (szTextIn[i] == '%')
			szTextTemp[i] = ' ';
		else if (szTextIn[i] == '\\')
			szTextTemp[i] = ' ';
		else
			szTextTemp[i] = szTextIn[i];
	}
	szTextTemp[iStrLen-1] = '\0'; //Make sure its terminated

	strncpy (szTextOut, szTextTemp, iStrLen);
	szTextOut[iStrLen-1] = '\0'; 
}
