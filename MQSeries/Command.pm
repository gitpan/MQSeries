#
# $Id: Command.pm,v 15.7 2000/11/13 21:57:24 wpm Exp $
#
# (c) 1999, 2000 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#

package MQSeries::Command;

require 5.004;

use strict qw(vars refs);
use Carp;
use English;

use MQSeries;
use MQSeries::QueueManager;
use MQSeries::Queue;
use MQSeries::Command::Request;
use MQSeries::Command::Response;
use MQSeries::Command::PCF;
use MQSeries::Command::MQSC;
use MQSeries::Utils qw(ConvertUnit);

use vars qw($VERSION);

$VERSION = '1.12';

sub new {

    my $proto = shift;
    my $class = ref($proto) || $proto;
    my %args = @_;

    my $self =
      {
       Reason			=> 0,
       CompCode			=> 0,
       Wait 			=> 60000, # 60 second wait for replies...
       Expiry			=> 600,	# 60 second expiry on requests
       Carp			=> \&carp,
       Type			=> 'PCF',
       ModelQName		=> 'SYSTEM.DEFAULT.MODEL.QUEUE',
       DynamicQName		=> 'PERL.COMMAND.*',
       StrictMapping		=> 0,
      };

    #
    # First thing -- override the Carp routine if given.
    #
    if ( $args{Carp} ) {
	if ( ref $args{Carp} ne "CODE" ) {
	    carp "Invalid argument: 'Carp' must be a CODE reference";
	    return;
	} else {
	    $self->{Carp} = $args{Carp};
	}
    }

    #
    # You can specify the type, but we'll default to PCF
    #
    if ( $args{Type} ) {
	unless ( $args{Type} eq 'PCF' or $args{Type} eq 'MQSC' ) {
	    $self->{Carp}->("Invalid argument: 'Type' must be one of: PCF MQSC");
	    return;
	}
	$self->{Type} = $args{Type};
    }

    #
    # Fully qualify the class as either ::PCF or ::MQSC, but beware,
    # as someone can now do:  MQSeries::Command::PCF->new()
    #
    if ( $class =~ /::(PCF|MQSC)$/ ) {
	if ( $self->{Type} ne $1 ) {
	    $self->{Carp}->("Invalid argument: 'Type' $self->{Type} does not match $class");
	    return;
	}
    } else {
	$class .= "::" . $self->{Type};
    }

    bless ($self, $class);

    #
    # Allow the DynamicQName template for the ReplyToQName to be
    # overridden, as well as the ModelQName.
    #
    if ( $args{DynamicQName} ) {
	$self->{DynamicQName} = $args{DynamicQName};
    }

    if ( $args{ModelQName} ) {
	$self->{ModelQName} = $args{ModelQName};
    }

    #
    # Do we want strict mapping turned on?
    #
    if ( exists $args{StrictMapping} ) {
	$self->{StrictMapping} = $args{StrictMapping};
    }

    #
    # Where do we send requests?
    #
    if ( $args{CommandQueueName} ) {
	$self->{CommandQueueName} = $args{CommandQueueName};
    } else {
	#
	# Some reasonable defaults.  If we're proxying to a MQSC
	# queue manager, then this is (in the author's case
	# anyway) probably an MVS queue manager with no direct
	# client access.
	#
	if ( $self->{Type} eq 'MQSC' ) {
	    $self->{CommandQueueName} = "SYSTEM.COMMAND.INPUT";
	} else {
	    $self->{CommandQueueName} = "SYSTEM.ADMIN.COMMAND.QUEUE";
	}
    }

    #
    # But if you specify the proxy, things are a bit more complex.
    #
    # NOTE: This value can be a empty string, to indicate the
    # "default" queue manager.
    #
    if ( exists $args{ProxyQueueManager} ) {
	
	if ( ref $args{QueueManager} || $args{QueueManager} eq "" ) {
	    $self->{Carp}->("QueueManager must be a non-empty string when ProxyQueueManager is specified");
	    return;
	}

	$self->{ProxyQueueManager}	= $args{ProxyQueueManager};
	$self->{RealQueueManager} 	= $args{QueueManager};
	$self->{ReplyToQMgr} 		= $args{ProxyQueueManager};

	unless ( $args{CommandQueueName} ) {
	    $self->{CommandQueueName} .= ".$args{QueueManager}";
	}

	if ( ref $args{ProxyQueueManager} ) {
	    if ( $args{ProxyQueueManager}->isa("MQSeries::QueueManager") ) {
		$self->{QueueManager} = $args{ProxyQueueManager};
	    } else {
		$self->{Carp}->("Invalid argument: 'ProxyQueueManager' " .
				"must be an MQSeries::QueueManager object");
		return;
	    }
	} else {
	    $self->{QueueManager} = MQSeries::QueueManager->new
	      (
	       QueueManager	=> $args{ProxyQueueManager},
	       Carp		=> $self->{Carp},
	      ) or return;
	}

    } else {
	if ( ref $args{QueueManager} ) {
	    if ( $args{QueueManager}->isa("MQSeries::QueueManager") ) {
		$self->{QueueManager} = $args{QueueManager};
	    } else {
		$self->{Carp}->("Invalid argument: 'QueueManager' " .
				"must be an MQSeries::QueueManager object");
		return;
	    }
	} else {
	    $self->{QueueManager} = MQSeries::QueueManager->new
	      (
	       QueueManager	=> $args{QueueManager},
	       Carp		=> $self->{Carp},
	      ) or return;
	}
    }

    #
    # If we are sending things via a remote queue manager (and a
    # qremote definition), then we need to tell how to get back.  This
    # defaults to the ProxyQueueManager, and may not need to be set
    # explicitly, for example to utilize a special purpose channel.
    #
    # FIXME: Why don't we set the DynamicQName and the ModelQName here either?
    #
    foreach my $parameter ( qw(ReplyToQMgr CommandQueueName ) ) {
	if ( $args{$parameter} ) {
            $self->{$parameter} = $args{$parameter};
	}
    }

    #
    # The Wait and Expiry parameters can be tweaked, too.
    #
    foreach my $parameter (qw(Expiry Wait)) {
	if (defined $args{$parameter}) {
            $self->{$parameter} = ConvertUnit($parameter, $args{$parameter});
        }
    }

    #
    # Open the command queue, and assume that the MQSeries::Queue
    # object will whine appropriately.
    #
    $self->{CommandQueue} = MQSeries::Queue->new
      (
       QueueManager 			=> $self->{QueueManager},
       Queue 				=> $self->{CommandQueueName},
       Mode 				=> 'output',
       Carp 				=> $self->{Carp},
       Reason				=> \$self->{"Reason"},
       CompCode				=> \$self->{"CompCode"},
      ) || do {
	  $self->{Carp}->("Unable to instantiate MQSeries::Queue object for $self->{CommandQueueName}");
	  return;
      };

    #
    # Open the ReplyToQ
    #
    if ( $args{ReplyToQ} ) {
	if ( ref $args{ReplyToQ} ) {
	    if ( $args{ReplyToQ}->isa("MQSeries::Queue") ) {
		$self->{ReplyToQ} = $args{ReplyToQ};
	    } else {
		$self->{Carp}->("Invalid argument: 'ReplyToQ' " .
				"must be an MQSeries::Queue object");
		return;
	    }
	} else {
	    $self->{ReplyToQ} = MQSeries::Queue->new
	      (
	       QueueManager 		=> $self->{QueueManager},
	       Queue 			=> $args{ReplyToQ},
	       Mode			=> 'input',
	       Carp 			=> $self->{Carp},
	       Reason			=> \$self->{"Reason"},
	       CompCode			=> \$self->{"CompCode"},
	      ) || do {
		  $self->{Carp}->("Unable to instantiate MQSeries::Queue object for $args{ReplyToQ}");
		  return;
	      };
	}
    } else {
	$self->{ReplyToQ} = MQSeries::Queue->new
	  (
	   QueueManager 		=> $self->{QueueManager},
	   Queue 			=> $self->{ModelQName},
	   DynamicQName 		=> $self->{DynamicQName},
	   Mode				=> 'input',
	   Carp 			=> $self->{Carp},
	   Reason			=> \$self->{"Reason"},
	   CompCode			=> \$self->{"CompCode"},
	  ) || do {
	      $self->{Carp}->("Unable to instantiate MQSeries::Queue object for $self->{ModelQName}");
	      return;
	  };
    }

    return $self;

}

sub DataParameters {

    my $self = shift;

    my @parameters;

    foreach my $response ( @{$self->{Response}} ) {
	next if $response->Header('CompCode') == MQCC_FAILED;
	push(@parameters,$response->Parameters());
    }

    return @parameters;

}

