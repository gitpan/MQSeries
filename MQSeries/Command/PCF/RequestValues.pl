#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries/Command/PCF/RequestValues.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros
#
# (c) 1999-2002 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

%RequestValues =
  (
   #
   # QueueManager
   #
   QueueManager =>
   {
    All                         => 1009,
    AlterationDate              => 2027,
    AlterationTime              => 2028,
    AuthorityEvent              => 47,
    ChannelAutoDef              => 55,
    ChannelAutoDefEvent         => 56,
    ChannelAutoDefExit          => 2026,
    ClusterWorkLoadData         => 2034,
    ClusterWorkLoadExit         => 2033,
    ClusterWorkLoadLength       => 58,
    CodedCharSetId              => 2,
    CommandInputQName           => 2003,
    CommandLevel                => 31,
    DeadLetterQName             => 2006,
    DefXmitQName                => 2025,
    DistLists                   => 34,
    InhibitEvent                => 48,
    LocalEvent                  => 49,
    MaxHandles                  => 11,
    MaxMsgLength                => 13,
    MaxPriority                 => 14,
    MaxUncommittedMsgs          => 33,
    PerformanceEvent            => 53,
    Platform                    => 32,
    QMgrDesc                    => 2014,
    QMgrIdentifier              => 2032,
    QMgrName                    => 2015,
    RemoteEvent                 => 50,
    RepositoryName              => 2035,
    RepositoryNamelist          => 2036,
    StartStopEvent              => 52,
    SyncPoint                   => 30,
    TriggerInterval             => 25,
   },

   #
   # Process
   #
   Process =>
   {
    All                         => 1009,
    AlterationDate              => 2027,
    AlterationTime              => 2028,
    ApplId                      => 2001,
    ApplType                    => 1,
    EnvData                     => 2007,
    ProcessDesc                 => 2011,
    ProcessName                 => 2012,
    ProcessNames                => 3012,
    UserData                    => 2021,
   },

   ApplType =>
   {
    AIX                         => 6,
    CICS                        => 1,
    DOS                         => 5,
    Default                     => 6,
    IMS                         => 3,
    MVS                         => 2,
    NSK                         => 13,
    OS2                         => 4,
    OS400                       => 8,
    UNIX                        => 6,
    VMS                         => 12,
    Win16                       => 9,
    Win32                       => 11,
   },

   #
   # Queue
   #
   Queue =>
   {
    All                         => 1009,
    AlterationDate              => 2027,
    AlterationTime              => 2028,
    BackoutRequeueName          => 2019,
    BackoutThreshold            => 22,
    BaseQName                   => 2002,
    ClusterDate                 => 2037,
    ClusterName                 => 2029,
    ClusterNamelist             => 2030,
    ClusterQType                => 59,
    ClusterTime                 => 2038,
    CreationDate                => 2004,
    CreationTime                => 2005,
    CurrentQDepth               => 3,
    DefBind                     => 61,
    DefInputOpenOption          => 4,
    DefPersistence              => 5,
    DefPriority                 => 6,
    DefinitionType              => 7,
    DistLists                   => 34,
    HardenGetBackout            => 8,
    HighQDepth                  => 36,
    InhibitGet                  => 9,
    InhibitPut                  => 10,
    InitiationQName             => 2008,
    MaxMsgLength                => 13,
    MaxQDepth                   => 15,
    MsgDeliverySequence         => 16,
    MsgDeqCount                 => 38,
    MsgEnqCount                 => 37,
    OpenInputCount              => 17,
    OpenOutputCount             => 18,
    ProcessName                 => 2012,
    QDepthHighEvent             => 43,
    QDepthHighLimit             => 40,
    QDepthLowEvent              => 44,
    QDepthLowLimit              => 41,
    QDepthMaxEvent              => 42,
    QDesc                       => 2013,
    QMgrIdentifier              => 2032,
    QMgrName                    => 2031,
    QName                       => 2016,
    QNames                      => 3011,
    QServiceInterval            => 54,
    QServiceIntervalEvent       => 46,
    QType                       => 20,
    RemoteQMgrName              => 2017,
    RemoteQName                 => 2018,
    RetentionInterval           => 21,
    Scope                       => 45,
    Shareability                => 23,
    TimeSinceReset              => 35,
    TriggerControl              => 24,
    TriggerData                 => 2023,
    TriggerDepth                => 29,
    TriggerMsgPriority          => 26,
    TriggerType                 => 28,
    Usage                       => 12,
    XmitQName                   => 2024,
   },

   QType =>
   {
    Alias                       => 3,
    All                         => 1001,
    Cluster                     => 7,
    Local                       => 1,
    Model                       => 2,
    Remote                      => 6,
   },

   DefInputOpenOption =>
   {
    Exclusive                   => 4,
    Shared                      => 2,
   },

   MsgDeliverySequence =>
   {
    FIFO                        => 1,
    Priority                    => 0,
   },

   Usage =>
   {
    Normal                      => 0,
    XMITQ                       => 1,
   },

   TriggerType =>
   {
    Depth                       => 3,
    Every                       => 2,
    First                       => 1,
    None                        => 0,
   },

   DefinitionType =>
   {
    Permanent                   => 2,
    Temporary                   => 3,
   },

   Scope =>
   {
    Cell                        => 2,
    QMgr                        => 1,
   },

   QServiceIntervalEvent =>
   {
    High                        => 1,
    None                        => 0,
    OK                          => 2,
   },

   #
   # Channels
   #
   Channel =>
   {
    All                         => 1009,
    AlterationDate              => 2027,
    AlterationTime              => 2028,
    BatchInterval               => 1564,
    BatchSize                   => 1502,
    Batches                     => 1537,
    BuffersReceived             => 1539,
    BuffersSent                 => 1538,
    BytesReceived               => 1536,
    BytesSent                   => 1535,
    ChannelDesc                 => 3502,
    ChannelInstanceType         => 1523,
    ChannelName                 => 3501,
    ChannelNames                => 3512,
    ChannelStartDate            => 3529,
    ChannelStartTime            => 3528,
    ChannelStatus               => 1527,
    ChannelType                 => 1511,
    ClusterName                 => 2029,
    ClusterNamelist             => 2030,
    ConnectionName              => 3506,
    CurrentLUWID                => 3532,
    CurrentMsgs                 => 1531,
    CurrentSequenceNumber       => 1532,
    DataConversion              => 1515,
    DiscInterval                => 1503,
    HeartbeatInterval           => 1563,
    InDoubtStatus               => 1528,
    LastLUWID                   => 3531,
    LastMsgDate                 => 3525,
    LastMsgTime                 => 3524,
    LastSequenceNumber          => 1529,
    LongRetriesLeft             => 1540,
    LongRetryCount              => 1507,
    LongRetryInterval           => 1506,
    MCAJobName                  => 3530,
    MCAName                     => 3507,
    MCAStatus                   => 1542,
    MCAType                     => 1517,
    MCAUserIdentifier           => 3527,
    MaxMsgLength                => 1510,
    ModeName                    => 3503,
    MsgExit                     => 3509,
    MsgRetryCount               => 1544,
    MsgRetryExit                => 3534,
    MsgRetryInterval            => 1545,
    MsgRetryUserData            => 3535,
    MsgUserData                 => 3514,
    Msgs                        => 1534,
    NetworkPriority             => 1565,
    NonPersistentMsgSpeed       => 1562,
    Password                    => 3518,
    PutAuthority                => 1508,
    QMgrName                    => 2015,
    ReceiveExit                 => 3511,
    ReceiveUserData             => 3516,
    SecurityExit                => 3508,
    SecurityUserData            => 3513,
    SendExit                    => 3510,
    SendUserData                => 3515,
    SeqNumberWrap               => 1509,
    ShortRetriesLeft            => 1541,
    ShortRetryCount             => 1505,
    ShortRetryInterval          => 1504,
    StopRequested               => 1543,
    TpName                      => 3504,
    TransportType               => 1501,
    UserIdentifier              => 3517,
    XmitQName                   => 3505,
   },

   ChannelType =>
   {
    All                         => 5,
    Clntconn                    => 6,
    ClusterReceiver             => 8,
    ClusterSender               => 9,
    Receiver                    => 3,
    Requester                   => 4,
    Sender                      => 1,
    Server                      => 2,
    Svrconn                     => 7,
   },

   TransportType =>
   {
    DECnet                      => 5,
    LU62                        => 1,
    NetBIOS                     => 3,
    SPX                         => 4,
    TCP                         => 2,
    UDP                         => 6,
   },

   PutAuthority =>
   {
    Context                     => 2,
    Default                     => 1,
   },

   MCAType =>
   {
    Process                     => 1,
    Thread                      => 2,
   },

   NonPersistentMsgSpeed =>
   {
    Normal                      => 1,
    Fast                        => 2,
   },

   ChannelTable =>
   {
    Clntconn                    => 2,
    QMgr                        => 1,
   },

   ChannelInstanceType =>
   {
    Current                     => 1011,
    Saved                       => 1012,
   },

   InDoubt =>
   {
    Backout                     => 2,
    Commit                      => 1,
   },

   #
   # Escape
   #
   EscapeType =>
   {
    MQSC                        => 1,
   },

   #
   # New entries for MQSeries 5.1
   #
   Cluster =>
   {
    AlterationDate              => 2027,
    AlterationTime              => 2028,
    BatchInterval               => 1564,
    BatchSize                   => 1502,
    ChannelStatus               => 1527,
    ClusterDate                 => 2037,
    ClusterName                 => 2029,
    ClusterTime                 => 2038,
    ConnectionName              => 3506,
    DataConversion              => 1515,
    Description                 => 3502,
    DiscInterval                => 1503,
    HeartbeatInterval           => 1563,
    LongRetryCount              => 1507,
    LongRetryInterval           => 1506,
    MCAName                     => 3507,
    MCAType                     => 1517,
    MCAUserIdentifier           => 3527,
    MaxMsgLength                => 1510,
    ModeName                    => 3503,
    MsgExit                     => 3509,
    MsgRetryCount               => 1544,
    MsgRetryExit                => 3534,
    MsgRetryInterval            => 1545,
    MsgRetryUserData            => 3535,
    MsgUserData                 => 3514,
    NetworkPriority             => 1565,
    NonPersistentMsgSpeed       => 1562,
    Password                    => 3518,
    PutAuthority                => 1508,
    QMgrDefinitionType          => 1084,
    QMgrIdentifier              => 2032,
    QMgrType                    => 1085,
    ReceiveExit                 => 3511,
    ReceiveUserData             => 3516,
    SecurityExit                => 3508,
    SecurityUserData            => 3513,
    SendExit                    => 3510,
    SendUserData                => 3515,
    SeqNumberWrap               => 1509,
    ShortRetryCount             => 1505,
    ShortRetryInterval          => 1504,
    Suspend                     => 1087,
    TpName                      => 3504,
    TransportType               => 1501,
    UserIdentifier              => 3517,
    XmitQName                   => 3505,
   },

   Namelist =>
   {
    All				=> 1009,
    AlterationDate              => 2027,
    AlterationTime              => 2028,
    NamelistDesc                => 2009,
    NamelistName                => 2010,
    Names                       => 2020,
    NameCount			=> 19,
   },

   Action =>
   {
    ForceRemove                 => 1,
   },

   DefBind =>
   {
    OnOpen                      => 0,
    NotFixed                    => 1,
   },

   ObjectType =>
   {
    Namelist			=> 2,
    Process			=> 3,
    Queue			=> 1,
    QueueManager		=> 5,

    Channel			=> 6,

    All				=> 1001,
    AliasQueue			=> 1002,
    ModelQueue			=> 1003,
    LocalQueue			=> 1004,
    RemoteQueue			=> 1005,

    SenderChannel		=> 1007,
    ServerChannel		=> 1008,
    RequesterChannel		=> 1009,
    ReceiverChannel		=> 1010,
    CurrentChannel		=> 1011,
    SavedChannel		=> 1012,
    SvrconnChannel		=> 1013,
    ClntconnChannel		=> 1014,
   },

   EntityType =>
   {
    Principal			=> 1000,
    Group			=> 1001,
    AFS			        => 1002,
   },

  );

1;
