#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries/Command/PCF/RequestParameterRequired.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros 
#
# (c) 1999, 2000 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

#
# Since PCF commands have to list the required parameters *before* any
# optional ones, MQSeries::Command::Request::_TranslatePCF uses this
# hash to indicate which parameters are required.
#
# NOTE: You only have to list a command and its required parameters
# here if the command has *both* required and optional parameters.  If
# the command's parameters are either all required or all optional, it
# can be omitted entirely.
#

%RequestParameterRequired =
  (

   InquireAuthority		=>
   {
    ObjectType			=> 1,
    ObjectName			=> 1,
   },

   ChangeAuthority		=>
   {
    ObjectName			=> 1,
    ObjectType			=> 1,
    EntityName			=> 1,
    EntityType			=> 1,
   },

   CopyChannel                  =>
   {
    ChannelType                 => 1,
    FromChannelName             => 1,
    ToChannelName               => 1,
   },

   CopyNamelist                 =>
   {
    FromNamelistName            => 1,
    ToNamelistName              => 1,
   },

   CopyProcess                  =>
   {
    FromProcessName             => 1,
    ToProcessName               => 1,
   },

   CopyQueue                    =>
   {
    FromQName                   => 1,
    QType                       => 1,
    ToQName                     => 1,
   },

   InquireClusterQueueManager   =>
   {
    ClusterQMgrName             => 1,
   },

   SuspendQueueManagerCluster   =>
   {
    ClusterName                 => 1,
    ClusterNamelist             => 1,
   },

  );

#
# This *greatly* shrinks the size of this file...
#
$RequestParameterRequired{InquireNamelist} =
  $RequestParameterRequired{CreateNamelist} =
  $RequestParameterRequired{ChangeNamelist} =
  {
   NamelistName         => 1,
  };

$RequestParameterRequired{InquireProcess} =
  $RequestParameterRequired{CreateProcess} =
  $RequestParameterRequired{ChangeProcess} =
  {
   ProcessName          => 1,
  };

$RequestParameterRequired{CreateQueue} =
  $RequestParameterRequired{ChangeQueue} =
  {
   QName                        => 1,
   QType                        => 1,
  };

$RequestParameterRequired{InquireQueueNames} =
  $RequestParameterRequired{InquireQueue} =
  $RequestParameterRequired{DeleteQueue} =
  {
   QName                        => 1,
  };

$RequestParameterRequired{CreateChannel} =
  $RequestParameterRequired{ChangeChannel} =
  {
   ChannelName                  => 1,
   ChannelType                  => 1,
  };

$RequestParameterRequired{StopChannel} =
  $RequestParameterRequired{ResetChannel} =
  $RequestParameterRequired{PingChannel} =
  $RequestParameterRequired{InquireChannelStatus} =
  $RequestParameterRequired{InquireChannelNames} =
  $RequestParameterRequired{InquireChannel} =
  $RequestParameterRequired{DeleteChannel} =
  {
   ChannelName                  => 1,
  };

1;
