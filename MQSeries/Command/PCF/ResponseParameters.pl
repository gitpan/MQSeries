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
# (c) 1999 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

%ResponseParameters =
  (

   QueueManager =>
   {
    32                                   => [ "Platform",                $ResponseValues{Platform} ],

    2027                                 => [ "AlterationDate" ],
    2028                                 => [ "AlterationTime" ],
    2026                                 => [ "ChannelAutoDefExit" ],
    2034                                 => [ "ClusterWorkLoadData" ],
    2033                                 => [ "ClusterWorkLoadExit" ],
    2003                                 => [ "CommandInputQName" ],
    2006                                 => [ "DeadLetterQName" ],
    2025                                 => [ "DefXmitQName" ],
    2014                                 => [ "QMgrDesc" ],
    2032                                 => [ "QMgrIdentifier" ],
    2015                                 => [ "QMgrName" ],
    2035                                 => [ "RepositoryName" ],
    2036                                 => [ "RepositoryNamelist" ],
    47                                   => [ "AuthorityEvent" ],
    55                                   => [ "ChannelAutoDef" ],
    56                                   => [ "ChannelAutoDefEvent" ],
    58                                   => [ "ClusterWorkLoadLength" ],
    2                                    => [ "CodedCharSetId" ],
    31                                   => [ "CommandLevel" ],
    34                                   => [ "DistLists" ],
    48                                   => [ "InhibitEvent" ],
    49                                   => [ "LocalEvent" ],
    11                                   => [ "MaxHandles" ],
    13                                   => [ "MaxMsgLength" ],
    14                                   => [ "MaxPriority" ],
    33                                   => [ "MaxUncommittedMsgs" ],
    53                                   => [ "PerformanceEvent" ],
    50                                   => [ "RemoteEvent" ],
    52                                   => [ "StartStopEvent" ],
    30                                   => [ "SyncPoint" ],
    25                                   => [ "TriggerInterval" ],
   },

   Queue =>
   {
    59                                   => [ "ClusterQType",            $ResponseValues{ClusterQType} ],
    7                                    => [ "DefinitionType",          $ResponseValues{DefinitionType} ],
    61                                   => [ "DefBind",                 $ResponseValues{DefBind} ],
    4                                    => [ "DefInputOpenOption",      $ResponseValues{DefInputOpenOption} ],
    16                                   => [ "MsgDeliverySequence",     $ResponseValues{MsgDeliverySequence} ],
    46                                   => [ "QServiceIntervalEvent",   $ResponseValues{QServiceIntervalEvent} ],
    20                                   => [ "QType",                   $ResponseValues{QType} ],
    45                                   => [ "Scope",                   $ResponseValues{Scope} ],
    28                                   => [ "TriggerType",             $ResponseValues{TriggerType} ],
    12                                   => [ "Usage",                   $ResponseValues{Usage} ],

    3011                                 => [ "QNames" ],
    2027                                 => [ "AlterationDate" ],
    2028                                 => [ "AlterationTime" ],
    2019                                 => [ "BackoutRequeueName" ],
    2002                                 => [ "BaseQName" ],
    2037                                 => [ "ClusterDate" ],
    2029                                 => [ "ClusterName" ],
    2030                                 => [ "ClusterNamelist" ],
    2031                                 => [ "QMgrName" ],
    2038                                 => [ "ClusterTime" ],
    2004                                 => [ "CreationDate" ],
    2005                                 => [ "CreationTime" ],
    2008                                 => [ "InitiationQName" ],
    2012                                 => [ "ProcessName " ],
    2013                                 => [ "QDesc" ],
    2032                                 => [ "QMgrIdentifier" ],
    2016                                 => [ "QName" ],
    2017                                 => [ "RemoteQMgrName" ],
    2018                                 => [ "RemoteQName" ],
    2023                                 => [ "TriggerData" ],
    2024                                 => [ "XmitQName" ],
    22                                   => [ "BackoutThreshold" ],
    3                                    => [ "CurrentQDepth" ],
    5                                    => [ "DefPersistence" ],
    6                                    => [ "DefPriority" ],
    34                                   => [ "DistLists" ],
    8                                    => [ "HardenGetBackout" ],
    36                                   => [ "HighQDepth" ],
    9                                    => [ "InhibitGet" ],
    10                                   => [ "InhibitPut" ],
    13                                   => [ "MaxMsgLength" ],
    15                                   => [ "MaxQDepth" ],
    38                                   => [ "MsgDeqCount" ],
    37                                   => [ "MsgEnqCount" ],
    17                                   => [ "OpenInputCount" ],
    18                                   => [ "OpenOutputCount" ],
    43                                   => [ "QDepthHighEvent" ],
    40                                   => [ "QDepthHighLimit" ],
    44                                   => [ "QDepthLowEvent" ],
    41                                   => [ "QDepthLowLimit" ],
    42                                   => [ "QDepthMaxEvent" ],
    54                                   => [ "QServiceInterval" ],
    21                                   => [ "RetentionInterval" ],
    23                                   => [ "Shareability" ],
    35                                   => [ "TimeSinceReset" ],
    24                                   => [ "TriggerControl" ],
    29                                   => [ "TriggerDepth" ],
    26                                   => [ "TriggerMsgPriority" ],
   },

   Process =>
   {
    1                                    => [ "ApplType",                $ResponseValues{ApplType} ],

    3012                                 => [ "ProcessNames" ],
    2027                                 => [ "AlterationDate" ],
    2028                                 => [ "AlterationTime" ],
    2001                                 => [ "ApplId" ],
    2007                                 => [ "EnvData" ],
    2011                                 => [ "ProcessDesc" ],
    2012                                 => [ "ProcessName" ],
    2021                                 => [ "UserData" ],
   },

   Channel =>
   {
    1523                                 => [ "ChannelInstanceType",     $ResponseValues{ChannelInstanceType} ],
    1527                                 => [ "ChannelStatus",           $ResponseValues{ChannelStatus} ],
    1511                                 => [ "ChannelType",             $ResponseValues{ChannelType} ],
    1542                                 => [ "MCAStatus",               $ResponseValues{MCAStatus} ],
    1517                                 => [ "MCAType",                 $ResponseValues{MCAType} ],
    1562                                 => [ "NonPersistentMsgSpeed",   $ResponseValues{NonPersistentMsgSpeed} ],
    1508                                 => [ "PutAuthority",            $ResponseValues{PutAuthority} ],
    1501                                 => [ "TransportType",           $ResponseValues{TransportType} ],

    3501                                 => [ "ChannelName" ],
    3512                                 => [ "ChannelNames" ],
    3529                                 => [ "ChannelStartDate" ],
    3528                                 => [ "ChannelStartTime" ],
    3506                                 => [ "ConnectionName" ],
    3532                                 => [ "CurrentLUWID" ],
    3502                                 => [ "ChannelDesc" ],
    3531                                 => [ "LastLUWID" ],
    3525                                 => [ "LastMsgDate" ],
    3524                                 => [ "LastMsgTime" ],
    3530                                 => [ "MCAJobName" ],
    3507                                 => [ "MCAName" ],
    3527                                 => [ "MCAUserIdentifier" ],
    3503                                 => [ "ModeName" ],
    3534                                 => [ "MsgRetryExit" ],
    3535                                 => [ "MsgRetryUserData" ],
    3509                                 => [ "MsgExit" ],
    3514                                 => [ "MsgUserData" ],
    3518                                 => [ "Password" ],
    3511                                 => [ "ReceiveExit" ],
    3516                                 => [ "ReceiveUserData" ],
    3508                                 => [ "SecurityExit" ],
    3513                                 => [ "SecurityUserData" ],
    3510                                 => [ "SendExit" ],
    3515                                 => [ "SendUserData" ],
    3504                                 => [ "TpName" ],
    3517                                 => [ "UserIdentifier" ],
    3505                                 => [ "XmitQName" ],
    2027                                 => [ "AlterationDate" ],
    2028                                 => [ "AlterationTime" ],
    2029                                 => [ "ClusterName" ],
    2030                                 => [ "ClusterNamelist" ],
    2015                                 => [ "QMgrName" ],
    1537                                 => [ "Batches" ],
    1564                                 => [ "BatchInterval" ],
    1502                                 => [ "BatchSize" ],
    1539                                 => [ "BuffersReceived" ],
    1538                                 => [ "BuffersSent" ],
    1536                                 => [ "BytesReceived" ],
    1535                                 => [ "BytesSent" ],
    1531                                 => [ "CurrentMsgs" ],
    1532                                 => [ "CurrentSequenceNumber" ],
    1515                                 => [ "DataConversion" ],
    1503                                 => [ "DiscInterval" ],
    1563                                 => [ "HeartbeatInterval" ],
    1528                                 => [ "InDoubtStatus" ],
    1529                                 => [ "LastSequenceNumber" ],
    1540                                 => [ "LongRetriesLeft" ],
    1507                                 => [ "LongRetryCount" ],
    1506                                 => [ "LongRetryInterval" ],
    1510                                 => [ "MaxMsgLength" ],
    1544                                 => [ "MsgRetryCount" ],
    1545                                 => [ "MsgRetryInterval" ],
    1534                                 => [ "Msgs" ],
    1565                                 => [ "NetworkPriority" ],
    1509                                 => [ "SeqNumberWrap" ],
    1541                                 => [ "ShortRetriesLeft" ],
    1505                                 => [ "ShortRetryCount" ],
    1504                                 => [ "ShortRetryInterval" ],
    1543                                 => [ "StopRequested" ],
   },

   Escape =>
   {
    3014                                 => [ "EscapeText" ],
    1017                                 => [ "EscapeType" ],
   },

   #
   # New entries for MQSeries 5.1
   #
   Cluster =>
   {
    1084                                 => [ "QMgrDefinitionType",      $ResponseValues{QMgrDefinitionType} ],
    1085                                 => [ "QMgrType",                $ResponseValues{QMgrType} ],
    1527                                 => [ "ChannelStatus",           $ResponseValues{ChannelStatus} ],
    1517                                 => [ "MCAType",                 $ResponseValues{MCAType} ],
    1562                                 => [ "NonPersistentMsgSpeed",   $ResponseValues{NonPersistentMsgSpeed} ],
    1508                                 => [ "PutAuthority",            $ResponseValues{PutAuthority} ],
    1501                                 => [ "TransportType",           $ResponseValues{TransportType} ],

    3501                                 => [ "ChannelName" ],
    3506                                 => [ "ConnectionName" ],
    3502                                 => [ "ChannelDesc" ],
    3507                                 => [ "MCAName" ],
    3527                                 => [ "MCAUserIdentifier" ],
    3503                                 => [ "ModeName" ],
    3534                                 => [ "MsgRetryExit" ],
    3535                                 => [ "MsgRetryUserData" ],
    3509                                 => [ "MsgExit" ],
    3514                                 => [ "MsgUserData" ],
    3518                                 => [ "Password" ],
    3511                                 => [ "ReceiveExit" ],
    3516                                 => [ "ReceiveUserData" ],
    3508                                 => [ "SecurityExit" ],
    3513                                 => [ "SecurityUserData" ],
    3510                                 => [ "SendExit" ],
    3515                                 => [ "SendUserData" ],
    3504                                 => [ "TpName" ],
    3517                                 => [ "UserIdentifier" ],
    3505                                 => [ "XmitQName" ],
    2027                                 => [ "AlterationDate" ],
    2028                                 => [ "AlterationTime" ],
    2037                                 => [ "ClusterDate" ],
    2029                                 => [ "ClusterName" ],
    2038                                 => [ "ClusterTime" ],
    2032                                 => [ "QMgrIdentifier" ],
    2015                                 => [ "QMgrName" ],
    1083                                 => [ "ClusterInfo" ],
    1087                                 => [ "Suspend" ],
    1564                                 => [ "BatchInterval" ],
    1502                                 => [ "BatchSize" ],
    1515                                 => [ "DataConversion" ],
    1503                                 => [ "DiscInterval" ],
    1563                                 => [ "HeartbeatInterval" ],
    1507                                 => [ "LongRetryCount" ],
    1506                                 => [ "LongRetryInterval" ],
    1510                                 => [ "MaxMsgLength" ],
    1544                                 => [ "MsgRetryCount" ],
    1545                                 => [ "MsgRetryInterval" ],
    1565                                 => [ "NetworkPriority" ],
    1509                                 => [ "SeqNumberWrap" ],
    1505                                 => [ "ShortRetryCount" ],
    1504                                 => [ "ShortRetryInterval" ],
   },

   Namelist =>
   {
    2027                                 => [ "AlterationDate" ],
    2028                                 => [ "AlterationTime" ],
    2009                                 => [ "NamelistDesc" ],
    2010                                 => [ "NamelistName" ],
    2020                                 => [ "Names" ],
   },

  );

1;