sub ErrorParameters {

    my $self = shift;

    my @parameters;

    foreach my $response ( @{$self->{Response}} ) {
	next if $response->Header('CompCode') != MQCC_FAILED;
	push(@parameters,$response->Parameters());
    }

    return @parameters;

}

sub CompCode {
    my $self = shift;
    return $self->{"CompCode"};
}

sub Reason {
    my $self = shift;
    return $self->{"Reason"};
}

#
# Don't autoload this....
#
sub DESTROY { 1 }

#
# This AUTOLOAD will allow any random method to be interpreted as a
# command request.  If the command isn't defined, then _Command
# will blow up.
#
sub AUTOLOAD {
    use vars qw($AUTOLOAD);
    my $self = shift;
    my $name = $AUTOLOAD;
    $name =~ s/.*://;
    return $self->_Command($name,{@_});
}

#
# This method will query the object, and if it exists, check the
# attributes to see if they match, and if they do, do nothing.  That
# is, its a conditional creation of the given object.
#
sub CreateObject {

    my $self 			= shift;
    my (%args)			= @_;
    my ($Verify,$Quiet,$Clear,$Attrs)  = @args{qw(Verify Quiet Clear Attrs)};

    my $QMgr			= (
				   $self->{RealQueueManager} ||
				   $self->{QueueManager}->{QueueManager}
				  );

    my $Need 			= 1;

    my $Inquire			= "";
    my $Create			= "";
    my $Delete			= "";
    my $Change			= "";

    my $method			= "";

    my $Key			= "";
    my $Type			= "";

    my @KeyNames		= qw(ChannelName NamelistName ProcessName QName);
    my $KeyCount		= 0;

    #
    # Verify that we have only been given exactly *one* of the primary
    # keys that let us determine the object type.
    #
    foreach my $KeyName ( @KeyNames ) {
	$KeyCount++ if exists $Attrs->{$KeyName};
    }

    #
    # ProcessName is a valid attribute for Queues, so allow this:
    #
    $KeyCount-- if exists $Attrs->{QName} && exists $Attrs->{ProcessName};

    if ( $KeyCount != 1  ) {
	$self->{Carp}->("CreateObject: Unable to determine object type.\n" .
			(
			 $KeyCount == 0
			 ? "One of the following must be specified:\n"
			 : ( "More than one of the following was specified:\n" .
			     "(Exception: ProcessName and QName can both be present, since\n" .
			     "the former is an attribute of the latter.\n" .
			     "We assume ObjectType == Queue in this case)\n" )
			) .
			"\t" . join("\n\t",@KeyNames) . "\n");
	return;
    }

    if ( $Attrs->{ChannelName} ) {
	$Inquire		= "InquireChannel";
	$Create			= "CreateChannel";
	$Change			= "ChangeChannel";
	$Key			= "ChannelName";
	$Type			= "$Attrs->{ChannelType} Channel";
    } elsif ( $Attrs->{NamelistName} ) {
	$Inquire		= "InquireNamelist";
	$Create			= "CreateNamelist";
	$Change			= "ChangeNamelist";
	$Key			= "NamelistName";
	$Type			= "Namelist";
    } elsif ( $Attrs->{QName} ) {
	$Inquire		= "InquireQueue";
	$Create			= "CreateQueue";
	$Change			= "ChangeQueue";
	$Delete			= "DeleteQueue";
	$Key			= "QName";

	if ( $Attrs->{QType} eq 'Remote' && not $Attrs->{RemoteQName} ) {
	    $Type		= "QMgr Alias";
	} elsif ( $Attrs->{QType} eq 'Local' && $Attrs->{Usage} eq 'XMITQ' ) {	
	    $Type		= "Transmission Queue";
	} else {
	    $Type		= "$Attrs->{QType} Queue";
	}
    } elsif ( $Attrs->{ProcessName} ) {
	$Inquire		= "InquireProcess";
	$Create			= "CreateProcess";
	$Change			= "ChangeProcess";
	$Key			= "ProcessName";
	$Type			= "Process";
    }

    #
    # First check to see if it exists.
    #
    my ($Object) = $self->$Inquire( $Key => $Attrs->{$Key} );

    #
    # XXX -- shouldn't we be checking for no such object specifically?
    # Of course we should...
    #
    if ( $self->Reason() && $self->Reason() != MQRC_UNKNOWN_OBJECT_NAME ) {
	$self->{Carp}->("Unable to verify existence of $Type '$QMgr/$Attrs->{$Key}'\n");
	return;
    }

    if ( ref $Object eq 'HASH' ) {

	$method = $Change;

	#
	# If it exists, let's assume we don't need to create it.  If
	# any of the attributes are wrong, we'll then say we "Need"
	# it.
	#
	$Need = 0;

	foreach my $Attr ( sort keys %$Attrs ) {

	    #
	    # Don't bother comparing Attrs passed in which don't get
	    # returned by the Inquire commands, eg. Replace, Force and
	    # others that make no sense.
	    #
	    next unless exists $Object->{$Attr};

	    my $NeedAttr = 0;

	    #
	    # One special case -- we don't need this attribute is they
	    # are both empty and/or white space.  Bear in mind that
	    # you have to feed a single space to some of these damn
	    # commands.  Very annoying.
	    #
	    # Well, actually, more than one special case.  If the
	    # attribute is a list, then it will be represented as an
	    # ARRAY reference.  This does complicate things...
	    #
	    # First, check to see if we've been fed an array with only
	    # one element.  If so, flatten it.  This greatly
	    # simplifies the comparison, since the query will not
	    # return an ARRAY if there is only one element of any
	    # given attribute.
	    #
	    if (
		ref $Attrs->{$Attr} eq "ARRAY" &&
		scalar @{$Attrs->{$Attr}} == 1
	       ) {
		$Attrs->{$Attr} = $Attrs->{$Attr}->[0];
	    }

	    if ( ref $Attrs->{$Attr} ne "ARRAY" ) {

		if ( ref $Object->{$Attr} eq "ARRAY" ) {

		    $NeedAttr = $Need = 1;

		} else {

		    unless ( $Attrs->{$Attr} =~ /^\s*$/ && $Object->{$Attr} =~ /^\s*$/ ) {
			if ( $Attrs->{$Attr} =~ /^\d+/ ) {
			    if ( $Attrs->{$Attr} != $Object->{$Attr} ) {
				$NeedAttr = $Need = 1;
			    }
			} else {
			    if ( $Attrs->{$Attr} ne $Object->{$Attr} ) {
				$NeedAttr = $Need = 1;
			    }

			}
		    }
		
		}

	    } else {

		if ( ref $Object->{$Attr} ne "ARRAY" ) {

		    $NeedAttr = $Need = 1;

		} else {

		    if ( scalar(@{$Attrs->{$Attr}}) != scalar(@{$Object->{$Attr}}) ) {

			$NeedAttr = $Need = 1;

		    } else {

			for ( my $index = 0 ; $index < scalar(@{$Attrs->{$Attr}}) ; $index++ ) {
			    unless (
				    $Attrs->{$Attr}->[$index] =~ /^\s*$/ &&
				    $Object->{$Attr}->[$index] =~ /^\s*$/
				   ) {
				if ( $Attrs->{$Attr}->[$index] =~ /^\d+/ ) {
				    if ( $Attrs->{$Attr}->[$index] != $Object->{$Attr}->[$index] ) {
					$NeedAttr = $Need = 1;
				    }
				} else {
				    if ( $Attrs->{$Attr}->[$index] ne $Object->{$Attr}->[$index] ) {
					$NeedAttr = $Need = 1;
				    }
				}
			    }
			}

		    }

		}

	    }

	    if ( $NeedAttr && ! $Quiet ) {

		print("Incorrect attribute '$Attr' for $Type '$QMgr/$Attrs->{$Key}'\n");

		if ( ref $Attrs->{$Attr} eq "ARRAY" ) {
		    print "Should be:\n\t" . join("\n\t",map { qq{'$_'} } @{$Attrs->{$Attr}}) . "\n";
		} else {
		    print "Should be: '$Attrs->{$Attr}'\n";
		}
		
		if ( ref $Object->{$Attr} eq "ARRAY") {
		    print "Currently is:\n\t" . join("\n\t",map { qq{'$_'} } @{$Object->{$Attr}} ) . "\n";
		} else {
		    print "Currently is: '$Object->{$Attr}'\n";
		}

	    }

	}

    } else {
	print "$Type '$QMgr/$Attrs->{$Key}' is missing\n" unless $Quiet;
	$method = $Create;
    }

    unless ( $Need ) {
	print "$Type '$QMgr/$Attrs->{$Key}' is correctly configured\n" unless $Quiet;
	return 1;
    }

    return 1 if $Verify;

    #
    # If the QType has changed, we'll have to delete it first.  NOTE:
    # We do *not* purge.  That should be checked out manually, as it
    # will be an odd case anyway.  In any event, this will be somewhat
    # rare.
    #
    if ( $Key eq 'QName' && $Object && $Attrs->{QType} ne $Object->{QType} ) {

	print "Deleting $Object->{QType} Queue '$QMgr/$Attrs->{$Key}'\n" unless $Quiet;

	$self->$Delete
	  (
	   $Key			=> $Attrs->{$Key},
	   QType		=> $Object->{QType},
	   (
	    $Clear && $Object->{QType} eq 'Local' ?
	    ( Purge		=> 1 ) : ()
	   )
	  ) || do {
	      $self->{Carp}->("Unable to delete $Object->{QType} Queue '$QMgr/$Attrs->{$Key}'\n" .
			      MQReasonToText($self->Reason()) . "\n");
	      return;
	  };

	$method = $Create;

    }

    unless ( $Quiet ) {
	print( ($method eq $Change ? "Updating" : "Creating") . " $Type '$QMgr/$Attrs->{$Key}'\n");
    }

    $self->$method
      (
       $Key			=> $Attrs->{$Key},
       %$Attrs,
      ) || do {
	  $self->{Carp}->("Unable to " .
			  ( $method eq $Change ? "update" : "create" ) .
			  " $Type '$QMgr/$Attrs->{$Key}'\n" .
			  MQReasonToText($self->Reason()) . "\n");
	  return;
      };

    return 1;

}

