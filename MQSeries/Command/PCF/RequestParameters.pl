#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries/Command/PCF/RequestParameters.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros
#
# (c) 1999-2004 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

%RequestParameters =
  (
   QueueManager =>
   {
    QMgrAttrs                   => [ 1001,                   		5,		$RequestValues{QueueManager} ],
    AccountingConnOverride	=> [ 136,                            	3 ],
    AccountingInterval		=> [ 135,                       		3 ],
    Action			=> [ 1086,           			3,			$RequestValues{QMgrAction} ],
    ActivityRecording		=> [ 138,                      		3,			$RequestValues{Recording} ],
    AdoptNewMCACheck		=> [ 102,                     		3,			$RequestValues{AdoptNewMCACheck} ],
    AdoptNewMCAType		=> [ 103,                    		3,			$RequestValues{AdoptNewMCAType} ],
    AuthorityEvent              => [ 47,                                 3 ],
    BridgeEvent			=> [ 74,                 		3 ],
    ChannelAutoDef              => [ 55,                                 3 ],
    ChannelAutoDefEvent         => [ 56,                                 3 ],
    ChannelAutoDefExit          => [ 2026,                               4 ],
    ChannelEvent		=> [ 73,                  		3,			$RequestValues{ChannelEvent} ],
    ChannelInitiatorControl	=> [ 119,                  		3,			$RequestValues{QMgrServiceControl} ],
    ChannelMonitoring		=> [ 122,                      		3,			$RequestValues{QMgrMonitoring} ],
    ChannelStatistics		=> [ 129,                      		3,			$RequestValues{QMgrMonitoring} ],
    ChinitAdapters		=> [ 101,                   		3 ],
    ChinitDispatchers		=> [ 105,                      		3 ],
    ChinitServiceParm		=> [ 2076,                      		4 ],
    ChinitTraceAutoStart	=> [ 117,                           	3 ], # Boolean
    ChinitTraceTableSize	=> [ 118,                           	3 ],
    ClusterSenderMonitoringDefault => [ 124,                           	3,			$RequestValues{QMgrMonitoring} ],
    ClusterSenderStatistics	=> [ 130,                           	3,			$RequestValues{QMgrMonitoring} ],
    ClusterWorkLoadData         => [ 2034,                               4 ],
    ClusterWorkLoadExit         => [ 2033,                               4 ],
    ClusterWorkLoadLength       => [ 58,                                 3 ],
    CLWLMRUChannels		=> [ 97,                      		3 ],
    CLWLUseQ			=> [ 98,              			3,			$RequestValues{QMgrCLWLUseQ} ],
    CodedCharSetId		=> [ 2,                       		3 ],
    CommandEvent		=> [ 99,                  		3,			$RequestValues{CommandEvent} ],
    CommandScope		=> [ 3080,                  		4 ],
    CommandServerControl	=> [ 120,                      		3,			$RequestValues{QMgrServiceControl} ],
    ConfigurationEvent          => [ 51,                                 3 ],
    DeadLetterQName             => [ 2006,                               4 ],
    DefXmitQName                => [ 2025,                               4 ],
    DNSGroup			=> [ 2071,            			4 ],
    DNSWLM			=> [ 106,           			3 ], # Boolean
    ExpiryInterval		=> [ 39,                    		3 ], # FIXME: need to support 'Off'
    Facility			=> [ 1231,                   		3,			$RequestValues{QMgrFacility} ],
    Force                       => [ 1005,                               3 ],
    IGQPutAuthority		=> [ 65,                      		3,			$RequestValues{IGQPutAuthority} ],
    IGQUserId			=> [ 2041,              			4 ],
    InhibitEvent                => [ 48,                                 3 ],
    IntraGroupQueueing		=> [ 64,                        		3 ], # Boolean
    IPAddressVersion		=> [ 93,                       		3,			$RequestValues{IPAddressVersion} ],
    ListenerTimer		=> [ 107,                  		3 ],
    LocalEvent                  => [ 49,                                 3 ],
    LoggerEvent			=> [ 94,                 		3 ],
    LUGroupName			=> [ 2072,                		4 ],
    LUName			=> [ 2073,          			4 ],
    LU62ARMSuffix		=> [ 2074,                  		4 ],
    LU62Channels		=> [ 108,                 		3 ],
    MaxActiveChannels		=> [ 100,                   		3 ],
    MaxChannels			=> [ 109,                		3 ],
    MaxHandles                  => [ 11,                                 3 ],
    MaxMsgLength                => [ 13,                                 3 ],
    MaxUncommittedMsgs          => [ 33,                                 3 ],
    MQIAccounting		=> [ 133,                  		3 ],
    MQIStatistics		=> [ 127,                  		3 ],
    OutboundPortMax		=> [ 140,                     		3 ],
    OutboundPortMin		=> [ 110,                     		3 ],
    PerformanceEvent            => [ 53,                                 3 ],
    QMgrDesc                    => [ 2014,                               4 ],
    QueueAccounting		=> [ 134,                		3,			$RequestValues{QMgrAccounting} ],
    QueueMonitoring		=> [ 123,                		3,			$RequestValues{QMgrMonitoring} ],
    QueueStatistics		=> [ 128,                		3,			$RequestValues{QMgrQueueStatistics} ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    ReceiveTimeout		=> [ 111,                   		3 ],
    ReceiveTimeoutMin		=> [ 113,                       		3 ],
    ReceiveTimeoutType		=> [ 112,                        	3,			$RequestValues{ReceiveTimeoutType} ],
    RemoteEvent                 => [ 50,                                 3 ],
    RepositoryName              => [ 2035,                               4 ],
    RepositoryNamelist          => [ 2036,                               4 ],
    SharedQQMgrName		=> [ 77,                        		3,			$RequestValues{SharedQQMgrName} ],
    SSLCRLNamelist              => [ 2050,                               4 ],
    SSLCryptoHardware           => [ 2051,                               4 ],
    SSLEvent			=> [ 75,              			3 ], # Boolean
    SSLFipsRequired		=> [ 92,                      		3 ], # Boolean
    SSLKeyRepository            => [ 2049,                               4 ],
    SSLKeyResetCount		=> [ 76,                    		3 ],
    SSLTasks			=> [ 69,              			3 ],
    StartStopEvent              => [ 52,                     		3 ],
    StatisticsInterval		=> [ 131,                       		3 ],
    TCPChannels			=> [ 114,                		3 ],
    TCPKeepAlive		=> [ 115,                  		3 ], # Boolean
    TCPName			=> [ 2075,           			4 ],
    TCPStackType		=> [ 116,                  		3,			$RequestValues{TCPStackType} ],
    TraceRouteRecording 	=> [ 137,                         	3,			$RequestValues{Recording} ],
    TriggerInterval             => [ 25,                                 3 ],
   },

   QueueManagerStatus =>
   {
    QMStatusAttrs                => [ 1229,                              5,            $RequestValues{QMStatusAttrs} ],
   },

   Process =>
   {
    ProcessAttrs                => [ 1003,                               5,            $RequestValues{Process} ],

    ApplId                      => [ 2001,                               4 ],
    ApplType                    => [ 1,               			3,                 $RequestValues{ApplType} ],
    CommandScope		=> [ 3080,                  		4 ],
    EnvData                     => [ 2007,                               4 ],
    FromProcessName             => [ 3003,                               4 ],
    ProcessDesc                 => [ 2011,                               4 ],
    ProcessName                 => [ 2012,                               4 ],
    Replace                     => [ 1006,                               3 ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    ToProcessName               => [ 3004,                               4 ],
    UserData                    => [ 2021,                               4 ],
   },

   Queue =>
   {
    QAttrs                      => [ 1002,                               5,            $RequestValues{Queue} ],

    BackoutRequeueName          => [ 2019,                               4 ],
    BackoutThreshold            => [ 22,                                 3 ],
    BaseQName                   => [ 2002,                               4 ],
    CFStructure			=> [ 2039,                		4 ],
    ClusterInfo                 => [ 1083,                               3 ],
    ClusterName                 => [ 2029,                               4 ],
    ClusterNamelist             => [ 2030,                               4 ],
    CLWLQueuePriority		=> [ 96,                    		3 ],
    CLWLQueueRank		=> [ 95,                			3 ],
    CLWLUseQ			=> [ 98,              			3,			$RequestValues{QueueCLWLUseQ} ],
    CommandScope		=> [ 3080,                  		4 ],
    DefBind                     => [ 61,             			3,                 $RequestValues{DefBind} ],
    DefinitionType              => [ 7,                                  3,                 $RequestValues{DefinitionType} ],
    DefInputOpenOption          => [ 4,                                  3,                 $RequestValues{DefInputOpenOption} ],
    DefPersistence              => [ 5,                                  3 ],
    DefPriority                 => [ 6,                                  3 ],
    DistLists                   => [ 34,                                 3 ],
    Force                       => [ 1005,                               3 ],
    FromQName                   => [ 3001,                               4 ],
    HardenGetBackout            => [ 8,                                  3 ],
    IndexType			=> [ 57,               			3,			$RequestValues{IndexType} ],
    InhibitGet                  => [ 9,                                  3 ],
    InhibitPut                  => [ 10,                                 3 ],
    InitiationQName             => [ 2008,                               4 ],
    MaxMsgLength                => [ 13,                                 3 ],
    MaxQDepth                   => [ 15,                                 3 ],
    MoveType			=> [ 1145,              			3,			$RequestValues{QMoveType} ],
    MsgDeliverySequence         => [ 16,                                 3,                 $RequestValues{MsgDeliverySequence} ],
    NonPersistentMsgClass       => [ 78,                                 3,                 $RequestValues{NonPersistentMsgClass} ],
    PageSetId                   => [ 62,                                 3 ],
    ProcessName                 => [ 2012,                               4 ],
    Purge                       => [ 1007,                               3 ],
    QDepthHighEvent             => [ 43,                                 3 ],
    QDepthHighLimit             => [ 40,                                 3 ],
    QDepthLowEvent              => [ 44,                                 3 ],
    QDepthLowLimit              => [ 41,                                 3 ],
    QDepthMaxEvent              => [ 42,                                 3 ],
    QDesc                       => [ 2013,                               4 ],
    QName                       => [ 2016,                               4 ],
    QServiceInterval            => [ 54,                                 3 ],
    QServiceIntervalEvent       => [ 46,                                 3,                 $RequestValues{QServiceIntervalEvent} ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    QType                       => [ 20,                                 3,                 $RequestValues{QType} ],
    QueueAccounting		=> [ 134,                		3,			$RequestValues{QueueAccounting} ],
    QueueMonitoring		=> [ 123,                		3,			$RequestValues{QueueMonitoring} ],
    QueueStatistics		=> [ 128,                		3,			$RequestValues{QueueAccounting} ],
    RemoteQMgrName              => [ 2017,                               4 ],
    RemoteQName                 => [ 2018,                               4 ],
    Replace                     => [ 1006,                               3 ],
    RetentionInterval           => [ 21,                                 3 ],
    Scope                       => [ 45,                                 3,                 $RequestValues{Scope} ],
    Shareability                => [ 23,                                 3 ],
    StorageClass		=> [ 2022,                		4 ],
    ToQName                     => [ 3002,                               4 ],
    TriggerControl              => [ 24,                                 3 ],
    TriggerData                 => [ 2023,                               4 ],
    TriggerDepth                => [ 29,                                 3 ],
    TriggerMsgPriority          => [ 26,                                 3 ],
    TriggerType                 => [ 28,                                 3,                 $RequestValues{TriggerType} ],
    Usage                       => [ 12,                                 3,                 $RequestValues{Usage} ],
    XmitQName                   => [ 2024,                               4 ],
   },

   Channel =>
   {
    ChannelAttrs                => [ 1015,                               5,            $RequestValues{Channel} ],
    BatchHeartBeat              => [ 1567,                               3 ],
    BatchInterval               => [ 1564,                               3 ],
    BatchSize                   => [ 1502,                               3 ],
    ChannelDesc                 => [ 3502,                               4 ],
    ChannelDisposition		=> [ 1580,                 		3,			$RequestValues{ChannelDisposition} ],
    ChannelMonitoring		=> [ 122,                      		3,			$RequestValues{ChannelMonitoring} ],
    ChannelStatus		=> [ 1527,                   		3,			$RequestValues{ChannelStatus} ],
    ChannelName                 => [ 3501,                               4 ],
    ChannelTable                => [ 1526,                               3,                 $RequestValues{ChannelTable} ],
    ChannelType                 => [ 1511,                               3,                 $RequestValues{ChannelType} ],
    ClusterName                 => [ 2029,                               4 ],
    ClusterNamelist             => [ 2030,                               4 ],
    CLWLChannelPriority		=> [ 1578,                          	3 ],
    CLWLChannelRank		=> [ 1577,                      		3 ],
    CLWLChannelWeight		=> [ 1579,                        	3 ],
    CommandScope		=> [ 3080,                  		4 ],
    ConnectionName              => [ 3506,                               4 ],
    DataConversion              => [ 1515,                               3 ],
    DataCount                   => [ 1512,                               3 ],
    DiscInterval                => [ 1503,                               3 ],
    EnvironmentInfo		=> [ 3089,             			4 ],
    FromChannelName             => [ 3007,                               4 ],
    HeartbeatInterval           => [ 1563,                               3 ],
    HeaderCompression		=> [ 1575,                    		5,                 $RequestValues{HeaderCompression} ],
    InDoubt                     => [ 1516,                               3,                 $RequestValues{InDoubt} ],
    InitiationQName             => [ 2008,                               4 ],
    KeepAliveInterval		=> [ 1566,                        	3 ],
    LocalAddress                => [ 3520,                               4 ],
    LongRetryCount              => [ 1507,                               3 ],
    LongRetryInterval           => [ 1506,                               3 ],
    MCAName                     => [ 3507,                               4 ],
    MCAType                     => [ 1517,                               3,                 $RequestValues{MCAType} ],
    MCAUserIdentifier           => [ 3527,                               4 ],
    MaxMsgLength                => [ 1510,                               3 ],
    MessageCompression		=> [ 1576,                    		5,                 $RequestValues{MessageCompression} ],
    Mode			=> [ 1008,         			3,			$RequestValues{ChannelMode} ],
    ModeName                    => [ 3503,                               4 ],
    MsgExit                     => [ 3509,                               4 ],
    MsgRetryCount               => [ 1544,                               3 ],
    MsgRetryExit                => [ 3534,                               4 ],
    MsgRetryInterval            => [ 1545,                               3 ],
    MsgRetryUserData            => [ 3535,                               4 ],
    MsgSeqNumber                => [ 1514,                               3 ],
    MsgUserData                 => [ 3514,                               4 ],
    NetworkPriority             => [ 1565,                               3 ],
    NonPersistentMsgSpeed       => [ 1562,                               3,                 $RequestValues{NonPersistentMsgSpeed} ],
    Password                    => [ 3518,                               4 ],
    PutAuthority                => [ 1508,                               3,                 $RequestValues{PutAuthority} ],
    QMgrName                    => [ 2015,                               4 ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    Quiesce                     => [ 1008,                               3 ],
    ReceiveExit                 => [ 3511,                               4 ],
    ReceiveUserData             => [ 3516,                               4 ],
    Replace                     => [ 1006,                               3 ],
    SecurityExit                => [ 3508,                               4 ],
    SecurityUserData            => [ 3513,                               4 ],
    SendExit                    => [ 3510,                               4 ],
    SendUserData                => [ 3515,                               4 ],
    SeqNumberWrap               => [ 1509,                               3 ],
    SharedChannelRestart	=> [ 1600,                       	3 ],
    ShortRetryCount             => [ 1505,                               3 ],
    ShortRetryInterval          => [ 1504,                               3 ],
    SSLCipherSpec               => [ 3544,                               4 ],
    SSLClientAuth               => [ 1568,                               3,                 $RequestValues{SSLClientAuth} ],
    SSLPeerName                 => [ 3545,                               4 ],
    ToChannelName               => [ 3008,                               4 ],
    TpName                      => [ 3504,                               4 ],
    TransportType               => [ 1501,                               3,                 $RequestValues{TransportType} ],
    UserIdentifier              => [ 3517,                               4 ],
    XmitQName                   => [ 3505,                               4 ],
   },

   ChannelInitiator =>
   {
    CommandScope		=> [ 3080,                  		4 ],
   },

   ChannelStatus =>
   {
    ChannelDisposition		=> [ 1580,                 		3,			$RequestValues{ChannelDisposition} ],
    ChannelInstanceAttrs        => [ 1524,                               5,            $RequestValues{Channel} ],
    ChannelInstanceType		=> [ 1523,                          	3,			$RequestValues{ChannelInstanceType} ],
    ChannelName                 => [ 3501,                               4 ],
    CommandScope		=> [ 3080,                  		4 ],
    ConnectionName              => [ 3506,                               4 ],
    XmitQName                   => [ 3505,                               4 ],
   },

   Escape =>
   {
    EscapeType                  => [ 1017,                               3,			$RequestValues{EscapeType} ],
    EscapeText                  => [ 3014,                               4 ],
   },

   Namelist =>
   {
    NamelistAttrs               => [ 1004,                               5,		$RequestValues{NamelistAttrs} ],

    CommandScope		=> [ 3080,                  		4 ],
    FromNamelistName            => [ 3005,                               4 ],
    NamelistDesc                => [ 2009,                               4 ],
    NamelistName                => [ 2010,                               4 ],
    NamelistType		=> [ 72,                  		3,			$RequestValues{NamelistType}],
    Names                       => [ 2020,                               6 ],
    Replace                     => [ 1006,                               3 ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    ToNamelistName              => [ 3006,                               4 ],
   },

   Cluster =>
   {
    Action                      => [ 1086,                               3,                 $RequestValues{ClusterAction} ],
    ClusterQMgrAttrs            => [ 1093,                               5,            $RequestValues{Cluster} ],
    Channel                     => [ 3501,                               4 ],
    ClusterName                 => [ 2029,                               4 ],
    ClusterNamelist             => [ 2030,                               4 ],
    ClusterQMgrName             => [ 2031,                               4 ],
    CommandScope		=> [ 3080,                  		4 ],
    QMgrIdentifier		=> [ 2032,                   		4 ],
    QMgrName                    => [ 2015,                               4 ],
    Quiesce                     => [ 1008,                               3 ],
    RemoveQueues		=> [ 1096,                  		3 ],
    RefreshRepository		=> [ 1095,                       	3,		$RequestValues{RefreshRepository} ],
   },

   #
   # New with WebSphere MQ 5.3
   #
   AuthInfo =>
   {
    AuthInfoAttrs               => [ 1019,                               5,            $RequestValues{AuthInfoAttrs} ],

    AuthInfoConnName            => [ 2053,                               4 ],
    AuthInfoDesc                => [ 2046,                               4 ],
    AuthInfoName                => [ 2045,                               4 ],
    AuthInfoType                => [ 66,                                 3,                 $RequestValues{AuthInfoType} ],
    CommandScope		=> [ 3080,                  		4 ],
    FromAuthInfoName            => [ 3009,                               4 ],
    LDAPPassword                => [ 2048,                               4 ],
    LDAPUserName                => [ 2047,                               4 ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    ToAuthInfoName              => [ 3010,                               4 ],
   },

   QueueStatus =>
   {
    CommandScope		=> [ 3080,                  		4 ],
    OpenType                    => [ 1023,                               3,                 $RequestValues{OpenType} ],
    QName                       => [ 2016,                               4 ],
    QStatusAttrs                => [ 1026,                               5,            $RequestValues{QStatusAttrs} ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    StatusType                  => [ 1103,                               3,                 $RequestValues{StatusType} ],
   },

   #
   # New with WebSphere MQ 6.0
   #
   CFStruc =>
   {
    CFStrucAttrs		=> [ 1133,                   		5,		$RequestValues{CFStrucAttrs} ],
    CFLevel                     => [ 70,                                 3 ],
    CFStatusType		=> [ 1135,                   		3, 		$RequestValues{CFStatusType} ],
    CFStrucDesc			=> [ 2052,                		4 ],
    CFStrucName			=> [ 2039,                		4 ],
    FromCFStrucName		=> [ 3093,                       	4 ],
    Recovery                    => [ 71,                                 3 ],
    Replace                     => [ 1006,                               3 ],
    ToCFStrucName		=> [ 3094,                     		4 ],
   },

   BackupCFStruc =>
   {
    CFStrucName			=> [ 2039,                		4 ],
    CommandScope		=> [ 3080,                  		4 ],
    ExcludeInterval		=> [ 1134,                     		3 ],
   },

   RecoverCFStruc =>
   {
    CFStrucName			=> [ 2039,                		4 ],
    CommandScope		=> [ 3080,                  		4 ],
    Purge			=> [ 1007,          			3 ],
   },

   #
   # NOTE: CFStruct is for backwards compatibility with pre-1.24 MQSC
   #       New code should use CFStruc (no final 't')
   #
   CFStruct =>
   {
    CFStructAttrs               => [ 1133,                               5,            $RequestValues{CFStructAttrs} ],

    CFStatusType		=> [ 1135,                   		3, 		$RequestValues{CFStatusType} ],
    CFStructLevel		=> [ 70,                                 3 ],
    CFStructDesc		=> [ 2052,                		4 ],
    CFStructName		=> [ 2039,                		4 ],
    FromCFStructName		=> [ 3093,                       	4 ],
    Recovery                    => [ 71,                                 3 ],
    Replace                     => [ 1006,                               3 ],
    ToCFStructName		=> [ 3094,                     		4 ],
   },

   #
   # Listener Objects are new for V6
   #
   Listener =>
   {
    ListenerAttrs               => [ 1222,                               5, $RequestValues{ListenerAttrs} ],

    Adapter			=> [ 1519,            			3 ],
    Backlog                     => [ 1602,                               3 ],
    Commands			=> [ 1520,                  		3 ],
    CommandScope		=> [ 3080,                  		4 ],
    FromListenerName            => [ 3124,                               4 ],
    IPAddress                   => [ 3552,                               4 ],
    InboundDisposition		=> [ 1581,                 		3, 	$RequestValues{InboundDisposition} ],
    ListenerDesc                => [ 3555,                               4 ],
    ListenerName                => [ 3554,                               4 ],
    LocalName			=> [ 3521,               		4 ],
    LUName			=> [ 2073,          			4 ],
    NetbiosNames		=> [ 1513,               		3 ],
    Port                        => [ 1522,                               3 ],
    Replace                     => [ 1006,                               3 ],
    Sessions			=> [ 1518,                  		3 ],
    Socket			=> [ 1521,           			3 ],
    StartMode                   => [ 1601,                               3, $RequestValues{ListenerStartMode} ],
    ToListenerName              => [ 3125,                               4 ],
    TPName	             	=> [ 3504,              		        4 ],
    TransportType               => [ 1501,                               3, $RequestValues{ListenerTransportType} ],
   },

   ListenerStatus =>
   {
    ListenerStatusAttrs		=> [ 1223,                          	5, $RequestValues{ListenerStatusAttrs} ],
    ListenerName		=> [ 3554,                  		4 ],
   },

   #
   # Service Objects are new for V6
   #
   Service =>
   {
    ServiceAttrs		=> [ 1224,                  		5,            $RequestValues{ServiceAttrs} ],

    FromServiceName 		=> [ 3126,                      		4 ],
    Replace 			=> [ 1006,            			3 ],
    ServiceDesc 		=> [ 2078,               		4 ],
    ServiceName 		=> [ 2077,               		4 ],
    ServiceType 		=> [ 121,                 		3,		$RequestValues{ServiceType} ],
    StartArguments 		=> [ 2080,                     		4 ],
    StartCommand		=> [ 2079,                        	4 ],
    StartMode 			=> [ 139,                   		3,		$RequestValues{ServiceStartMode} ],
    StopArguments 		=> [ 2082,                    		4 ],
    StopCommand			=> [ 2081,                       	4 ],
    StderrDestination		=> [ 2084,                     		4 ],
    StdoutDestination		=> [ 2083,                     		4 ],
    ToServiceName 		=> [ 3127,                    		4 ],
   },

   ServiceStatus =>
   {
    ServiceStatusAttrs		=> [ 1225,                         	5, $RequestValues{ServiceStatusAttrs} ],
    ServiceName			=> [ 2077,               		4 ],
   },

   StorageClass =>
   {
    StorageClassAttrs           => [ 1156,                               5,            $RequestValues{StorageClassAttrs} ],

    CommandScope		=> [ 3080,                  		4 ],
    FromStorageClassName	=> [ 3104,                       	4 ],
    PageSetId                   => [ 62,                                 3 ],
    PassTicketApplication	=> [ 2086,                   		4 ],
    QSGDisposition		=> [ 63,             			3,			$RequestValues{QSGDisposition} ],
    Replace                     => [ 1006,                               3 ],
    StorageClassDesc		=> [ 2042,                     		4 ],
    StorageClassName		=> [ 2022,                		4 ],
    ToStorageClassName		=> [ 3105,                     		4 ],
    XCFGroupName		=> [ 2043,                 		4 ],
    XCFMemberName		=> [ 2044,                  		4 ],
   },

   InquireUsage =>
   {
    CommandScope		=> [ 3080,                  		4 ],
    PageSetId                   => [ 62,                                 3 ],
    UsageType			=> [ 1157,               		3,			$RequestValues{UsageType} ],
   },

   #
   # InquireConnection is new for V6
   # FIXME: Add Support for Filtering
   #

   Connection =>
   {
    ConnectionAttrs            => [ 1107,                                  5,          $RequestValues{ConnectionAttrs} ],
    ConnectionId               => [ 7006,                                  9                   ],
    ConnInfoType               => [ 1110,                                  3, $RequestValues{ConnInfoType} ],
    CommandScope               => [ 3080,                                  4 ],
    GenericConnectionId        => [ 7007,                                  9                   ],
    Filter                     => [ $RequestValues{FilterParams},         $RequestValues{FilterType}],
    ByteFilter                 => [ $RequestValues{ByteFilterParams},     15                         ],
   },

   #
   # Security is for MQ on z/OS
   #
   Security => {
    SecurityAttrs		=> [ 1151,                   		5,		$RequestValues{SecurityAttrs} ],

    CommandScope		=> [ 3080,                  		4 ],
    SecurityInterval		=> [ 1153,                      		3 ],
    SecurityTimeout		=> [ 1152,                     		3 ],
   },

   #
   # RefreshQueueManager is for MQ on z/OS
   #
   RefreshQueueManager =>
   {
    CommandScope		=> [ 3080,                  		4 ],
    ObjectName			=> [ 3046,                		4 ],
    ObjectType			=> [ 1016,                		3,			$RequestValues{ObjectType} ],
    RefreshType			=> [ 1078,                 		3,			$RequestValues{RefreshType} ],
    RefreshInterval		=> [ 1094,                     		3 ],
   },

   #
   #
   # RefreshSecurity is for MQ on distributed and z/OS
   #
   RefreshSecurity => {
    CommandScope		=> [ 3080,                  		4 ],
    SecurityItem		=> [ 1129,                  		3,			$RequestValues{SecurityItem} ],
    SecurityType		=> [ 1106,                  		3,			$RequestValues{SecurityType} ],
   },

   #
   # ReverifySecurity is for MQ on z/OS
   #
   ReverifySecurity =>
   {
    CommandScope		=> [ 3080,                  		4 ],
    UserId			=> [ 3025,                    		4 ],
   },

   #
   # AuthorityRecords is new for MQ v6 on distributed platforms
   #
   AuthorityRecords =>
   {
    ProfileAttrs		=> [ 1114,                       	5,			$RequestValues{AuthProfileAttrs} ],

    EntityName			=> [ 3068,                		4 ],
    EntityType			=> [ 1118,                		3,			$RequestValues{EntityType} ],
    ObjectType			=> [ 1016,                		3,			$RequestValues{ObjectType} ],
    Options			=> [ 1228,                 		3, 		$RequestValues{AuthOptions} ],
    ProfileName			=> [ 3067,                      		4 ],
    ServiceComponent		=> [ 3069,                      		4 ],
   },

   #
   # AuthorityService is new for MQ v6 on distributed platforms
   #
   AuthorityService =>
   {
    AuthServiceAttrs		=> [  1264,                              5,			$RequestValues{AuthServiceAttrs} ],
    ServiceComponent		=> [ 3069,                      		4 ],
   },

   #
   # DeleteAuthorityRecord is new for MQ v6 on distributed platforms
   #
   DeleteAuthorityRecord =>
   {
    GroupNames			=> [ 3066,                       	6 ],
    ObjectType			=> [ 1016,                		3,			$RequestValues{ObjectType} ],
    PrincipalNames		=> [ 3065,                           	6 ],
    ProfileName			=> [ 3067,                      		4 ],
   },

   #
   # InquireGroup for z/OS
   #
   InquireGroup =>
   {
   },

   #
   #
   # For z/OS
   #
   Log =>
   {
    CommandScope		=> [ 3080,                  		4 ],
    DeallocateInterval		=> [ 1176,                          	3 ],
    MaxArchiveLog		=> [ 1177,                     		3 ],
    MaxReadTapeUnits		=> [ 1178,                        	3 ],
    OutputBufferCount		=> [ 1181,                          	3 ],
    ParameterType		=> [ 1175,              			3,		$RequestValues{ParameterType} ],
   },

   System =>
   {
    CheckpointCount		=> [ 1191,                        	3 ],
    CommandScope		=> [ 3080,                  		4 ],
    MaxConnects			=> [ 1186,                   		3 ],
    MaxConnectsBackground	=> [ 1188,                        	3 ],
    MaxConnectsForeground	=> [ 1187,                        	3 ],
    ParameterType		=> [ 1175,              			3,		$RequestValues{ParameterType} ],
    Service			=> [ 3123,                 		4 ],
    SMFInterval			=> [ 1199,                      		3 ],
    TraceSize			=> [ 1201,                    		3 ],
   },


   #
   # SetAuthorityRecord is new for MQ v6 on distributed platforms
   #
   SetAuthorityRecord =>
   {
    AuthorityAdd		=> [ 1116,                   		5,		$RequestValues{Authority} ],
    AuthorityRemove		=> [ 1117,                      		5,		$RequestValues{Authority} ],
    GroupNames			=> [ 3066,                       	6 ],
    ObjectType			=> [ 1016,                		3,			$RequestValues{ObjectType} ],
    PrincipalNames		=> [ 3065,                           	6 ],
    ProfileName			=> [ 3067,                      		4 ],
    ServiceComponent		=> [ 3069,                      		4 ],
   },

   #
   # Used by Morgan Stanley extensions
   #
   Authority =>
   {
    ObjectType			=> [ 1000,               		3,			$RequestValues{ObjectType} ],
    ObjectName			=> [ 3000,               		4 ],

    EntityType			=> [ 1001,               		3,			$RequestValues{MorganEntityType} ],
    EntityName			=> [ 3001,               		4 ],

    Connect                     => [ 1011,                		3 ],
    Browse                      => [ 1012,               		3 ],
    Input                       => [ 1013,              			3 ],
    Output                      => [ 1014,               		3 ],
    Inquire                     => [ 1015,                		3 ],
    Set                         => [ 1016,            			3 ],
    PassId                      => [ 1017,               		3 ],
    PassAll                     => [ 1018,                		3 ],
    SetId                       => [ 1019,              			3 ],
    SetAll                      => [ 1020,               		3 ],
    AlternateUser               => [ 1021,                      		3 ],
    Create                      => [ 1022,               		3 ],
    Delete                      => [ 1023,               		3 ],
    Display                     => [ 1024,                		3 ],
    Change                      => [ 1025,               		3 ],
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
