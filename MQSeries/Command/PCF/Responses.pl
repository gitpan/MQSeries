#
# WARNING: This file is automatically generated.
# Any changes made here will be mercilessly lost.
#
# You have been warned, infidel.
#
# P.S. For the real source to this file, see:
#
#    ..../src/pre.in/MQSeries/Command/PCF/Responses.in
#
# and for the evil hackery used to generate this, see:
#
#    ..../src/util/flatten_macros
#
# (c) 1999-2004 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#
package MQSeries::Command::PCF;

%Responses =
  (
   Error				=> [ "Error",				$ResponseParameters{Error} ],

   ChangeAuthInfo                   	=> [ 79,                      		$ResponseParameters{AuthInfo} ],
   ChangeChannel                   	=> [ 21,                    		$ResponseParameters{Channel} ],
   ChangeProcess 			=> [ 3,                     		$ResponseParameters{Process} ],
   ChangeQueue 				=> [ 8,               			$ResponseParameters{Queue} ],
   ChangeQueueManager 			=> [ 1,                   		$ResponseParameters{QueueManager} ],

   ClearQueue 				=> [ 9,              			$ResponseParameters{Queue} ],

   CopyAuthInfo				=> [ 80,                    		$ResponseParameters{AuthInfo} ],
   CopyChannel 				=> [ 22,                  		$ResponseParameters{Channel} ],
   CopyProcess 				=> [ 4,                   		$ResponseParameters{Process} ],
   CopyQueue 				=> [ 10,            			$ResponseParameters{Queue} ],

   CreateAuthInfo 			=> [ 81,                      		$ResponseParameters{AuthInfo} ],
   CreateChannel 			=> [ 23,                    		$ResponseParameters{Channel} ],
   CreateProcess 			=> [ 5,                     		$ResponseParameters{Process} ],
   CreateQueue 				=> [ 11,              			$ResponseParameters{Queue} ],

   DeleteAuthInfo 			=> [ 82,                      		$ResponseParameters{AuthInfo} ],
   DeleteChannel 			=> [ 24,                    		$ResponseParameters{Channel} ],
   DeleteProcess 			=> [ 6,                     		$ResponseParameters{Process} ],
   DeleteQueue 				=> [ 12,              			$ResponseParameters{Queue} ],

   Escape 				=> [ 38,            			$ResponseParameters{Escape} ],

   InquireAuthInfo 			=> [ 83,                       		$ResponseParameters{AuthInfo} ],
   InquireAuthInfoNames			=> [ 84,                                 $ResponseParameters{AuthInfo} ],
   InquireChannel 			=> [ 25,                     		$ResponseParameters{Channel} ],
   InquireChannelNames 			=> [ 20,                           	$ResponseParameters{Channel} ],
   InquireChannelStatus 		=> [ 42,                            	$ResponseParameters{Channel} ],
   InquireClusterQueueManager 		=> [ 70,                           	$ResponseParameters{Cluster} ],
   InquireNamelist 			=> [ 36,                      		$ResponseParameters{Namelist} ],
   InquireNamelistNames 		=> [ 37,                            	$ResponseParameters{Namelist} ],
   InquireProcess 			=> [ 7,                      		$ResponseParameters{Process} ],
   InquireProcessNames 			=> [ 19,                           	$ResponseParameters{Process} ],
   InquireQueue 			=> [ 13,               			$ResponseParameters{Queue} ],
   InquireQueueManager 			=> [ 2,                    		$ResponseParameters{QueueManager} ],
   InquireQueueNames 			=> [ 18,                     		$ResponseParameters{Queue} ],
   InquireQueueStatus 			=> [ 41,                      		$ResponseParameters{QueueStatus} ],

   PingChannel 				=> [ 26,                  		$ResponseParameters{Channel} ],
   PingQueueManager 			=> [ 40,                			$ResponseParameters{QueueManager} ],

   ResetChannel 			=> [ 27,                   		$ResponseParameters{Channel} ],
   ResetQueueStatistics 		=> [ 17,                   		$ResponseParameters{Queue} ],
   ResolveChannel 			=> [ 39,                     		$ResponseParameters{Channel} ],
   StartChannel 			=> [ 28,                   		$ResponseParameters{Channel} ],
   StartChannelInitiator 		=> [ 30,                        		$ResponseParameters{Channel} ],
   StartChannelListener 		=> [ 31,                            	$ResponseParameters{Channel} ],
   StopChannel 				=> [ 29,                  		$ResponseParameters{Channel} ],

   #
   # Cluster
   #
   RefreshCluster                       => [ 73,                                 $ResponseParameters{Cluster} ],

   #
   # Morgan Stanley extensions
   #
   InquireAuthority 			=> [ 1000,                      		$ResponseParameters{Authority} ],
   ChangeAuthority 			=> [ 1001,                     		$ResponseParameters{Authority} ],

  );

1;