#
# This method codes the basic request/reply logic common to both PCF
# and MQSC command formats.
#
sub _Command {

    my $self 			= shift;
    my $command			= shift;
    my $parameters	 	= shift;
    my $key 			= "";

    #
    # IMPORTANT: each and every case where we return *must* set a
    # reasonable value for the Reason and CompCode.
    #
    $self->{"Reason"} 		= 0;
    $self->{"CompCode"} 	= 0;

    #
    # Allow the 'name' keys to default to '*' if not given.
    #
    my %command2name =
      (
       InquireNamelist		=> 'NamelistName',
       InquireNamelistNames	=> 'NamelistName',
       InquireProcess		=> 'ProcessName',
       InquireProcessNames	=> 'ProcessName',
       InquireQueue		=> 'QName',
       InquireQueueNames	=> 'QName',
       ResetQueueStatistics	=> 'QName',
       InquireChannel		=> 'ChannelName',
       InquireChannelNames	=> 'ChannelName',
       InquireChannelStatus	=> 'ChannelName',
      );	

    if ( $command2name{$command} ) {
	unless ( $parameters->{$command2name{$command}} ) {
	    $parameters->{$command2name{$command}} = '*';
	}
    }

    #
    # Allow the 'attr' keys to default to 'All' if not given.
    #
    # NOTE: v5 PCF does this for you, but V2 PCF and MQSC do NOT.
    # Remember -- we're after a single interface to all these formats.
    #
    my %command2all =
      (
       InquireChannel			=> 'ChannelAttrs',
       InquireChannelStatus		=> 'ChannelInstanceAttrs',
       InquireClusterQueueManager	=> 'ClusterQMgrAttrs',
       InquireNamelist			=> 'NamelistAttrs',
       InquireProcess			=> 'ProcessAttrs',
       InquireQueue			=> 'QAttrs',
       InquireQueueManager		=> 'QMgrAttrs',
      );

    if ( $command2all{$command} ) {
	unless ( $parameters->{$command2all{$command}} ) {
	    $parameters->{$command2all{$command}} = ['All'];
	}
    }

    $self->{Request} = MQSeries::Command::Request->new
      (
       MsgDesc 		=>
       {
	ReplyToQ 	=> $self->{ReplyToQ}->ObjDesc("ObjectName"),
	ReplyToQMgr	=> $self->{ReplyToQMgr},
	Expiry		=> $self->{Expiry},
       },
       Type		=> $self->{Type},
       Command 		=> $command,
       Parameters 	=> $parameters,
       Carp 		=> $self->{Carp},
       StrictMapping	=> $self->{StrictMapping},
      ) || do {
	  $self->{"CompCode"} = MQCC_FAILED;
	  $self->{"Reason"} = MQRC_UNEXPECTED_ERROR;
	  return;
      };

    unless ( $self->{CommandQueue}->Put( Message => $self->{Request} ) ) {
	$self->{"CompCode"} = $self->{CommandQueue}->CompCode();
	$self->{"Reason"} = $self->{CommandQueue}->Reason();
	return;
    }

    $self->{Response} = [];

    my $MQSCHeader = { Command => $command };

    while ( 1 ) {
	
	my $response = MQSeries::Command::Response->new
	  (
	   MsgDesc 		=>
	   {
	    CorrelId		=> $self->{Request}->MsgDesc("MsgId"),
	   },
	   Type			=> $self->{Type},
	   Header		=> $self->{Type} eq 'PCF' ? "" : {%$MQSCHeader},
	   StrictMapping	=> $self->{StrictMapping},
	  ) || do {
	      $self->{"CompCode"} = MQCC_FAILED;
	      $self->{"Reason"} = MQRC_UNEXPECTED_ERROR;
	      return;
	  };
	
	my $getresult = $self->{ReplyToQ}->Get
	  (
	   Message	=> $response,
	   Wait		=> $self->{Wait},
	  );

	unless ( $getresult ) {
	    $self->{"CompCode"} = $self->{ReplyToQ}->CompCode();
	    $self->{"Reason"} = $self->{ReplyToQ}->Reason();
	    $self->{Carp}->("MQGET from ReplyQ failed.\n" .
			    "Reason => " . MQReasonToText($self->{"Reason"}) . "\n");
	    return;
	}
	
	#
	# Keep going until there are no more messages.  This is
	# essential for MQSC, but PCF tells us when the last response
	# is in.
	#
	last if $self->{ReplyToQ}->Reason() == &MQRC_NO_MSG_AVAILABLE;

	push(@{$self->{Response}},$response);

	# Have to "reuse" the header.... blegh.
	$MQSCHeader = $response->Header() if $self->{Type} eq 'MQSC';

	last if $self->_LastSeen();

    }

    #
    # OK, now what do we feed back?
    #
    # If we didn't see the last message, then return the empty list.
    #
    unless ( $self->_LastSeen() ) {
	$self->{"CompCode"} = MQCC_FAILED if $self->{"CompCode"} == MQCC_OK;
	$self->{"Reason"} = MQRC_UNEXPECTED_ERROR if $self->{"Reason"} == MQRC_NONE;
	$self->{Carp}->("Last response message never seen\n");
	return;
    }

    #
    # Massage the responses.  This varies wildly between PCF and MQSC
    #
    $self->_ProcessResponses($command) || return;

    #
    # Handle the InquireFooNames commands -- they're very easy.
    #
    if ( $command =~ /^Inquire(\w+?Names)$/ ) {
	$key = $1;
	$key = 'QNames' if $key eq 'QueueNames';
	# beware -- the command may have worked, but there may be no
	# names, in which case, $names will be undef.
	my $names = $self->{Response}->[0]->Parameters($key);
	if ( ref $names eq 'ARRAY' ) {
	    return @$names;
	} else {
	    return;
	}
    }
    #
    # Next handle anything which returns a list of parameters
    #
    elsif ( $command =~ /^(Inquire|ResetQueue|Escape)/ ) {
	my @parameters = $self->DataParameters();
	if ( wantarray ) {
	    return @parameters;
	} else {
	    return $parameters[0];
	}
    }
    #
    # Handle the "partial completion" reason codes returned by MQSC
    # for some commands.  This just means the command is asynchronous,
    # and will be completed "later".  Eg: StopChannel will stop the
    # channel, but you really need to poll the status with
    # InquireChannelStatus to figure out *when* it has stopped.  Yeah,
    # that sucks...
    #
    elsif ( $command =~ /^(Start|Stop)Channel$/ ) {
	if (
	    $self->{"CompCode"} ||
	    ( $self->{"Reason"} != 0 && $self->{"Reason"} != 4 )
	   ) {
	    $self->{Carp}->(qq/Command '$command' failed (Reason = $self->{"Reason"})/);
	    return;
	} else {
	    return 1;
	}
    }
    #
    # Finally the simple worked or failed commands
    #
    else {
	if ( $self->{"CompCode"} || $self->{"Reason"} ) {
	    $self->{Carp}->(qq/Command '$command' failed (Reason = $self->{"Reason"})/);
	    return;
	} else {
	    return 1;
	}
    }

}

sub Responses {
    my $self = shift;
    if ( ref $self->{"Response"} eq "ARRAY" ) {
	return @{$self->{"Response"}};
    } else {
	return;
    }
}

1;

__END__

=head1 NAME

MQSeries::Command - OO interface to the Programmable Commands

