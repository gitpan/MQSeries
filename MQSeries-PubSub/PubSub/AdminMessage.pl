#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries-PubSub/PubSub/AdminMessage.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros
#
# (c) 1999-2004 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::PubSub::AdminMessage;

%Responses =
  (
   60                                    => "DeletePublication",
   61                                    => "DeregisterPublisher",
   62                                    => "DeregisterSubscriber",
   63                                    => "Publish",
   64                                    => "RegisterPublisher",
   65                                    => "RegisterSubscriber",
   66                                    => "RequestUpdate",
   67                                    => "BrokerInternal",
  );

%ResponseParameters =
  (
   3040                                  => "QMgrName",
   3032                                  => "QMgrName",
   3034                                  => "PublishTimestamp",
   3044                                  => "RegistrationCorrelId",
   3042                                  => "RegistrationQMgrName",
   3043                                  => "RegistrationQName",
   3041                                  => "RegistrationStreamName",
   3038                                  => "RegistrationTime",
   3037                                  => "RegistrationTopic",
   3039                                  => "RegistrationUserIdentifier",
   3030                                  => "StreamName",
   3036                                  => "SupportedStreamName",
   3031                                  => "Topic",
   1090                                  => "AnonymousCount",
   1089                                  => "ApplCount",
   1088                                  => "BrokerCount",
   1082                                  => "PublicationOptions",
   1081                                  => "RegistrationOptions",
   1091                                  => "RegistrationRegistrationOptions",
  );

%RegistrationOptions =
  (
   1                                     => "CorrelAsId",
   2                                     => "Anon",
   4                                     => "Local",
   8                                     => "DirectReq",
   16                                    => "NewPubsOnly",
   32                                    => "PubOnReqOnly",
   64                                    => "DeregAll",
   128                                   => "InclStreamName",
   256                                   => "InformIfRet",
  );

%PublicationOptions =
  (
   1                                     => "CorrelAsId",
   2                                     => "RetPub",
   4                                     => "OtherSubOnly",
   8                                     => "NoReg",
   16                                    => "IsRetPub",
  );

1;
