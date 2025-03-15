//PassMark PluginTest (Part of BurnInTest)
//Copyright 2004-2014
//
//Program:  PluginTest
//Author:   Ian Robinson
//Module:   PluginTestInterface.cpp
//
//Description:  
//	Shared memory interface definition between BurnInTest and the external plugin Test
//
//History
//  27-May-14 Updated for Linux use
//  10-Sep-10 Updated for version 4 of PLUGININTERFACE with a longer event strings allowed (100 to 200 characters)
//  03-Mar-08 Updated for version 3 of PLUGININTERFACE with 6 User defined fields (up from 2)
//  13-Dec-05 Updated for version 2 of PLUGININTERFACE with a new state PLUGIN_COMPLETED
//  18-Feb-05 Updated for version 2 of PLUGININTERFACE
//  03-Sep-04 Module created
//
#ifndef	_CTEST_PLUGINTESTINTERFACE_H_
#define	_CTEST_PLUGINTESTINTERFACE_H_


#define	PLUGIN_INTERFACE_VERSION	 4

#define	PLUGIN_MAXDISPLAYTEXT		20		
#define	PLUGIN_MAXERRORTEXT		100
#define	PLUGIN_MAXERRORTEXTLONG		201


//List of possible status for OUT_iStatus
#define	PLUGIN_NOSTATUS				0		
#define	PRE_TEST_PLUGIN_COMPLETED	9		//If this is flagged in status then BurnInTest will close the interface to the Plugin and continue - for a pre-test plugin
#define	PLUGIN_MAXVAL				10				//Must always be one bigger than the last value

enum
{
	ERRORNONE = 0,
	ERRORINFORMATION,
	ERRORWARNING,
	ERRORSERIOUS,
	ERRORCRITICAL,
	ERRORTERM
};


#define	PLUGIN_NOTUSED		-1

#define PLUGIN_SHAREDMEM_PROJID	1 //Used to get a key to open the shared memory