=head1 SYNOPSIS

  use MQSeries;
  use MQSeries::Command;

  #
  # Simplest usage
  #
  my $command = MQSeries::Command->new
    (
     QueueManager => 'some.queue.manager',
    )
    or die("Unable to instantiate command object\n");

  @qnames = $command->InquireQueueNames()
    or die "Unable to list queue names\n";

  foreach my $qname ( @qnames ) {

      $attr = $command->InquireQueue
	(
	 QName		=> $qname,
	 QAttrs		=> [qw(
			       OpenInputCount
			       OpenOutputCount
			       CurrentQDepth
			      )],
	) or die "InquireQueue: " . MQReasonToText($command->Reason()) . "\n";

      print "QName = $qname\n";

      foreach my $key ( sort keys %$attr ) {
	  print "\t$key => $attr->{$key}\n";
      }

  }

  #
  # High-level wrapper method: CreateObject
  #
  $command->CreateObject
    (
     Attrs		=>
     {
      QName		=> 'FOO.BAR.REQUEST',
      QType		=> 'Local',
      MaxQDepth		=> '50000',
      MaxMsgLength	=> '20000',
     }
    ) || die "CreateObject: " . MQReasonToText($command->Reason()) . "\n";

  $command->CreateObject
    (
     Clear		=> 1,
     Attrs		=>
     {
      QName		=> 'FOO.BAR.REPLY',
      QType		=> 'Remote',
      RemoteQName	=> 'FOO.BAR.REPLY',
      RemoteQMgrName	=> 'SAT1',
     }
    ) || die "CreateObject: " . MQReasonToText($command->Reason()) . "\n";

=head1 DESCRIPTION

The MQSeries::Command class implements an interface to the
Programmable Command Format messages documented in the:

  "MQSeries Programmable System Management"

section of the MQSeries documentation.  In particular, this document
will primarily explain how to interpret the above documentation, and
thus use this particular implementation in perl.  Please read and
understand the following sections of the above document:

  Part 2. Programmable Command Formats
    Chapter 8. Definitions of the Programmable Command Formats
    Chapter 9. Structures used for commands and responses

This interface also supports the text-based MQSC format messages used
by the queue manager of some platforms, particularly MVS.  Using the
same interface, either PCF or MQSC command server can be queried, with
the results translated into the same format for responses as well.
Note that there are limits to how transparent this is (see MQSC
NOTES), but the code tries quite hard to hide as many of the
differences as possible.

=head2 COMMAND ARGUMENTS

Before we discuss the specific arguments and return values of each of
the methods supported by the MQSeries::Command module, we must explain
how the keys and values used by the interface were chosen, as this
will allow the developer to understand how to take advantage of the
very complete documentation provided by IBM (which will B<not> be
reproduced here).

For each command documented in 'Definitions of the Programmable
Command Formats' (there is a specific page listing all of the
commands, grouped by type), there is a corresponding method in this
class.  For example, there is a method named 'InquireQueueManager',
for the obvious (I hope) PCF command.

All of these methods take a hash of key/value pairs as an argument,
with the keys being those defined in the documentation for each
command.  When writing C code to produce PCF messages, the parameter
names are macros, such as:

  MQIACF_Q_MGR_ATTRS

to specify a list of queue manager attributes.  Rather than use these
names directly, the key strings are taken from the IBM documentation.
In this example, the string used for this key is:

  QMgrAttrs

The values depend on the structure type of the parameter.  If the
structure is a string (MQCFST) or an integer (MQCFIN) then the value
of the key is simply a scalar string or integer in perl.  If it either
a string list (MQCFSL) or an integer list (MQCFIL), then the value of
the key is an array reference (see the InquireQueueManager example in
the SYNOPSIS) of scalar strings or integers.

=head2 RETURN VALUES

Most of the individual methods map to underlying commands which do not
return any data.  For all of these, the return value is simply
Boolean; true or false.  That is, the command either worked or failed.

Only the methods associated with those commands documented as
producing data responses:

  Escape
  Inquire Channel
  Inquire Channel Names
  Inquire Channel Status
  Inquire Cluster Queue Manager
  Inquire Namelist
  Inquire Namelist Names
  Inquire Process
  Inquire Process Names
  Inquire Queue
  Inquire Queue Manager
  Inquire Queue Names
  Reset Queue Statistics

return interesting information.  Most of these will return an array of
hash references, one for each object matching the query criteria.  For
example.  The specific keys are documented in the section of the IBM
documentation which discusses the "Data responses to commands", on the
summary page "PCF commands and responses in groups".  If you have read
the IBM documentation as requested above, you should have found this
page.

Note that in an array context, the entire list is returned, but in a
scalar context, only the first item in the list is returned.

Four of these commands, however, have a simplified return value.  All
four of:

  Inquire Channel Names
  Inquire Namelist Names
  Inquire Process Names
  Inquire Queue Names

simply return an array of strings, containing the names which matched
the query criteria.

=head1 METHODS

=head2 new

The arguments to the constructor are a hash, with the following
key/value pairs:

  Key                Value
  ===                =====
  QueueManager       String or MQSeries::QueueManager object
  ProxyQueueManager  String or MQSeries::QueueManager object
  ReplyToQ           String or MQSeries::Queue object
  CommandQueueName   String
  DynamicQName       String
  ModelQName	     String
  Type               String ("PCF" or "MQCS")
  Expiry	     Numeric
  Wait               Numeric
  ReplyToQMgr        String
  Carp               CODE Reference
  StrictMapping      Boolean	
  CompCode           Reference to Scalar Variable
  Reason             Reference to Scalar Variable

=over 4

=item QueueManager

The name of the QueueManager (or alternatively, a previously
instantiated MQSeries::QueueManager object) to which commands are to
be sent.

This can be omitted, in which case the "default queue manager" is
therefore assumed.

=item ProxyQueueManager

The name of the queue manager to which to MQCONN(), and submit
messages on the QueueManagers behalf.  This is to be used if a direct
connection to the QueueManager is not possible, for example MVS queue
managers with support for direct client access.

The messages will be put to what is assumed to be a remote queue
definition which routes to the command queue on the desired
QueueManager.

In order to specify the "default" queue manager as the
ProxyQueueManager, an empty string must be explicitly given.

=item ReplyToQ

The ReplyToQ can be opened by the application, and the MQSeries::Queue
object passed in to the MQSeries::Command constructor, if so desired,
os, a fixed queue name can be given.  This is a somewhat advanced
usage of the API, since the default behavior of opening a temporary
dynamic queue under the covers is usually prefered, and much simpler.

The responses are retreived from the reply queue using gets by
CorrelId, so there should be no issue with using a pre-defined, shared
queue for this, if so desired.

=item CommandQueueName

This specifies the queue to which the command messages will be put.
The defaults are usually reasonable, and depend on the command message
Type (PCF or MQSC).

  PCF   => SYSTEM.ADMIN.COMMAND.QUEUE
  MQSC  => SYSTEM.COMMAND.INPUT

If the ProxyQueueManager has been specified, then we assume the
messages are being written to a remote queue definition, and the
defaults are then:

  PCF   => SYSTEM.ADMIN.COMMAND.QUEUE."QueueManager"
  MQSC  => SYSTEM.COMMAND.INPUT."QueueManager"

See "MQSC NOTES" for some examples of how to use this in practice.

=item Type

This argument indicates whether the command server on the QueueManager
supports either PCF or MQSC messages.  The default is PCF.  See the
section "MQSC NOTES" for the Ugly Truth about the MQSC support.

=item Expiry

This value is used as the MQMD.Expiry field on all requests sent to
the command server.  The value is passed to the MQSeries::Message
constructor, and should specify the time in B<tenths of a second>.
The default is 600, or 60 seconds.  

A symbolic value ending on 's' for seconds or 'm' for minutes may
also be specified, e.g. the symbolic value '45s' will have the same
meaning as the number 450.

=item Wait

This value is used as the Wait argument to the MQSeries::Queue->Get()
method call made against the ReplyToQ (a dynamic reply queue). and
should be a time specified in B<milliseconds>.  The default is 60000,
or 60 seconds.

A symbolic value ending on 's' for seconds or 'm' for minutes may
also be specified, e.g. the symbolic value '45s' will have the same
meaning as the number 45000.

NOTE: Both the Expiry and Wait defaults may be too slow for heavily
loaded queue managers.  Tune them appropriately.

=item ReplyToQMgr

The ReplyToQMgr normally defaults to the QueueManager, but it can be
overridden, perhaps as a means of specifying an alternate return path
over a specific channel.  For example, the author uses special
channels for SYSTEM related traffic, over which we forward MQSeries
events from one queue manager to another, and also over which we wish
the command server queries to flow.

The "default" path between QMA and QMB flows over a channel called
QMA.QMB, but this traffic is application data, not administrative
system data.  The system queries flow over QMA.QMB.SYSTEM, and we need
to ensure that replies to queries follow a similar reverse path.
Specifying the ReplyToQMgr as "QMB.SYSTEM" accomplishes this.

