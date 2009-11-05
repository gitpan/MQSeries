#
# $Id: ResponseParameters.pl,v 33.1 2009/07/10 17:04:43 biersma Exp $
#
# (c) 1999-2009 Morgan Stanley & Co. Incorporated
# See ..../src/LICENSE for terms of distribution.
#

package MQSeries::Command::MQSC;

%ResponseParameters =
  (
   QueueManager =>
   {
    ACCMQI	=> [ "MQIAccounting" ],
    ACCTQ	=> [ "QueueAccounting",		$ResponseValues{QMgrAccounting} ],
    ACTCHL	=> [ "MaxActiveChannels" ],
    ACTIVREC	=> [ "ActivityRecording",	$ResponseValues{ActivityRecording} ],
    ADOPTCHK	=> [ "AdoptNewMCACheck",	$ResponseValues{AdoptNewMCACheck} ],
    ADOPTMCA	=> [ "AdoptNewMCAType",		$ResponseValues{AdoptNewMCAType} ],
    ALTTIME	=> [ "AlterationTime" ],
    ALTDATE	=> [ "AlterationDate" ],
    AUTHOREV	=> [ "AuthorityEvent", 		$ResponseValues{Enabled} ],
    BRIDGEEV	=> [ "BridgeEvent",		$ResponseValues{Enabled} ],
    CCSID	=> [ "CodedCharSetId" ],
    CHAD	=> [ "ChannelAutoDef",		$ResponseValues{Enabled} ],
    CHADEV	=> [ "ChannelAutoDefEvent",	$ResponseValues{Enabled} ],
    CHADEXIT	=> [ "ChannelAutoDefExit" ],
    CHIADAPS	=> [ "ChinitAdapters" ],
    CHIDISPS	=> [ "ChinitDispatchers" ],
    CHISERVP	=> [ "ChinitServiceParm" ],
    CHLEV	=> [ "ChannelEvent",		$ResponseValues{ChannelEvent} ],
    CLWLEXIT	=> [ "ClusterWorkLoadExit" ],
    CLWLDATA	=> [ "ClusterWorkLoadData" ],
    CLWLLEN 	=> [ "ClusterWorkLoadLength" ],
    CLWLMRUC 	=> [ "CLWLMRUChannels" ],
    CLWLUSEQ 	=> [ "CLWLUseQ",		$ResponseValues{CLWLUseQ} ],
    CMDEV	=> [ "CommandEvent",		$ResponseValues{CommandEvent} ],
    CMDLEVEL	=> [ "CommandLevel" ],
    COMMANDQ	=> [ "CommandInputQName" ],
    CONFIGEV    => [ "ConfigurationEvent",      $ResponseValues{Enabled} ],
    CPILEVEL	=> [ "CPILevel" ],
    DEADQ	=> [ "DeadLetterQName" ],
    DEFXMITQ	=> [ "DefXmitQName" ],
    DESCR	=> [ "QMgrDesc" ],
    DISTL	=> [ "DistLists",		$ResponseValues{Yes} ],
    DNSGROUP	=> [ "DNSGroup" ],
    DNSWLM	=> [ "DNSWLM",			$ResponseValues{Yes} ],
    EXPRYINT    => [ "ExpiryInterval" ],
    IGQ         => [ "IntraGroupQueueing",      $ResponseValues{Enabled} ],
    IGQAUT      => [ "IGQPutAuthority",         $ResponseValues{IGQPutAuthority} ],
    IGQUSER     => [ "IGQUserid" ],
    INHIBTEV	=> [ "InhibitEvent",		$ResponseValues{Enabled} ],
    IPADDRV	=> [ "IPAddressVersion",	$ResponseValues{IPAddressVersion} ],
    LOCALEV	=> [ "LocalEvent",		$ResponseValues{Enabled} ],
    LSTRTMR	=> [ "ListenerTimer" ],
    LU62ARM	=> [ "LU62ARMSuffix" ],
    LU62CHL	=> [ "LU62Channels" ],
    LUGROUP	=> [ "LUGroupName" ],
    LUNAME	=> [ "LUName" ],
    MAXCHL	=> [ "MaxChannels" ],
    MAXHANDS	=> [ "MaxHandles" ],
    MAXMSGL	=> [ "MaxMsgLength" ],
    MAXPRTY	=> [ "MaxPriority" ],
    MAXUMSGS	=> [ "MaxUncommittedMsgs" ],
    MONACLS     => [ "ClusterSenderMonitoringDefault", $ResponseValues{ClusterSenderMonitoringDefault} ],
    MONCHL	=> [ "ChannelMonitoring",	$ResponseValues{ChannelMonitoring} ],
    MONQ	=> [ "QueueMonitoring",		$ResponseValues{QMgrMonitoring} ],
    OPORTMAX	=> [ "OutboundPortMax" ],
    OPORTMIN	=> [ "OutboundPortMin" ],
    PERFMEV	=> [ "PerformanceEvent",	$ResponseValues{Enabled} ],
    PLATFORM	=> [ "Platform", ],
    QMID	=> [ "QMgrIdentifier" ],
    QMNAME	=> [ "QMgrName" ],
    QSGNAME     => [ "QSharingGroupName" ],
    RCVTMIN	=> [ "ReceiveTimeoutMin" ],
    RCVTIME	=> [ "ReceiveTimeout" ],
    RCVTTYPE	=> [ "ReceiveTimeoutType",	$ResponseValues{ReceiveTimeoutType} ],
    REMOTEEV	=> [ "RemoteEvent",		$ResponseValues{Enabled} ],
    REPOS	=> [ "RepositoryName" ],
    REPOSNL	=> [ "RepositoryNamelist" ],
    ROUTEREC    => [ "TraceRouteRecording",	$ResponseValues{TraceRouteRecording} ],
    SQQMNAME    => [ "SharedQQmgrName",		$ResponseValues{SharedQQmgrName} ],
    SSLCRLNL    => [ "SSLCRLNamelist" ],
    SSLEV	=> [ "SSLEvent",		$ResponseValues{Enabled} ],
    SSLKEYR     => [ "SSLKeyRepository" ],
    SSLRKEYC	=> [ "SSLKeyResetCount" ],
    SSLTASKS    => [ "SSLTasks" ],
    STRSTPEV	=> [ "StartStopEvent",		$ResponseValues{Enabled} ],
    SYNCPT	=> [ "SyncPoint",		$ResponseValues{Available} ],
    TCPCHL	=> [ "TCPChannels" ],
    TCPKEEP	=> [ "TCPKeepAlive",		$ResponseValues{Yes} ],
    TCPNAME	=> [ "TCPName" ],
    TCPSTACK	=> [ "TCPStackType",		$ResponseValues{TCPStackType} ],
    TRAXTBL	=> [ "ChinitTraceTableSize" ],
    TRAXSTR	=> [ "ChinitTraceAutoStart",	$ResponseValues{Yes} ],
    TRIGINT	=> [ "TriggerInterval" ],
   },

   Process =>
   {
    APPLTYPE	=> [ "ApplType",		$ResponseValues{ApplType} ],

    PROCESS	=> [ "ProcessName" ],
    DESCR	=> [ "ProcessDesc" ],
    APPLICID	=> [ "ApplId" ],
    ENVRDATA	=> [ "EnvData" ],
    USERDATA	=> [ "UserData" ],

    ALTTIME	=> [ "AlterationTime" ],
    ALTDATE	=> [ "AlterationDate" ],
    QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
    #QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
   },

   Queue =>
   {
    ACCTQ	=> [ "QueueAccounting",		$ResponseValues{QueueAccounting} ],
    BOQNAME	=> [ "BackoutRequeueName" ],
    BOTHRESH	=> [ "BackoutThreshold" ],
    CFSTRUCT    => [ "CFStructure" ],
   # CFSTRUCT    => [ "CFStructure" ],
#   CHLDISP     => [ "ChannelDisposition" ],
    CLUSDATE    => [ "ClusterDate" ],
    CLWLPRTY	=> [ "CLWLQueuePriority" ],
    CLWLRANK	=> [ "CLWLQueueRank" ],
    CLWLUSEQ	=> [ "CLWLUseQ",		$ResponseValues{CLWLUseQ} ],
    CMDSCOPE    => [ "CommandScope" ],
    CRDATE	=> [ "CreationDate" ],
    CRTIME	=> [ "CreationTime" ],
    CURDEPTH	=> [ "CurrentQDepth" ],
    DEFPRTY	=> [ "DefPriority" ],
    DEFPSIST	=> [ "DefPersistence",		$ResponseValues{Yes} ],
    DEFSOPT	=> [ "DefInputOpenOption",	$ResponseValues{DefInputOpenOption} ],
    DEFTYPE	=> [ "DefinitionType",		$ResponseValues{DefinitionType} ],
    DESCR	=> [ "QDesc" ],
    DISTL	=> [ "DistLists",		$ResponseValues{Yes} ],
    GET		=> [ "InhibitGet",		$ResponseValues{Disabled} ],
    IGQ         => [ "IntraGroupQueueing" ],
    IGQAUT      => [ "IGQPutAuthority" ],
    IGQUSER     => [ "IntraGroupUser" ],
    INDXTYPE	=> [ "IndexType",		$ResponseValues{IndexType} ],
    INITQ	=> [ "InitiationQName" ],
    IPPROCS	=> [ "OpenInputCount" ],
    MAXDEPTH	=> [ "MaxQDepth" ],
    MAXMSGL	=> [ "MaxMsgLength" ],
    MONQ	=> [ "QueueMonitoring",		$ResponseValues{QueueMonitoring} ],
    MSGDLVSQ	=> [ "MsgDeliverySequence",	$ResponseValues{MsgDeliverySequence} ],
    NPMCLASS    => [ "NonPersistentMsgClass",   $ResponseValues{NonPersistentMsgClass} ],
    OPPROCS	=> [ "OpenOutputCount" ],
    PROCESS	=> [ "ProcessName" ],
    PSID        => [ "PageSetId" ],
    PUT		=> [ "InhibitPut",		$ResponseValues{Disabled} ],
    QDEPTHHI	=> [ "QDepthHighLimit" ],
    QDEPTHLO	=> [ "QDepthLowLimit" ],
    QDPHIEV	=> [ "QDepthHighEvent",		$ResponseValues{Enabled} ],
    QDPLOEV	=> [ "QDepthLowEvent",		$ResponseValues{Enabled} ],
    QDPMAXEV	=> [ "QDepthMaxEvent",		$ResponseValues{Enabled} ],
    QSVCINT	=> [ "QServiceInterval" ],
    QSVCIEV	=> [ "QServiceIntervalEvent",   $ResponseValues{QServiceIntervalEvent} ],
    TYPE	=> [ "QType",  			$ResponseValues{QType} ],
    QUEUE	=> [ "QName" ],
   # QSGDISP     => [ "QSGDisposition" , $ResponseValues{QSGDisposition} ],
    QSGDISP     => [ "QSGDisposition", $ResponseValues{QSGDisposition} ],
    QSGNAME     => [ "QSharingGroupName" ],
    RETINTVL	=> [ "RetentionInterval" ],
    RNAME	=> [ "RemoteQName" ],
    RQMNAME	=> [ "RemoteQMgrName" ],
    SCOPE	=> [ "Scope",			$ResponseValues{Scope} ],
    STGCLASS	=> [ "StorageClass" ],
    TARGQ	=> [ "BaseQName" ],
    TPIPE	=> [ "TPipeNames" ],
    TRIGDATA	=> [ "TriggerData" ],
    TRIGDPTH	=> [ "TriggerDepth" ],
    TRIGMPRI	=> [ "TriggerMsgPriority" ],
    TRIGTYPE	=> [ "TriggerType",		$ResponseValues{TriggerType} ],
    USAGE	=> [ "Usage",			$ResponseValues{Usage} ],
    XMITQ	=> [ "XmitQName" ],

    TRIGGER	=> [ "TriggerControl",		1 ],
    NOTRIGGER	=> [ "TriggerControl",		0 ],
    SHARE	=> [ "Shareability",		1 ],
    NOSHARE	=> [ "Shareability",		0 ],
    HARDENBO	=> [ "HardenGetBackout",	1 ],
    NOHARDENBO	=> [ "HardenGetBackout",	0 ],

    ALTTIME	=> [ "AlterationTime" ],
    ALTDATE	=> [ "AlterationDate" ],
    CLUSNL   	=> [ "ClusterNamelist" ],
    CLUSQMGR 	=> [ "QMgrName" ],
    CLUSQT  	=> [ "ClusterQType",		$ResponseValues{ClusterQType} ],
    CLUSTER   	=> [ "ClusterName" ],
    CLUSTIME  	=> [ "ClusterTime" ],
    DEFBIND	=> [ "DefBind",			$ResponseValues{DefBind} ],
    QMID   	=> [ "QMgrIdentifier" ],

    # 
    # ResetQueueStatistics (For MVS version of MQ release 5.2 and up)
    #
    HIQDEPTH    => [ "HighQDepth" ],
    MSGSIN      => [ "MsgEnqCount" ],
    MSGSOUT     => [ "MsgDeqCount" ],
    RESETINT    => [ "TimeSinceReset" ],
    QSTATS      => [ "QName" ],
   },

   Channel =>
   {
    #
    # Most of these are primarily from DISPLAY CHSTATUS 
    #
    BATCHES	=> [ "Batches" ],
    BUFSRCVD	=> [ "BuffersReceived" ],
    BUFSSENT	=> [ "BuffersSent" ],
    BYTSRCVD	=> [ "BytesReceived" ],
    BYTSSENT	=> [ "BytesSent" ],
    CHSTADA	=> [ "ChannelStartDate" ],
    CHSTATI	=> [ "ChannelStartTime" ],
    CHSTATUS	=> [ "ChannelName" ],
    CLWLRANK    => [ "CLWLChannelRank" ],
    CLWLPRTY    => [ "CLWLChannelPriority" ],
    CLWLWGHT    => [ "CLWLChannelWeight" ],
    COMPHDR	=> [ "HeaderCompression",	$ResponseValues{Compression} ],
    COMPMSG	=> [ "MessageCompression",	$ResponseValues{MessageCompression} ],
    COMPRATE	=> [ "CompressionRate" ],
    COMPTIME	=> [ "CompressionTime" ],
    CURLUWID	=> [ "CurrentLUWID" ],
    CURMSGS	=> [ "CurrentMsgs" ],
    CURSEQNO	=> [ "CurrentSequenceNumber" ],
    EXITTIME	=> [ "ExitTime" ],
    INDOUBT	=> [ "InDoubtStatus",		$ResponseValues{Yes} ],
    JOBNAME	=> [ "MCAJobName" ],
    LONGRTS	=> [ "LongRetriesLeft" ],
    LSTLUWID	=> [ "LastLUWID" ],
    LSTMSGDA	=> [ "LastMsgDate" ],
    LSTMSGTI	=> [ "LastMsgTime" ],
    LSTSEQNO	=> [ "LastSequenceNumber" ],
    MCASTAT	=> [ "MCAStatus",		$ResponseValues{MCAStatus} ],
    MONCHL	=> [ "ChannelMonitoring",	$ResponseValues{MonitoringDft} ],
    MSGS	=> [ "Msgs" ],
    NETTIME	=> [ "NetTime" ],
    SHORTRTS	=> [ "ShortRetriesLeft" ],
    SSLCERTI	=> [ "SSLCertRemoteIssuerName" ],
    SSLCERTU	=> [ "SSLCertUserId" ],
    SSLRKEYS	=> [ "SSLKeyResets" ],
    SSLKEYTI	=> [ "SSLKeyResetTime" ],
    SSLKEYDA	=> [ "SSLKeyResetDate" ],
    STATUS	=> [ "ChannelStatus",		$ResponseValues{ChannelStatus} ],
    STOPREQ	=> [ "StopRequested",		$ResponseValues{Yes} ],
    SUBSTATE	=> [ "SubState",		$ResponseValues{SubSate} ],
    XBATCHSZ	=> [ "XBatchSize" ],
    XQMSGSA	=> [ "XQMsgAvailable" ],
    XQTIME	=> [ "XQTime" ],

    CURRENT	=> [ "ChannelInstanceType",	"Current" ],
    SAVED	=> [ "ChannelInstanceType",	"Saved" ],

    #
    # Most of these are from DISPLAY CHANNEL, but also returned by
    # CHSTATUS, too.  Thus, one hash.
    #
    BATCHHB     => [ "BatchHeartBeat" ],
    BATCHINT	=> [ "BatchInterval" ],
    BATCHSZ	=> [ "BatchSize" ],
    CHANNEL	=> [ "ChannelName" ],
    CHLTYPE	=> [ "ChannelType",		$ResponseValues{ChannelType} ],
    CONNAME	=> [ "ConnectionName" ],
    CONVERT	=> [ "DataConversion",		$ResponseValues{Yes} ],
    DESCR	=> [ "ChannelDesc" ],
    DISCINT	=> [ "DiscInterval" ],
    HBINT	=> [ "HeartbeatInterval" ],
    KAINT       => [ "KeepAliveInterval", ],#	$ResponseValues{KeepAliveInterval} ],
    LOCLADDR    => [ "LocalAddress" ],
    LONGRTY	=> [ "LongRetryCount" ],
    LONGTMR	=> [ "LongRetryInterval" ],
    MAXMSGL	=> [ "MaxMsgLength" ],
    MCANAME	=> [ "MCAName" ],
    MCATYPE	=> [ "MCAType",			$ResponseValues{MCAType} ],
    MCAUSER	=> [ "MCAUserIdentifier" ],
    MODENAME	=> [ "ModeName" ],
    MREXIT	=> [ "MsgRetryExit" ],
    MRDATA	=> [ "MsgRetryUserData" ],
    MRRTY	=> [ "MsgRetryCount" ],
    MRTMR	=> [ "MsgRetryInterval" ],
    MSGDATA	=> [ "MsgUserData" ],
    MSGEXIT	=> [ "MsgExit" ],
    NPMSPEED	=> [ "NonPersistentMsgSpeed",   $ResponseValues{NonPersistentMsgSpeed} ],
    PASSWORD	=> [ "Password" ],
    PUTAUT	=> [ "PutAuthority",		$ResponseValues{PutAuthority} ],
    QMNAME	=> [ "QMgrName" ],
    RCVDATA	=> [ "ReceiveUserData" ],
    RCVEXIT	=> [ "ReceiveExit" ],
    RQMNAME	=> [ "RemoteQMgrName" ],
    RAPPLTAG	=> [ "RemoteApplTag" ],
    SCYEXIT	=> [ "SecurityExit" ],
    SCYDATA	=> [ "SecurityUserData" ],
    SENDDATA	=> [ "SendUserData" ],
    SENDEXIT	=> [ "SendExit" ],
    SEQWRAP	=> [ "SeqNumberWrap" ],
    SHORTRTY	=> [ "ShortRetryCount" ],
    SHORTTMR	=> [ "ShortRetryInterval" ],
    SSLCAUTH	=> [ "SSLClientAuth",           $ResponseValues{SSLClientAuth} ],
    SSLCIPH     => [ "SSLCipherSpec" ],
    SSLPEER     => [ "SSLPeerName" ],
    TPNAME	=> [ "TpName" ],
    TRPTYPE	=> [ "TransportType",		$ResponseValues{TransportType} ],
    USERID	=> [ "UserIdentifier" ],
    XMITQ	=> [ "XmitQName" ],

    ALTTIME	=> [ "AlterationTime" ],
    ALTDATE	=> [ "AlterationDate" ],
    AUTOSTART	=> [ "AutoStart",		$ResponseValues{Enabled} ],
    CLUSTER	=> [ "ClusterName" ],
    CLUSNL   	=> [ "ClusterNamelist" ],
    NETPRTY 	=> [ "NetworkPriority" ],

    CHLDISP     => [ "ChannelDisposition",	$ResponseValues{ChannelDisposition} ],
    QSGDISP     => [ "QSGDisposition", $ResponseValues{QSGDisposition} ],
   # QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
   },

   Namelist =>
   {
    ALTTIME	=> [ "AlterationTime" ],
    ALTDATE	=> [ "AlterationDate" ],
    DESCR	=> [ "NamelistDesc" ],
    NAMELIST	=> [ "NamelistName" ],
    NAMCOUNT  	=> [ "NameCount" ],
    NAMES   	=> [ "Names" ],
    NLTYPE      => [ "NamelistType",		$ResponseValues{NamelistType} ],
    QSGDISP     => [ "QSGDisposition", $ResponseValues{QSGDisposition} ],
   # QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
   },

   StorageClass =>
   {
    STGCLASS	=> [ "StorageClassName" ],
    ALTTIME	=> [ "AlterationTime" ],
    ALTDATE	=> [ "AlterationDate" ],
    DESCR	=> [ "StorageClassDesc" ],
    PASSTKTA	=> [ "PassTicketApplication" ],
    PSID	=> [ "PageSetId" ],
    QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
   # QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
    XCFGNAME	=> [ "XCFGroupName" ],
    XCFMNAME	=> [ "XCFMemberName" ],
   },

   Trace =>
   {
    TRACE	=> [ "TraceType",		$ResponseValues{TraceType} ],
    DEST	=> [ "Destination" ],
    CLASS	=> [ "Class" ],
    RMID	=> [ "ResourceMgrId" ],
    TNO		=> [ "TraceNumber" ],
    USERID	=> [ "UserIdentifier" ],
    COMMENT	=> [ "Comment" ],
    IFCID	=> [ "EventId" ],
   },

   Cluster =>
   {
    ALTDATE	=> [ "AlterationDate" ],
    ALTTIME	=> [ "AlterationTime" ],
    BATCHINT	=> [ "BatchInterval" ],
    BATCHSZ	=> [ "BatchSize" ],
    CHANNEL	=> [ "ChannelName" ],
    CLUSDATE	=> [ "ClusterDate" ],
    CLUSTER 	=> [ "ClusterName" ],
    CLUSTIME	=> [ "ClusterTime" ],
    CONNAME	=> [ "ConnectionName" ],
    CONVERT	=> [ "DataConversion",		$ResponseValues{Yes} ],
    DEFTYPE	=> [ "QMgrDefinitionType",	$ResponseValues{QMgrDefinitionType} ],
    DESCR	=> [ "ChannelDesc" ],
    DISCINT	=> [ "DiscInterval" ],
    HBINT	=> [ "HeartbeatInterval" ],
    LONGRTY	=> [ "LongRetryCount" ],
    LONGTMR	=> [ "LongRetryInterval" ],
    MAXMSGL	=> [ "MaxMsgLength" ],
    MCANAME	=> [ "MCAName" ],
    MCATYPE	=> [ "MCAType",			$ResponseValues{MCAType} ],
    MCAUSER	=> [ "MCAUserIdentifier" ],
    MODENAME	=> [ "ModeName" ],
    MRDATA	=> [ "MsgRetryUserData" ],
    MREXIT	=> [ "MsgRetryExit" ],
    MRRTY	=> [ "MsgRetryCount" ],
    MRTMR	=> [ "MsgRetryInterval" ],
    MSGDATA	=> [ "MsgUserData" ],
    MSGEXIT	=> [ "MsgExit" ],
    NETPRTY 	=> [ "NetworkPriority" ],
    NPMSPEED    => [ "NonPersistentMsgSpeed",	$ResponseValues{NonPersistentMsgSpeed} ],
    PASSWORD	=> [ "Password" ],
    PUTAUT	=> [ "PutAuthority",		$ResponseValues{PutAuthority} ],
    QMID	=> [ "QMgrIdentifier" ],
    QMTYPE	=> [ "QMgrType",		$ResponseValues{QMgrType} ],
    RCVDATA	=> [ "ReceiveUserData" ],
    RCVEXIT	=> [ "ReceiveExit" ],
    SCYDATA	=> [ "SecurityUserData" ],
    SCYEXIT	=> [ "SecurityExit" ],
    SENDDATA	=> [ "SendUserData" ],
    SENDEXIT	=> [ "SendExit" ],
    SEQWRAP	=> [ "SeqNumberWrap" ],
    SHORTRTY	=> [ "ShortRetryCount" ],
    SHORTTMR	=> [ "ShortRetryInterval" ],
    STATUS	=> [ "ChannelStatus",		$ResponseValues{ChannelStatus} ],
    SUSPEND	=> [ "Suspend",			$ResponseValues{Yes} ],
    TPNAME	=> [ "TpName" ],
    TRPTYPE	=> [ "TransportType",		$ResponseValues{TransportType} ],
    USERID	=> [ "UserIdentifier" ],
   },

   QueueStatus => 
   {
    APPLTAG     => [ "ApplTag" ],
    APPLTYPE    => [ "ApplType",                $ResponseValues{ApplType} ],
    ASID        => [ "AddressSpaceId" ],
    BROWSE      => [ "Browse",                  $ResponseValues{Yes} ],
    CHANNEL     => [ "ChannelName" ],
    CONNAME     => [ "Conname" ],
    CURDEPTH    => [ "CurrentQDepth" ],
    INPUT       => [ "Input",                   $ResponseValues{QStatusInputType} ],
    INQUIRE     => [ "Inquire",                 $ResponseValues{Yes} ],
    IPPROCS     => [ "OpenInputCount" ],
    OPPROCS     => [ "OpenOutputCount" ],
    OUTPUT      => [ "Output",                  $ResponseValues{Yes} ],
    PSBNAME     => [ "PSBName" ],
    PSTID       => [ "PSTId" ],
    QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
   # QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
    QSTATUS     => [ "QName" ],
    SET         => [ "Set",                     $ResponseValues{Yes} ],
    TASKNO      => [ "TaskNumber" ],
    TRANSID     => [ "TransactionId" ],
    TYPE        => [ "StatusType",              $ResponseValues{StatusType} ],
    UNCOM       => [ "UncommittedMsgs" ],
    URID        => [ "URId" ],
    USERID      => [ "UserIdentifier" ],
   },

   AuthInfo =>
   {
    ALTDATE	=> [ "AlterationDate" ],
    ALTTIME	=> [ "AlterationTime" ],
    AUTHINFO    => [ "AuthInfoName" ],
    AUTHTYPE    => [ "AuthInfoType",            $ResponseValues{AuthInfoType} ],
    CONNAME     => [ "AuthInfoConnName" ],
    DESCR       => [ "AuthInfoDesc" ],
    LDAPPWD     => [ "LDAPPassword" ],
    LDAPUSER    => [ "LDAPUserName" ],
    QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
    #QSGDISP     => [ "QSGDisposition",		$ResponseValues{QSGDisposition} ],
   },

   CFStruc => 
   {
    ALTDATE	=> [ "AlterationDate" ],
    ALTTIME	=> [ "AlterationTime" ],
    CFLEVEL     => [ "CFLevel" ],
    CFSTRUCT    => [ "CFStrucName" ],
    DESCR       => [ "CFStrucDesc" ],
    RECOVER     => [ "Recovery",                $ResponseValues{Yes} ],
   },

   #
   # NOTE: CFStruct is for backwards compatibility with pre-1.24 MQSC
   #       New code should use CFStruc (no final 't')
   #
   CFStruct => 
   {
    ALTDATE	=> [ "AlterationDate" ],
    ALTTIME	=> [ "AlterationTime" ],
    CFLEVEL     => [ "CFStructLevel" ],
    CFSTRUCT    => [ "CFStructName" ],
    DESCR       => [ "CFStructDesc" ],
    RECOVER     => [ "Recovery",                $ResponseValues{Yes} ],
   },

  );

1;
