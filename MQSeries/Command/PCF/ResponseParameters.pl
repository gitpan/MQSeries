#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries/Command/PCF/ResponseParameters.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros 
#
# (c) 1999, 2000 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

%ResponseParameters =
  (
   Error =>
   {
    ErrorId			=> [ 1013,             			3 ],
    ErrorOffset			=> [ 1018,                 		3 ],
    ParameterId			=> [ 1012,                 		3 ],
    Selector			=> [ 1014,             			3 ],
    CodedCharSetId		=> [ 2,                       		3 ],
   },

   QueueManager =>
   {
    Platform 			=> [ 32,             			3,		$ResponseValues{Platform} ],

    AlterationDate 		=> [ 2027,                  		4 ],
    AlterationTime 		=> [ 2028,                  		4 ],
    CreationDate 		=> [ 2004,                		4 ],
    CreationTime 		=> [ 2005,                		4 ],
    ChannelAutoDefExit 		=> [ 2026,                        	4 ],
    ClusterWorkLoadData 	=> [ 2034,                        	4 ],
    ClusterWorkLoadExit 	=> [ 2033,                        	4 ],
    CommandInputQName 		=> [ 2003,                       	4 ],
    DeadLetterQName 		=> [ 2006,                     		4 ],
    DefXmitQName 		=> [ 2025,                  		4 ],
    QMgrDesc 			=> [ 2014,             			4 ],
    QMgrIdentifier 		=> [ 2032,                   		4 ],
    QMgrName 			=> [ 2015,             			4 ],
    RepositoryName 		=> [ 2035,                  		4 ],
    RepositoryNamelist 		=> [ 2036,                      		4 ],
    AuthorityEvent 		=> [ 47,                    		3 ],
    ChannelAutoDef 		=> [ 55,                     		3 ],
    ChannelAutoDefEvent 	=> [ 56,                           	3 ],
    ClusterWorkLoadLength 	=> [ 58,                            	3 ],
    CodedCharSetId 		=> [ 2,                       		3 ],
    CommandLevel 		=> [ 31,                  		3 ],
    DistLists 			=> [ 34,               			3 ],
    InhibitEvent 		=> [ 48,                  		3 ],
    LocalEvent 			=> [ 49,                			3 ],
    MaxHandles 			=> [ 11,                			3 ],
    MaxMsgLength 		=> [ 13,                   		3 ],
    MaxPriority 		=> [ 14,                 		3 ],
    MaxUncommittedMsgs 		=> [ 33,                         	3 ],
    PerformanceEvent 		=> [ 53,                      		3 ],
    RemoteEvent 		=> [ 50,                 		3 ],
    StartStopEvent 		=> [ 52,                     		3 ],
    SyncPoint 			=> [ 30,              			3 ],
    TriggerInterval 		=> [ 25,                     		3 ],
   },

   Queue =>
   {
    ClusterQType		=> [ 59,                   		3,         $ResponseValues{ClusterQType} ],
    DefinitionType		=> [ 7,                     		3,         $ResponseValues{DefinitionType} ],
    DefBind			=> [ 61,             			3,         $ResponseValues{DefBind} ],
    DefInputOpenOption		=> [ 4,                           	3,      	$ResponseValues{DefInputOpenOption} ],
    MsgDeliverySequence		=> [ 16,                          	3,     	$ResponseValues{MsgDeliverySequence} ],
    QServiceIntervalEvent	=> [ 46,                             	3,   	$ResponseValues{QServiceIntervalEvent} ],
    QType			=> [ 20,           			3,         $ResponseValues{QType} ],
    Scope			=> [ 45,          			3,         $ResponseValues{Scope} ],
    TriggerType			=> [ 28,                 		3,         $ResponseValues{TriggerType} ],
    Usage			=> [ 12,          			3,         $ResponseValues{Usage} ],

    QNames			=> [ 3011,            			4 ],
    AlterationDate		=> [ 2027,                  		4 ],
    AlterationTime		=> [ 2028,                  		4 ],
    CreationDate		=> [ 2004,                		4 ],
    CreationTime		=> [ 2005,                		4 ],
    BackoutRequeueName		=> [ 2019,                     		4 ],
    BaseQName			=> [ 2002,              			4 ],
    ClusterDate			=> [ 2037,               		4 ],
    ClusterName			=> [ 2029,               		4 ],
    ClusterNamelist		=> [ 2030,                   		4 ],
    QMgrName			=> [ 2031,                     		4 ],
    ClusterTime			=> [ 2038,               		4 ],
    CreationDate		=> [ 2004,                		4 ],
    CreationTime		=> [ 2005,                		4 ],
    InitiationQName		=> [ 2008,                    		4 ],
    ProcessName			=> [ 2012,               		4 ],
    QDesc			=> [ 2013,         			4 ],
    QMgrIdentifier		=> [ 2032,                   		4 ],
    QName			=> [ 2016,         			4 ],
    RemoteQMgrName		=> [ 2017,                    		4 ],
    RemoteQName			=> [ 2018,                		4 ],
    TriggerData			=> [ 2023,               		4 ],
    XmitQName			=> [ 2024,              			4 ],
    BackoutThreshold		=> [ 22,                      		3 ],
    CurrentQDepth		=> [ 3,                     		3 ],
    DefPersistence		=> [ 5,                     		3 ],
    DefPriority			=> [ 6,                  		3 ],
    DistLists			=> [ 34,               			3 ],
    HardenGetBackout		=> [ 8,                        		3 ],
    HighQDepth			=> [ 36,                 		3 ],
    InhibitGet			=> [ 9,                 			3 ],
    InhibitPut			=> [ 10,                			3 ],
    MaxMsgLength		=> [ 13,                   		3 ],
    MaxQDepth			=> [ 15,                			3 ],
    MsgDeqCount			=> [ 38,                  		3 ],
    MsgEnqCount			=> [ 37,                  		3 ],
    OpenInputCount		=> [ 17,                     		3 ],
    OpenOutputCount		=> [ 18,                      		3 ],
    QDepthHighEvent		=> [ 43,                       		3 ],
    QDepthHighLimit		=> [ 40,                       		3 ],
    QDepthLowEvent		=> [ 44,                      		3 ],
    QDepthLowLimit		=> [ 41,                      		3 ],
    QDepthMaxEvent		=> [ 42,                      		3 ],
    QServiceInterval		=> [ 54,                       		3 ],
    RetentionInterval		=> [ 21,                       		3 ],
    Shareability		=> [ 23,                 		3 ],
    TimeSinceReset		=> [ 35,                     		3 ],
    TriggerControl		=> [ 24,                    		3 ],
    TriggerDepth		=> [ 29,                  		3 ],
    TriggerMsgPriority		=> [ 26,                         	3 ],
   },

   Process =>
   {
    ApplType			=> [ 1,               			3,         $ResponseValues{ApplType} ],

    ProcessNames		=> [ 3012,                  		4 ],
    AlterationDate		=> [ 2027,                  		4 ],
    AlterationTime		=> [ 2028,                  		4 ],
    CreationDate		=> [ 2004,                		4 ],
    CreationTime		=> [ 2005,                		4 ],
    ApplId			=> [ 2001,          			4 ],
    EnvData			=> [ 2007,           			4 ],
    ProcessDesc			=> [ 2011,               		4 ],
    ProcessName			=> [ 2012,               		4 ],
    UserData			=> [ 2021,            			4 ],
   },

   Channel =>
   {
    ChannelInstanceType		=> [ 1523,                          	3,  	$ResponseValues{ChannelInstanceType} ],
    ChannelStatus		=> [ 1527,                   		3,         $ResponseValues{ChannelStatus} ],
    ChannelType			=> [ 1511,                 		3,         $ResponseValues{ChannelType} ],
    MCAStatus			=> [ 1542,               		3,         $ResponseValues{MCAStatus} ],
    MCAType			=> [ 1517,             			3,         $ResponseValues{MCAType} ],
    NonPersistentMsgSpeed	=> [ 1562,              			3,   	$ResponseValues{NonPersistentMsgSpeed} ],
    PutAuthority		=> [ 1508,                  		3,        	$ResponseValues{PutAuthority} ],
    TransportType		=> [ 1501,                       	3,        	$ResponseValues{TransportType} ],

    ChannelName			=> [ 3501,                 		4 ],
    ChannelNames		=> [ 3512,                  		4 ],
    ChannelStartDate		=> [ 3529,                       	4 ],
    ChannelStartTime		=> [ 3528,                       	4 ],
    ConnectionName		=> [ 3506,                    		4 ],
    CurrentLUWID		=> [ 3532,                  		4 ],
    ChannelDesc			=> [ 3502,         			4 ],
    LastLUWID			=> [ 3531,               		4 ],
    LastMsgDate			=> [ 3525,                  		4 ],
    LastMsgTime			=> [ 3524,                  		4 ],
    MCAJobName			=> [ 3530,                 		4 ],
    MCAName			=> [ 3507,             			4 ],
    MCAUserIdentifier		=> [ 3527,                		4 ],
    ModeName			=> [ 3503,              			4 ],
    MsgRetryExit		=> [ 3534,                 		4 ],
    MsgRetryUserData		=> [ 3535,                      		4 ],
    MsgExit			=> [ 3509,                  		4 ],
    MsgUserData			=> [ 3514,                       	4 ],
    Password			=> [ 3518,             			4 ],
    ReceiveExit			=> [ 3511,                  		4 ],
    ReceiveUserData		=> [ 3516,                       	4 ],
    SecurityExit		=> [ 3508,                  		4 ],
    SecurityUserData		=> [ 3513,                       	4 ],
    SendExit			=> [ 3510,                   		4 ],
    SendUserData		=> [ 3515,                        	4 ],
    TpName			=> [ 3504,            			4 ],
    UserIdentifier		=> [ 3517,            			4 ],
    XmitQName			=> [ 3505,                		4 ],
    AlterationDate		=> [ 2027,                  		4 ],
    AlterationTime		=> [ 2028,                  		4 ],
    CreationDate		=> [ 2004,                		4 ],
    CreationTime		=> [ 2005,                		4 ],
    ClusterName			=> [ 2029,               		4 ],
    ClusterNamelist		=> [ 2030,                   		4 ],
    QMgrName			=> [ 2015,             			4 ],
    Batches			=> [ 1537,            			3 ],
    BatchInterval		=> [ 1564,                   		3 ],
    BatchSize			=> [ 1502,               		3 ],
    BuffersReceived		=> [ 1539,                 		3 ],
    BuffersSent			=> [ 1538,                 		3 ],
    BytesReceived		=> [ 1536,               		3 ],
    BytesSent			=> [ 1535,               		3 ],
    CurrentMsgs			=> [ 1531,                 		3 ],
    CurrentSequenceNumber	=> [ 1532,                       	3 ],
    DataConversion		=> [ 1515,                    		3 ],
    DiscInterval		=> [ 1503,                  		3 ],
    HeartbeatInterval		=> [ 1563,                		3 ],
    InDoubtStatus		=> [ 1528,                   		3 ],
    LastSequenceNumber		=> [ 1529,                    		3 ],
    LongRetriesLeft		=> [ 1540,                      		3 ],
    LongRetryCount		=> [ 1507,               		3 ],
    LongRetryInterval		=> [ 1506,               		3 ],
    MaxMsgLength		=> [ 1510,                   		3 ],
    MsgRetryCount		=> [ 1544,             			3 ],
    MsgRetryInterval		=> [ 1545,                		3 ],
    Msgs			=> [ 1534,         			3 ],
    NetworkPriority		=> [ 1565,                     		3 ],
    SeqNumberWrap		=> [ 1509,                         	3 ],
    ShortRetriesLeft		=> [ 1541,                       	3 ],
    ShortRetryCount		=> [ 1505,                		3 ],
    ShortRetryInterval		=> [ 1504,                		3 ],
    StopRequested		=> [ 1543,                   		3 ],
   },

   Escape =>
   {
    EscapeText			=> [ 3014,                		4 ],
    EscapeType			=> [ 1017,                		3 ],
   },

   #
   # New entries for MQSeries 5.1
   #
   Cluster =>
   {
    QMgrDefinitionType		=> [ 1084,                          	3,		$ResponseValues{QMgrDefinitionType} ],
    QMgrType			=> [ 1085,               		3,         $ResponseValues{QMgrType} ],
    ChannelStatus		=> [ 1527,                   		3,         $ResponseValues{ChannelStatus} ],
    MCAType			=> [ 1517,             			3,         $ResponseValues{MCAType} ],
    NonPersistentMsgSpeed	=> [ 1562,              			3,   	$ResponseValues{NonPersistentMsgSpeed} ],
    PutAuthority		=> [ 1508,                  		3,         $ResponseValues{PutAuthority} ],
    TransportType		=> [ 1501,                       	3,        	$ResponseValues{TransportType} ],

    ChannelName			=> [ 3501,                 		4 ],
    ConnectionName		=> [ 3506,                    		4 ],
    ChannelDesc			=> [ 3502,         			4 ],
    MCAName			=> [ 3507,             			4 ],
    MCAUserIdentifier		=> [ 3527,                		4 ],
    ModeName			=> [ 3503,              			4 ],
    MsgRetryExit		=> [ 3534,                 		4 ],
    MsgRetryUserData		=> [ 3535,                      		4 ],
    MsgExit			=> [ 3509,                  		4 ],
    MsgUserData			=> [ 3514,                       	4 ],
    Password			=> [ 3518,             			4 ],
    ReceiveExit			=> [ 3511,                  		4 ],
    ReceiveUserData		=> [ 3516,                       	4 ],
    SecurityExit		=> [ 3508,                  		4 ],
    SecurityUserData		=> [ 3513,                       	4 ],
    SendExit			=> [ 3510,                   		4 ],
    SendUserData		=> [ 3515,                        	4 ],
    TpName			=> [ 3504,            			4 ],
    UserIdentifier		=> [ 3517,            			4 ],
    XmitQName			=> [ 3505,                		4 ],
    AlterationDate		=> [ 2027,                  		4 ],
    AlterationTime		=> [ 2028,                  		4 ],
    CreationDate		=> [ 2004,                		4 ],
    CreationTime		=> [ 2005,                		4 ],
    ClusterDate			=> [ 2037,               		4 ],
    ClusterName			=> [ 2029,               		4 ],
    ClusterTime			=> [ 2038,               		4 ],
    QMgrIdentifier		=> [ 2032,                   		4 ],
    QMgrName			=> [ 2015,             			4 ],
    ClusterInfo			=> [ 1083,                 		3 ],
    Suspend			=> [ 1087,            			3 ],
    BatchInterval		=> [ 1564,                   		3 ],
    BatchSize			=> [ 1502,               		3 ],
    DataConversion		=> [ 1515,                    		3 ],
    DiscInterval		=> [ 1503,                  		3 ],
    HeartbeatInterval		=> [ 1563,                		3 ],
    LongRetryCount		=> [ 1507,               		3 ],
    LongRetryInterval		=> [ 1506,               		3 ],
    MaxMsgLength		=> [ 1510,                   		3 ],
    MsgRetryCount		=> [ 1544,             			3 ],
    MsgRetryInterval		=> [ 1545,                		3 ],
    NetworkPriority		=> [ 1565,                     		3 ],
    SeqNumberWrap		=> [ 1509,                         	3 ],
    ShortRetryCount		=> [ 1505,                		3 ],
    ShortRetryInterval		=> [ 1504,                		3 ],
   },

   Namelist =>
   {
    NameCount			=> [ 19,               			3 ],
    AlterationDate		=> [ 2027,                  		4 ],
    AlterationTime		=> [ 2028,                  		4 ],
    CreationDate		=> [ 2004,                		4 ],
    CreationTime		=> [ 2005,                		4 ],
    NamelistDesc		=> [ 2009,                		4 ],
    NamelistName		=> [ 2010,                		4 ],
    Names			=> [ 2020,        			4 ],
   },

   Authority =>
   {
    ObjectType			=> [ 1000,               		3,		$ResponseValues{ObjectType} ],
    ObjectName			=> [ 3000,               		4 ],

    EntityType			=> [ 1001,               		3,		$ResponseValues{EntityType} ],
    EntityName			=> [ 3001,               		4 ],

    Connect			=> [ 1011,                		3 ],
    Browse			=> [ 1012,               		3 ],
    Input			=> [ 1013,              			3 ],
    Output			=> [ 1014,               		3 ],
    Inquire			=> [ 1015,                		3 ],
    Set				=> [ 1016,            			3 ],
    PassId			=> [ 1017,               		3 ],
    PassAll			=> [ 1018,                		3 ],
    SetId			=> [ 1019,              			3 ],
    SetAll			=> [ 1020,               		3 ],
    AlternateUser		=> [ 1021,                      		3 ],
    Create			=> [ 1022,               		3 ],
    Delete			=> [ 1023,               		3 ],
    Display			=> [ 1024,                		3 ],
    Change			=> [ 1025,               		3 ],

    Create			=> [ 1022,               		3 ],

    Clear			=> [ 1026,              			3 ],
    Authorize			=> [ 1027,                  		3 ],
    StartStop			=> [ 1028,                   		3 ],
    DisplayStatus		=> [ 1029,                       	3 ],
    ResolveReset		=> [ 1030,                      		3 ],
    Ping			=> [ 1031,             			3 ],

    AllAdmin			=> [ 1050,                 		3 ],
    AllMQI			=> [ 1051,               		3 ],
    All				=> [ 1052,            			3 ],
   },

  );

1;