=item Carp

This key specifies a code reference to a routine to replace all of the
carp() calls in the API, allowing the user of the API to trap and
handle all of the error message generated internally, or simply
redirect how they get logged.

For example, one might want everything to be logged via syslog:

  sub MyLogger {
      my $message = @_;
      foreach my $line ( split(/\n+/,$message) ) {
          syslog("err",$message);
      }
  }

Then, one tells the object to use this routine:

  my $command = MQSeries::Command->new(
				       QueueManager => 'some.queue.manager',
				       Carp => \&MyLogger,
				      )
      or die("Unable to connect to queue manager.\n");

The default, as one might guess, is Carp::carp();

=item StrictMapping

If this argument has a true value, then strict mapping of PCF
parameters and values will be enforced.  Normally, if you feed a bogus
string into the API, it will attempt to map it to the underlying PCF
macro value, and if the mapping fails, it will quietly forgive you,
and ignore the parameter.  Enabling this feature will cause the
translation of an encoded PCF message into the data structure for a
Response, or the translation of a Request into an encoded PCF message,
to fail if any of the mappings fail.

Usually, the command server will generate errors if you feed bogus
data into the API. but that will only occur after the data has been
encoded and sent to the command server.  This feature will allow you
to detect this error before the data is ever sent.

=item CompCode

Normally the CompCode and Reason are access via the methods of the
same name.  However, that obviously is not possible if the constructor
fails.  If you want to perform special handling of the error codes in
this case, you will have tell the constructor where to write the
CompCode and Reason, by providing a SCALAR reference.

For example:

  my $CompCode = MQCC_FAILED;
  my $Reason   = MQRC_NONE;

  my $command = MQSeries::Command->new
    (
     QueueManager => 'some.queue.manager',
     CompCode     => \$CompCode,
     Reason       => \$Reason,
    );

Now, the CompCode and Reason are available, even if the constructor
fails, in which case it would normally return nothing.

=item Reason

See CompCode above.

=back

=head2 CompCode

This method will return the MQI CompCode for the most recent MQI call
made by the API.

=head2 Reason

This method will return the MQI Reason for the most recent MQI call
made by the API.

=head2 Responses

Normally, the data of interest is returned from the method in
question, but the individual responses are available via this method.
This returns a list of MQSeries::Command::Response objects, one for
each individual message recieved.

NOTE: In previous releases, this method was named "Response", but due
to a namespace conflict between the class
"MQSeries::Command::Response", and the method
"MQSeries::Command->Response", and the headaches this causes, it has
been renamed.

=head2 DataParameters

This method will return a list of parameters structures from all of
the responses messages sent back which were B<not> error responses.
Some errors will send back responses with parameters, and these could
easily be confused with real data (until you start looking at the
actual data, of course).

=head2 ErrorParameters

This method will return a list of parameters structures from all of
the responses messages sent back which B<were> error responses.  If a
command fails, the Reason() will usually tell you enough about the
cause of the failure, but if the reason is MQRCCF_CFIN_PARM_ID_ERROR,
then the parameters in the error message will indicate which Parameter
key was invalid.

=head2 CreateObject

This is a generic "wrapper" method for creating any generic MQSeries
object.  The arguments to this method are a hash, with the following
key/value pairs:

  Key                Value
  ===                =====
  Attrs		     HASH reference
  Verify	     Boolean
  Clear              Boolean
  Quiet              Boolean

The key/value pairs in the Attrs argument are passed directly to the
corresponding CreateQueue(), CreateChannel(), or CreateProcess()
method.  However, there is more to this than just creating the object.
For clarity, this discussion will use creation of a queue as an
example.

First, InquireQueue is called to see if the object already exists.  If
it does not exist, then the object is simply created, with the
specified attributes.

If it does exist, and the QType matches, then the actual object
attributes are compared against those passed to the CreateObject
method, and if they match, then no action is taken, and the object is
not modified.

If it does exist, but of a different QType, then the existing object
is deleted, and the new object created as requested.

The idea here is to match the modification of the object conditional
on the need for modifying the object.  If the same CreateObject method
call, with the same arguments, is called twice, then the second method
invocation should be a noop, as far as the actual MQSeries object is
concerned.

=over

=item Attrs

As discussed above, this is a HASH reference, whose key/value pairs
are used to determine what type of object is being created or updated,
and those key/value pairs are passed as-is to the appropriate Create*
method call for the specified MQSeries object type.

=item Verify

If this key has a true value, then no changes will actually be
implemented.  They will merely be reported via test messages on
stdout.

=item Quiet

CreateObject is by default rather chatty about what it is doing, but
all of the messages, other than errors, can be suppressed if this key
has a true value.

=item Clear

Normally, when a Local queue is being replaced with another QType
(eg. Remote or Alias), then the Local queue is not cleared before
being deleted.  If there are messages on the queue, this will cause an
error.  If the queue needs to be cleared, then this key must be passed
with a true value.

This is a seperate option due to the inherit danger of destroying data
accidentally.  If you really want to clear the queues before
recreating them as another QType, you will have to be explicitl about
it.

=back

=head1 COMMAND REQUESTS

This section is B<NOT> intended to replace the IBM "MQSeries
Programmable System Management" documentation, and it merely serves to
document the specific keys and values used by the perl implementation
of the API.

In all cases, the keys which can be passed to the command are
identical to the strings found in the documentation.  However, some of
the values also have more convenient string mapping as well, as these
are not easily intuited by reading IBMs docs, thus these are clarified
here.

The IBM docs list the possible values for each key as a list of
MQSeries C macros (eg. MQCHT_SENDER), and if given, these will be
respected.  It will be faster to use the strings given, since these
map directly to the actual macro values via a hash lookup, rather than
a function call (all of the various C macros are implemented as
function calls via an AUTOLOAD).  Also, the author finds the
replacement strings far more readable.  YMMV.

For each key shown, the format of value is one of the following:

=over 4

=item (string)

The value given must be a scalar value, interpretable as a text
string.

=item (string list)

The value must be an ARRAY reference of scalar values, all of which
must be interpretable as strings.

NOTE: Some of the parameters (for example, the MsgExit parameter for
the various Channel commands) can take either a string or string list.
In this case, the API will be forgiving, and try to determine what you
meant automatically.  If you pass a reference, it will create a string
list parameter, and if you pass a plain scalar, it will create a
string.

ANOTHER NOTE: if you pass a simple scalar string where a string list
is explicitly required (as opposed to optional), then the API will
create a list of one string for you.

=item (integer)

The value given must be a scalar value, interpretable as an integer.
In some cases, a table will show a mapping from more readable text
strings to the macros documented in the IBM manuals.

=item (integer list)

The value must be an ARRAY reference of scalar values, all of which
must be interpretable as integers.  As with the integer format, in
some cases, a table will show a mapping from more readable text
strings to the macros documented in the IBM manuals.

=item (Boolean)

The value given need only be 0 or 1.  This was done for some of the
integer types which are documented to take a pair of macros, whose
values were simply zero or one, and when the true/false nature of the
key was considered to be intiuitive.  For example, "DataConversion" is
either on (true) or off (false).

=back

In order to reduce needless redundancy, only the keys which have
special value mappings, or which have Boolean values will be listed
here.  For all others, the IBM documentation is sufficient.

=head2 Channel Commands

Subsets of the these keys are applicable to the following commands.
See the documentation for each of the for the specific list.

  Change Channel
  Copy Channel
  Create Channel
  Delete Channel
  Inquire Channel
  Inquire Channel Names
  Inquire Channel Status
  Ping Channel
  Reset Channel
  Resolve Channel
  Start Channel
  Start Channel Initiator
  Start Channel Listener
  Stop Channel

The following keys have special value mappings:

=over 4

=item ChannelType 		(integer)

    Key				Macro
    ===				=====
    Clntconn                    MQCHT_CLNTCONN
    ClusterReceiver             MQCHT_CLUSRCVR
    ClusterSender               MQCHT_CLUSSDR
    Receiver                    MQCHT_RECEIVER
    Requester                   MQCHT_REQUESTER
    Sender                      MQCHT_SENDER
    Server                      MQCHT_SERVER
    Svrconn                     MQCHT_SVRCONN

=item TransportType		(integer)

    Key				Macro
    ===				=====
    DECnet                      MQXPT_DECNET
    LU62                        MQXPT_LU62
    NetBIOS                     MQXPT_NETBIOS
    SPX                         MQXPT_SPX
    TCP                         MQXPT_TCP
    UDP                         MQXPT_UDP

=item PutAuthority 		(integer)

    Key				Macro
    ===				=====
    Context                     MQPA_CONTEXT
    Default                     MQPA_DEFAULT

