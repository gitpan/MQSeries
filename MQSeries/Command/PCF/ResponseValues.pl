#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries/Command/PCF/ResponseValues.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros
#
# (c) 1999-2002 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

%ResponseValues =
  (

   Platform =>
   {
    MVS				=> 1,
    NSK				=> 13,
    OS2				=> 2,
    OS400			=> 4,
    UNIX			=> 3,
    Win16			=> 5,
    Win32			=> 11,
   },

   QType =>
   {
    Alias			=> 3,
    Cluster			=> 7,
    Local			=> 1,
    Model			=> 2,
    Remote			=> 6,
   },

   DefInputOpenOption =>
   {
    Exclusive			=> 4,
    Shared			=> 2,
   },

   MsgDeliverySequence =>
   {
    FIFO			=> 1,
    Priority			=> 0,
   },

   DefinitionType =>
   {
    Permanent			=> 2,
    Predefined			=> 1,
    Temporary			=> 3,
   },

   Usage =>
   {
    Normal			=> 0,
    XMITQ			=> 1,
   },

   TriggerType =>
   {
    Depth			=> 3,
    Every			=> 2,
    First			=> 1,
    None			=> 0,
   },

   Scope =>
   {
    Cell			=> 2,
    QMgr			=> 1,
   },

   QServiceIntervalEvent =>
   {
    High			=> 1,
    None			=> 0,
    OK				=> 2,
   },

   ChannelType =>
   {
    Clntconn			=> 6,
    ClusterReceiver		=> 8,
    ClusterSender		=> 9,
    Receiver			=> 3,
    Requester			=> 4,
    Sender			=> 1,
    Server			=> 2,
    Svrconn			=> 7,
   },

   ChannelInstanceType =>
   {
    Current			=> 1011,
    Saved			=> 1012,
   },

   MCAStatus =>
   {
    Running			=> 3,
    Stopped			=> 0,
   },

   TransportType =>
   {
    DECnet			=> 5,
    LU62			=> 1,
    NetBIOS			=> 3,
    SPX				=> 4,
    TCP				=> 2,
    UDP				=> 6,
   },

   PutAuthority =>
   {
    Context			=> 2,
    Default			=> 1,
   },

   MCAType =>
   {
    Process			=> 1,
    Thread			=> 2,
   },

   NonPersistentMsgSpeed =>
   {
    Fast			=> 2,
    Normal			=> 1,
   },

   ChannelStatus =>
   {
    Binding			=> 1,
    Inactive			=> 0,
    Initializing		=> 13,
    Paused			=> 8,
    Requesting			=> 7,
    Retrying			=> 5,
    Running			=> 3,
    Starting			=> 2,
    Stopped			=> 6,
    Stopping			=> 4,
   },

   ApplType =>
   {
    CICS			=> 1,
    DOS				=> 5,
    IMS				=> 3,
    MVS				=> 2,
    NSK                         => 13,
    OS2				=> 4,
    OS400			=> 8,
    UNIX			=> 6,
    VMS				=> 12,
    Win16			=> 9,
    Win32			=> 11,
   },

   EscapeType =>
   {
    MQSC			=> 1,
   },

   QMgrDefinitionType =>
   {
    AutoClusterSender		=> 2,
    AutoExplicitClusterSender	=> 4,
    ClusterReceiver		=> 3,
    ExplicitClusterSender	=> 1,
   },

   QMgrType =>
   {
    Normal			=> 0,
    Repository			=> 1,
   },

   ClusterQType =>
   {
    Alias			=> 2,
    Local			=> 1,
    QMgrAlias			=> 4,
    Remote			=> 3,
   },

   DefBind =>
   {
    NotFixed			=> 1,
    OnOpen			=> 0,
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