//Shared memory interface structure
#pragma pack(push, 1)
typedef struct _PLUGININTERFACE {
	//
	// Data sent to the Plugin test application to BurnInTest
	//
	int		IN_TestRunning;		//True if tests are still running
	int		IN_DutyCycle;		//Duty cycle setting (1-100)

	//
	// Data sent from the Plugin test application to BurnInTest
	//
	int		OUT_Plugin_interface_version;		//Version of the Interface include file, must be set first (before labels are set)

	char	OUT_szWindowTitle[PLUGIN_MAXDISPLAYTEXT];		//Test title
	unsigned int	OUT_iCycle;													//How many cycles have been completed
	int	OUT_iStatus;																	//Status - only used to signal Pre-test plugin is complete using PRE_TEST_PLUGIN_COMPLETED
	char	OUT_szStatus[PLUGIN_MAXDISPLAYTEXT];				//Status Text - dsplayed in BurnInTest as status of PLugin
	
	int	OUT_iErrorCount;															//How many errors
	char	OUT_szError[PLUGIN_MAXERRORTEXT];						//Last error message
	int	OUT_iErrorSeverity;														//Last error severity
	
	char	OUT_szWriteOps[PLUGIN_MAXDISPLAYTEXT];			//Text to be displayed against the Write operations (eg. Write (MB))
	int64_t	OUT_i64WriteOps;													//How many write operations ; -1 indicates Not applicable
	
	char	OUT_szReadOps[PLUGIN_MAXDISPLAYTEXT];				//Text to be displayed against the Write operations (eg. Read (KB))
	int64_t	OUT_i64ReadOps;														//How many read operations ; -1 indicates Not applicable
	
	char	OUT_szVerifyOps[PLUGIN_MAXDISPLAYTEXT];			//Text to be displayed against the Write operations (eg. Verify (MB))
	int64_t	OUT_i64VerifyOps;													//How many verify opertions; -1 indicates Not applicable
	
	bool	OUT_bUserDef1;															//True if User defined Value 1 is used, otherwise should be set to false
	char	OUT_szUserDef1[PLUGIN_MAXDISPLAYTEXT];			//Text to be displayed against the User defined string field (eg. "Throughput (Mb/s)")
	char	OUT_szUserDefVal1[PLUGIN_MAXDISPLAYTEXT];		//Text string of user defined field (eg. "flying high")

	bool	OUT_bUserDef2;															//True if User defined Value 2 is used, otherwise should be set to false
	char	OUT_szUserDef2[PLUGIN_MAXDISPLAYTEXT];			//Text to be displayed against the User defined string field (eg. "Throughput (Mb/s)")
	char	OUT_szUserDefVal2[PLUGIN_MAXDISPLAYTEXT];		//Text string of user defined field (eg. "flying high")

	//
	// Event flags
	//
	bool	OUT_bDisplayTextSet;		//Flag to indicate that new label text has been set (1 label through to all labels), set by the Plugin, cleared by BIT
																//Note: Label must be set at the start of the plugin, then this flag set to true. 
																//BIT will set it back to false when it has read the values
																//To change the labels at any time, just re-wrtie the appropriate label string and again set this to true
	bool	OUT_bNewError;					//Flag to indicate that a new error has occurred, set by the Plugin, cleared by BIT
	bool	OUT_bNewStatus;					//Flag to indicate that new status text is available, set by the Plugin, cleared by BIT
	bool	OUT_bNewUserDefVal1;		//Flag to indicate that new User defined value 1 text is available, set by the Plugin, cleared by BIT
	bool	OUT_bNewUserDefVal2;		//Flag to indicate that new User defined value 2 text is available, set by the Plugin, cleared by BIT
	bool	OUT_bTestStopped;				//Future use - do not use

	//	V3 of Interface.
	//
	// Data sent from the Plugin test application to BurnInTest
	// 

	bool	OUT_bUserDef3;														//True if User defined Value 2 is used, otherwise should be set to false
	char	OUT_szUserDef3[PLUGIN_MAXDISPLAYTEXT];		//Text to be displayed against the User defined string field (eg. "Throughput (Mb/s)")
	char	OUT_szUserDefVal3[PLUGIN_MAXDISPLAYTEXT];	//Text string of user defined field (eg. "flying high")

	bool	OUT_bUserDef4;														//True if User defined Value 2 is used, otherwise should be set to false
	char	OUT_szUserDef4[PLUGIN_MAXDISPLAYTEXT];		//Text to be displayed against the User defined string field (eg. "Throughput (Mb/s)")
	char	OUT_szUserDefVal4[PLUGIN_MAXDISPLAYTEXT];	//Text string of user defined field (eg. "flying high")

	bool	OUT_bUserDef5;														//True if User defined Value 2 is used, otherwise should be set to false
	char	OUT_szUserDef5[PLUGIN_MAXDISPLAYTEXT];		//Text to be displayed against the User defined string field (eg. "Throughput (Mb/s)")
	char	OUT_szUserDefVal5[PLUGIN_MAXDISPLAYTEXT];	//Text string of user defined field (eg. "flying high")

	bool	OUT_bUserDef6;														//True if User defined Value 2 is used, otherwise should be set to false
	char	OUT_szUserDef6[PLUGIN_MAXDISPLAYTEXT];		//Text to be displayed against the User defined string field (eg. "Throughput (Mb/s)")
	char	OUT_szUserDefVal6[PLUGIN_MAXDISPLAYTEXT];	//Text string of user defined field (eg. "flying high")

	//	V4 of Interface.  
	//
	// Data sent from the Plugin test application to BurnInTest
	// 
	char	OUT_szErrorLong[PLUGIN_MAXERRORTEXTLONG];	//Last error message. Longer text supported than OUT_szError. Use OUT_szError or OUT_szErrorLong.
 

} PLUGININTERFACE;
#pragma pack(pop)

#endif //_CTEST_PLUGINTESTINTERFACE_H_