=item MCAType 			(integer)

    Key				Macro
    ===				=====
    Process                     MQMCAT_PROCESS
    Thread                      MQMCAT_THREAD

=item NonPersistentMsgSpeed	(integer)

    Key				Macro
    ===				=====
    Normal                      MQNPMS_NORMAL
    Fast                        MQNPMS_FAST

=item ChannelTable		(integer)

    Key				Macro
    ===				=====
    Clntconn                    MQCHTAB_CLNTCONN
    QMgr                        MQCHTAB_Q_MGR

=item ChannelInstanceAttrs	(integer list)

Same as ChannelAttrs:

=item ChannelAttrs		(integer list)

    Key				Macro
    ===				=====
    All                         MQIACF_ALL
    AlterationDate              MQCA_ALTERATION_DATE
    AlterationTime              MQCA_ALTERATION_TIME
    BatchInterval               MQIACH_BATCH_INTERVAL
    BatchSize                   MQIACH_BATCH_SIZE
    Batches                     MQIACH_BATCHES
    BuffersReceived             MQIACH_BUFFERS_RCVD
    BuffersSent                 MQIACH_BUFFERS_SENT
    BytesReceived               MQIACH_BYTES_RCVD
    BytesSent                   MQIACH_BYTES_SENT
    ChannelDesc                 MQCACH_DESC
    ChannelInstanceType         MQIACH_CHANNEL_INSTANCE_TYPE
    ChannelName                 MQCACH_CHANNEL_NAME
    ChannelNames                MQCACH_CHANNEL_NAMES
    ChannelStartDate            MQCACH_CHANNEL_START_DATE
    ChannelStartTime            MQCACH_CHANNEL_START_TIME
    ChannelStatus               MQIACH_CHANNEL_STATUS
    ChannelType                 MQIACH_CHANNEL_TYPE
    ClusterName                 MQCA_CLUSTER_NAME
    ClusterNamelist             MQCA_CLUSTER_NAMELIST
    ConnectionName              MQCACH_CONNECTION_NAME
    CurrentLUWID                MQCACH_CURRENT_LUWID
    CurrentMsgs                 MQIACH_CURRENT_MSGS
    CurrentSequenceNumber       MQIACH_CURRENT_SEQ_NUMBER
    DataConversion              MQIACH_DATA_CONVERSION
    DiscInterval                MQIACH_DISC_INTERVAL
    HeartbeatInterval           MQIACH_HB_INTERVAL
    InDoubtStatus               MQIACH_INDOUBT_STATUS
    LastLUWID                   MQCACH_LAST_LUWID
    LastMsgDate                 MQCACH_LAST_MSG_DATE
    LastMsgTime                 MQCACH_LAST_MSG_TIME
    LastSequenceNumber          MQIACH_LAST_SEQ_NUMBER
    LongRetriesLeft             MQIACH_LONG_RETRIES_LEFT
    LongRetryCount              MQIACH_LONG_RETRY
    LongRetryInterval           MQIACH_LONG_TIMER
    MCAJobName                  MQCACH_MCA_JOB_NAME
    MCAName                     MQCACH_MCA_NAME
    MCAStatus                   MQIACH_MCA_STATUS
    MCAType                     MQIACH_MCA_TYPE
    MCAUserIdentifier           MQCACH_MCA_USER_ID
    MaxMsgLength                MQIACH_MAX_MSG_LENGTH
    ModeName                    MQCACH_MODE_NAME
    MsgExit                     MQCACH_MSG_EXIT_NAME
    MsgRetryCount               MQIACH_MR_COUNT
    MsgRetryExit                MQCACH_MR_EXIT_NAME
    MsgRetryInterval            MQIACH_MR_INTERVAL
    MsgRetryUserData            MQCACH_MR_EXIT_USER_DATA
    MsgUserData                 MQCACH_MSG_EXIT_USER_DATA
    Msgs                        MQIACH_MSGS
    NetworkPriority             MQIACH_NETWORK_PRIORITY
    NonPersistentMsgSpeed       MQIACH_NPM_SPEED
    Password                    MQCACH_PASSWORD
    PutAuthority                MQIACH_PUT_AUTHORITY
    QMgrName                    MQCA_Q_MGR_NAME
    ReceiveExit                 MQCACH_RCV_EXIT_NAME
    ReceiveUserData             MQCACH_RCV_EXIT_USER_DATA
    SecurityExit                MQCACH_SEC_EXIT_NAME
    SecurityUserData            MQCACH_SEC_EXIT_USER_DATA
    SendExit                    MQCACH_SEND_EXIT_NAME
    SendUserData                MQCACH_SEND_EXIT_USER_DATA
    SeqNumberWrap               MQIACH_SEQUENCE_NUMBER_WRAP
    ShortRetriesLeft            MQIACH_SHORT_RETRIES_LEFT
    ShortRetryCount             MQIACH_SHORT_RETRY
    ShortRetryInterval          MQIACH_SHORT_TIMER
    StopRequested               MQIACH_STOP_REQUESTED
    TpName                      MQCACH_TP_NAME
    TransportType               MQIACH_XMIT_PROTOCOL_TYPE
    UserIdentifier              MQCACH_USER_ID
    XmitQName                   MQCACH_XMIT_Q_NAME

=item ChannelInstanceType  	(integer)

    Key				Macro
    ===				=====
    Current                     MQOT_CURRENT_CHANNEL
    Saved                       MQOT_SAVED_CHANNEL

=item InDoubt			(integer)

    Key				Macro
    ===				=====
    Backout                     MQIDO_BACKOUT
    Commit                      MQIDO_COMMIT

=back

The following keys have Boolean values:

=over 4

=item Replace

=item DataConversion

=item Quiesce

=back

=head2 Namelist Commands

Subsets of the these keys are applicable to the following commands.
See the documentation for each of the for the specific list.

  Change Namelist
  Copy Namelist
  Create Namelist
  Delete Namelist
  Inquire Namelist
  Inquire Namelist Names

The following keys have special value mappings:

=over 4

=item NamelistAttrs		(integer list)

    Key				Macro
    ===				=====
    AlterationDate              MQCA_ALTERATION_DATE
    AlterationTime              MQCA_ALTERATION_TIME
    NamelistDesc                MQCA_NAMELIST_DESC
    NamelistName                MQCA_NAMELIST_NAME
    Names                       MQCA_NAMES

=back

The following keys have Boolean values:

=over 4

=item Replace

=back

=head2 Process Commands

Subsets of the these keys are applicable to the following commands.
See the documentation for each of the for the specific list.

  Change Process
  Copy Process
  Create Process
  Delete Process
  Inquire Process
  Inquire ProcessNames

The following keys have special value mappings:

=over 4

=item ApplType    		(integer)

    Key				Macro
    ===				=====
    AIX                         MQAT_AIX
    CICS                        MQAT_CICS
    DOS                         MQAT_DOS
    Default                     MQAT_UNIX
    IMS                         MQAT_IMS
    MVS                         MQAT_MVS
    NSK                         MQAT_NSK
    OS2                         MQAT_OS2
    OS400                       MQAT_OS400
    UNIX                        MQAT_UNIX
    VMS                         MQAT_VMS
    Win16                       MQAT_WINDOWS
    Win32                       MQAT_WINDOWS_NT

=item ProcessAttrs		(interger list)

    Key				Macro
    ===				=====
    All                         MQIACF_ALL
    AlterationDate              MQCA_ALTERATION_DATE
    AlterationTime              MQCA_ALTERATION_TIME
    ApplId                      MQCA_APPL_ID
    ApplType                    MQIA_APPL_TYPE
    EnvData                     MQCA_ENV_DATA
    ProcessDesc                 MQCA_PROCESS_DESC
    ProcessName                 MQCA_PROCESS_NAME
    ProcessNames                MQCACF_PROCESS_NAMES
    UserData                    MQCA_USER_DATA

=back

The following keys have Boolean values:

=over 4

=item Replace

=back

=head2 Queue Commands

Subsets of the these keys are applicable to the following commands.
See the documentation for each of the for the specific list.

  Change Queue
  Clear Queue
  Copy Queue
  Create Queue
  Delete Queue
  Inquire Queue
  Inquire Queue Names
  Reset Queue Statistics

The following keys have special value mappings:

=over 4

=item DefBind  			(integer)

    Key				Macro
    ===				=====
    OnOpen                      MQBND_BIND_ON_OPEN
    NotFixed                    MQBND_BIND_NOT_FIXED

=item DefinitionType		(integer)

    Key				Macro
    ===				=====
    Permanent                   MQQDT_PERMANENT_DYNAMIC
    Temporary                   MQQDT_TEMPORARY_DYNAMIC

=item DefInputOpenOption    	(integer)

    Key				Macro
    ===				=====
    Exclusive                   MQOO_INPUT_EXCLUSIVE
    Shared                      MQOO_INPUT_SHARED

=item MsgDeliverySequence    	(integer)

    Key				Macro
    ===				=====
    FIFO                        MQMDS_FIFO
    Priority                    MQMDS_PRIORITY

=item QAttrs			(integer list)

    Key				Macro
    ===				=====
    All                         MQIACF_ALL
    AlterationDate              MQCA_ALTERATION_DATE
    AlterationTime              MQCA_ALTERATION_TIME
    BackoutRequeueName          MQCA_BACKOUT_REQ_Q_NAME
    BackoutThreshold            MQIA_BACKOUT_THRESHOLD
    BaseQName                   MQCA_BASE_Q_NAME
    ClusterDate                 MQCA_CLUSTER_DATE
    ClusterName                 MQCA_CLUSTER_NAME
    ClusterNamelist             MQCA_CLUSTER_NAMELIST
    ClusterQType                MQIA_CLUSTER_Q_TYPE
    ClusterTime                 MQCA_CLUSTER_TIME
    CreationDate                MQCA_CREATION_DATE
    CreationTime                MQCA_CREATION_TIME
    CurrentQDepth               MQIA_CURRENT_Q_DEPTH
    DefBind                     MQIA_DEF_BIND
    DefInputOpenOption          MQIA_DEF_INPUT_OPEN_OPTION
    DefPersistence              MQIA_DEF_PERSISTENCE
    DefPriority                 MQIA_DEF_PRIORITY
    DefinitionType              MQIA_DEFINITION_TYPE
    DistLists                   MQIA_DIST_LISTS
    HardenGetBackout            MQIA_HARDEN_GET_BACKOUT
    HighQDepth                  MQIA_HIGH_Q_DEPTH
    InhibitGet                  MQIA_INHIBIT_GET
    InhibitPut                  MQIA_INHIBIT_PUT
    InitiationQName             MQCA_INITIATION_Q_NAME
    MaxMsgLength                MQIA_MAX_MSG_LENGTH
    MaxQDepth                   MQIA_MAX_Q_DEPTH
    MsgDeliverySequence         MQIA_MSG_DELIVERY_SEQUENCE
    MsgDeqCount                 MQIA_MSG_DEQ_COUNT
    MsgEnqCount                 MQIA_MSG_ENQ_COUNT
    OpenInputCount              MQIA_OPEN_INPUT_COUNT
    OpenOutputCount             MQIA_OPEN_OUTPUT_COUNT
    ProcessName                 MQCA_PROCESS_NAME
    QDepthHighEvent             MQIA_Q_DEPTH_HIGH_EVENT
    QDepthHighLimit             MQIA_Q_DEPTH_HIGH_LIMIT
    QDepthLowEvent              MQIA_Q_DEPTH_LOW_EVENT
    QDepthLowLimit              MQIA_Q_DEPTH_LOW_LIMIT
    QDepthMaxEvent              MQIA_Q_DEPTH_MAX_EVENT
    QDesc                       MQCA_Q_DESC
    QMgrIdentifier              MQCA_Q_MGR_IDENTIFIER
    QMgrName                    MQCA_CLUSTER_Q_MGR_NAME
    QName                       MQCA_Q_NAME
    QNames                      MQCACF_Q_NAMES
    QServiceInterval            MQIA_Q_SERVICE_INTERVAL
    QServiceIntervalEvent       MQIA_Q_SERVICE_INTERVAL_EVENT
    QType                       MQIA_Q_TYPE
    RemoteQMgrName              MQCA_REMOTE_Q_MGR_NAME
    RemoteQName                 MQCA_REMOTE_Q_NAME
    RetentionInterval           MQIA_RETENTION_INTERVAL
    Scope                       MQIA_SCOPE
    Shareability                MQIA_SHAREABILITY
    TimeSinceReset              MQIA_TIME_SINCE_RESET
    TriggerControl              MQIA_TRIGGER_CONTROL
    TriggerData                 MQCA_TRIGGER_DATA
    TriggerDepth                MQIA_TRIGGER_DEPTH
    TriggerMsgPriority          MQIA_TRIGGER_MSG_PRIORITY
    TriggerType                 MQIA_TRIGGER_TYPE
    Usage                       MQIA_USAGE
    XmitQName                   MQCA_XMIT_Q_NAME

=item QServiceIntervalEvent    	(integer)

    Key				Macro
    ===				=====
    High                        MQQSIE_HIGH
    None                        MQQSIE_NONE
    OK                          MQQSIE_OK

=item QType    			(integer)

    Key				Macro
    ===				=====
    Alias                       MQQT_ALIAS
    All                         MQQT_ALL
    Cluster                     MQQT_CLUSTER
    Local                       MQQT_LOCAL
    Model                       MQQT_MODEL
    Remote                      MQQT_REMOTE

=item Scope    			(integer)

    Key				Macro
    ===				=====
    Cell                        MQSCO_CELL
    QMgr                        MQSCO_Q_MGR

=item TriggerType    		(integer)

    Key				Macro
    ===				=====
    Depth                       MQTT_DEPTH
    Every                       MQTT_EVERY
    First                       MQTT_FIRST
    None                        MQTT_NONE

=item Usage    			(integer)

    Key				Macro
    ===				=====
    Normal                      MQUS_NORMAL
    XMITQ                       MQUS_TRANSMISSION

=back

The following keys have Boolean values:

=over 4

=item Replace

=item Force

=item InhibitPut

=item DefPersistence

=item InhibitGet

=item Shareability

=item HardenGetBackout

=item DistLists

=item TriggerControl

=item QDepthMaxEvent

=item QDepthHighEvent

=item QDepthLowEvent

=item Purge

=back

=head2 Queue Manager Commands

Subsets of the these keys are applicable to the following commands.
See the documentation for each of the for the specific list.

  Change Queue Manager
  Inquire Queue Manager
  Ping Queue Manager

The following keys have special value mappings:

=over 4

=item QMgrAttrs			(integer list)

    Key				Macro
    ===				=====
    All                         MQIACF_ALL
    AlterationDate              MQCA_ALTERATION_DATE
    AlterationTime              MQCA_ALTERATION_TIME
    AuthorityEvent              MQIA_AUTHORITY_EVENT
    ChannelAutoDef              MQIA_CHANNEL_AUTO_DEF
    ChannelAutoDefEvent         MQIA_CHANNEL_AUTO_DEF_EVENT
    ChannelAutoDefExit          MQCA_CHANNEL_AUTO_DEF_EXIT
    ClusterWorkLoadData         MQCA_CLUSTER_WORKLOAD_DATA
    ClusterWorkLoadExit         MQCA_CLUSTER_WORKLOAD_EXIT
    ClusterWorkLoadLength       MQIA_CLUSTER_WORKLOAD_LENGTH
    CodedCharSetId              MQIA_CODED_CHAR_SET_ID
    CommandInputQName           MQCA_COMMAND_INPUT_Q_NAME
    CommandLevel                MQIA_COMMAND_LEVEL
    DeadLetterQName             MQCA_DEAD_LETTER_Q_NAME
    DefXmitQName                MQCA_DEF_XMIT_Q_NAME
    DistLists                   MQIA_DIST_LISTS
    InhibitEvent                MQIA_INHIBIT_EVENT
    LocalEvent                  MQIA_LOCAL_EVENT
    MaxHandles                  MQIA_MAX_HANDLES
    MaxMsgLength                MQIA_MAX_MSG_LENGTH
    MaxPriority                 MQIA_MAX_PRIORITY
    MaxUncommittedMsgs          MQIA_MAX_UNCOMMITTED_MSGS
    PerformanceEvent            MQIA_PERFORMANCE_EVENT
    Platform                    MQIA_PLATFORM
    QMgrDesc                    MQCA_Q_MGR_DESC
    QMgrIdentifier              MQCA_Q_MGR_IDENTIFIER
    QMgrName                    MQCA_Q_MGR_NAME
    RemoteEvent                 MQIA_REMOTE_EVENT
    RepositoryName              MQCA_REPOSITORY_NAME
    RepositoryNamelist          MQCA_REPOSITORY_NAMELIST
    StartStopEvent              MQIA_START_STOP_EVENT
    SyncPoint                   MQIA_SYNCPOINT
    TriggerInterval             MQIA_TRIGGER_INTERVAL

=back

The following keys have Boolean values:

=over 4

=item Force

=item AuthorityEvent

=item InhibitEvent

=item LocalEvent

=item RemoteEvent

=item StartStopEvent

=item PerformanceEvent

=item ChannelAutoDef

=item ChannelAutoDefEvent

=back

=head2 Cluster Commands

Subsets of the these keys are applicable to the following commands.
See the documentation for each of the for the specific list.

  Inquire Cluster Queue Manager
  Refresh Cluster
  Reset Cluster
  Resume Queue Manager Cluster
  Suspend Queue Manager Cluster

The following keys have special value mappings:

=over 4

=item ClusterQMgrAttrs		(integer list)

    Key				Macro
    ===				=====
    AlterationDate              MQCA_ALTERATION_DATE
    AlterationTime              MQCA_ALTERATION_TIME
    BatchInterval               MQIACH_BATCH_INTERVAL
    BatchSize                   MQIACH_BATCH_SIZE
    ChannelStatus               MQIACH_CHANNEL_STATUS
    ClusterDate                 MQCA_CLUSTER_DATE
    ClusterName                 MQCA_CLUSTER_NAME
    ClusterTime                 MQCA_CLUSTER_TIME
    ConnectionName              MQCACH_CONNECTION_NAME
    DataConversion              MQIACH_DATA_CONVERSION
    Description                 MQCACH_DESC
    DiscInterval                MQIACH_DISC_INTERVAL
    HeartbeatInterval           MQIACH_HB_INTERVAL
    LongRetryCount              MQIACH_LONG_RETRY
    LongRetryInterval           MQIACH_LONG_TIMER
    MCAName                     MQCACH_MCA_NAME
    MCAType                     MQIACH_MCA_TYPE
    MCAUserIdentifier           MQCACH_MCA_USER_ID
    MaxMsgLength                MQIACH_MAX_MSG_LENGTH
    ModeName                    MQCACH_MODE_NAME
    MsgExit                     MQCACH_MSG_EXIT_NAME
    MsgRetryCount               MQIACH_MR_COUNT
    MsgRetryExit                MQCACH_MR_EXIT_NAME
    MsgRetryInterval            MQIACH_MR_INTERVAL
    MsgRetryUserData            MQCACH_MR_EXIT_USER_DATA
    MsgUserData                 MQCACH_MSG_EXIT_USER_DATA
    NetworkPriority             MQIACH_NETWORK_PRIORITY
    NonPersistentMsgSpeed       MQIACH_NPM_SPEED
    Password                    MQCACH_PASSWORD
    PutAuthority                MQIACH_PUT_AUTHORITY
    QMgrDefinitionType          MQIACF_Q_MGR_DEFINITION_TYPE
    QMgrIdentifier              MQCA_Q_MGR_IDENTIFIER
    QMgrType                    MQIACF_Q_MGR_TYPE
    ReceiveExit                 MQCACH_RCV_EXIT_NAME
    ReceiveUserData             MQCACH_RCV_EXIT_USER_DATA
    SecurityExit                MQCACH_SEC_EXIT_NAME
    SecurityUserData            MQCACH_SEC_EXIT_USER_DATA
    SendExit                    MQCACH_SEND_EXIT_NAME
    SendUserData                MQCACH_SEND_EXIT_USER_DATA
    SeqNumberWrap               MQIACH_SEQUENCE_NUMBER_WRAP
    ShortRetryCount             MQIACH_SHORT_RETRY
    ShortRetryInterval          MQIACH_SHORT_TIMER
    Suspend                     MQIACF_SUSPEND
    TpName                      MQCACH_TP_NAME
    TransportType               MQIACH_XMIT_PROTOCOL_TYPE
    UserIdentifier              MQCACH_USER_ID
    XmitQName                   MQCACH_XMIT_Q_NAME

=item Action			(integer)

    Key				Macro
    ===				=====
    ForceRemove                 MQACT_FORCE_REMOVE

=back

The following keys have Boolean values:

=over 4

=item Quiesce

=back

=head2 Escape Command

This command is not really part of a grouping, so its all by itself
here.

The following keys have special value mappings:

=over 4

=item EscapeType 		(integer)

    Key				Macro
    ===				=====
    MQSC                        MQET_MQSC

=back

=head1 COMMAND RESPONSES

There are several commands which return data.  The return value of the
actual command methods depends on the specific command.  All of the
"Inquire*Names" commands return a list of the actual names returned,
which greatly simplifies the parsing of the return value.

The commands which return a list of names are:

  Inquire Channel Names
  Inquire Namelist Names
  Inquire Process Names
  Inquire Queue Names

For example:

  @qnames = $command->InquireQueueNames( QName => 'FOO.*' );

will result in @qnames containing a list of strings of all of the
queue names starting with FOO.

The rest of the commands return a list of Parameters HASH references,
extracted from each of the messages sent back from the command server.
In a scalar context, only the first Parameters HASH reference is
returned.  This applies to all of the following commands:

  Escape
  Inquire Channel
  Inquire Channel Status
  Inquire Cluster Queue Manager
  Inquire Namelist
  Inquire Process
  Inquire Queue
  Inquire Queue Manager
  Reset Queue Statistics

For example:

  @queues = $command->InquireQueue( QName => 'FOO.*', QAttrs => 'All' );

will result in @queues containing a list of HASH references, each of
which has key/value pairs for the attributes of one of the queues
starting with FOO.

The keys in the Parameters HASH references are mapped from the numeric
macro values back into the same strings described above for
simplifying the input Parameters.

However, there are a few keys in the responses which are not supported
as keys in the inquiry.  In general, the return values are left
unmolested, with the exception of the keys documented above for each
command type, as well as the following:

=head2 Inquire Channel Status Response

The following keys have special value mappings:

=over 4

=item ChannelStatus			(integer)

    Macro				Key
    =====				===
    MQCHS_BINDING                       Binding
    MQCHS_INACTIVE                      Inactive
    MQCHS_INITIALIZING                  Initializing
    MQCHS_PAUSED                        Paused
    MQCHS_REQUESTING                    Requesting
    MQCHS_RETRYING                      Retrying
    MQCHS_RUNNING                       Running
    MQCHS_STARTING                      Starting
    MQCHS_STOPPED                       Stopped
    MQCHS_STOPPING                      Stopping

=item MCAStatus				(integer)

    Macro				Key
    =====				===
    MQMCAS_RUNNING                      Running
    MQMCAS_STOPPED                      Stopped

=back

The following keys can be interpreted in a Boolean context:

=over 4

=item InDoubtStatus

=item StopRequested

=back

=head2 Inquire Cluster Queue Manager Response

The following keys have special value mappings:

=over 4

=item QMgrDefinitionType 		(integer)

    Macro				Key
    =====				===
    MQQMDT_AUTO_CLUSTER_SENDER          AutoClusterSender
    MQQMDT_AUTO_EXP_CLUSTER_SENDER      AutoExplicitClusterSender
    MQQMDT_CLUSTER_RECEIVER             ClusterReceiver
    MQQMDT_EXPLICIT_CLUSTER_SENDER      ExplicitClusterSender

=item QMgrType				(integer)

    Macro				Key
    =====				===
    MQQMT_NORMAL                        Normal
    MQQMT_REPOSITORY                    Repository

=item ChannelStatus			(integer)

    Macro				Key
    =====				===
    MQCHS_BINDING                       Binding
    MQCHS_INACTIVE                      Inactive
    MQCHS_INITIALIZING                  Initializing
    MQCHS_PAUSED                        Paused
    MQCHS_REQUESTING                    Requesting
    MQCHS_RETRYING                      Retrying
    MQCHS_RUNNING                       Running
    MQCHS_STARTING                      Starting
    MQCHS_STOPPED                       Stopped
    MQCHS_STOPPING                      Stopping

=back

The following keys can be interpreted in a Boolean context:

=over 4

=item Suspend

=back

=head2 Inquire Queue Response

The following keys have special value mappings:

=over 4

=item ClusterQType			(integer)

    Macro				Key
    =====				===
    MQCQT_ALIAS_Q                       Alias
    MQCQT_LOCAL_Q                       Local
    MQCQT_Q_MGR_ALIAS                   QMgrAlias
    MQCQT_REMOTE_Q                      Remote

=back

=head2 Inquire Queue Manager Response

The following keys have special value mappings:

=over 4

=item Platform				(integer)

    Macro				Key
    =====				===
    MQPL_MVS                            MVS
    MQPL_NSK                            NSK
    MQPL_OS2                            OS2
    MQPL_OS400                          OS400
    MQPL_UNIX                           UNIX
    MQPL_WINDOWS                        Win16
    MQPL_WINDOWS_NT                     Win32

=back

The following keys can be interpreted in a Boolean context:

=over 4

=item DistLists

=item SyncPoint

=back

=head1 SEE ALSO

MQSeries(3), MQSeries::Queue(3), MQSeries::Message(3),
  MQSeries::Command::Request(3), MQSeries::Command::Response(3)

In addition, the MQSeries documentation is the primary source of
documentation for the commands and their arguments, especially the
following sections.

  "MQSeries Programmable System Management"
  Part 2. Programmable Command Formats
    Chapter 8. Definitions of the Programmable Command Formats
    Chapter 9. Structures used for commands and responses

=cut
