#
# $Id: Broker.pm,v 9.6 1999/11/10 22:18:40 wpm Exp $
#
# (c) 1999 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#

package MQSeries::PubSub::Broker;

use strict;
use Carp;
use English;

use MQSeries;
use MQSeries::QueueManager;
use MQSeries::Queue;
use MQSeries::PubSub::Command;

use vars qw( @ISA $VERSION );

@ISA = qw( MQSeries::PubSub::Command MQSeries::QueueManager );

$VERSION = '1.06';

#
# All 5 of these PubSub commands must be sent to the Broker.
#
sub RegisterPublisher {
    my $self = shift;
    $self->_Command("RegPub",@_);
}

sub RegisterSubscriber {
    my $self = shift;
    $self->_Command("RegSub",@_);
}

sub DeregisterPublisher {
    my $self = shift;
    $self->_Command("DeregPub",@_);
}

sub DeregisterSubscriber {
    my $self = shift;
    $self->_Command("DeregSub",@_);
}

sub RequestUpdate {
    my $self = shift;
    $self->_Command("ReqUpdate",@_);
}

#
# Extended commands. 
#

#
# Simple utility function to pad the queue manager names with spaces.
# Actually, it pretends to be generic, but in practice, only the
# QMgrName needs to be padded like this.
#
sub _BlankPadName {
    my $self = shift;
    my ($string,$length) = @_;
    if ( length($string) < $length ) {
	$string .= ' ' x ( $length - length($string) );
    }
    return $string;
}

#
# All 3 of these are interfaces to data published on the following
# topics:
#
# MQ/QMgrName/Parent
# MQ/QMgrName/Children
# MQ/QMgrName/StreamSupport
#
sub InquireParent {
    my $self = shift;
    $self->_InquireAttribute("MQ/","/Parent","QMgrName",@_);
}

sub InquireChildren {
    my $self = shift;
    $self->_InquireAttribute("MQ/","/Children","QMgrName",@_);
}

sub InquireStreamNames {
    my $self = shift;
    $self->_InquireAttribute("MQ/","/StreamSupport","SupportedStreamName",@_);
}

#
# Interface to the data published on the metatopics:
#
# MQ/S/QMgrName/Publishers/Topics
# MQ/S/QMgrName/Subscribers/Topics
#
sub InquireTopics {
    my $self = shift;
    my (%args) = @_;

    $args{Type} = "Publishers" 
      unless exists $args{Type};
    $args{StreamName} = "SYSTEM.BROKER.DEFAULT.STREAM" 
      unless exists $args{StreamName};
    
    unless ( $args{Type} eq 'Publishers' || $args{Type} eq 'Subscribers' ) {
	$self->{Carp}->("Invalid argument 'Type': must be either 'Publishers' or 'Subscribers'");
	return;
    }

    $self->_InquireAttribute("MQ/S/","/$args{Type}/Topics","RegistrationTopic",%args);
}

sub _InquireAttribute {

    my $self = shift;
    my $prefix = shift;
    my $suffix = shift;
    my $key = shift;
    my (%args) = @_;

    $self->{Reason} = MQRC_UNEXPECTED_ERROR;
    $self->{CompCode} = MQCC_FAILED;

    my $qmgrname = $args{QMgrName} || $self->{QueueManager};
    my $streamname = $args{StreamName} || "SYSTEM.BROKER.ADMIN.STREAM";

    my ($topic) = ($prefix . 
		   $self->_BlankPadName($qmgrname,MQ_Q_MGR_NAME_LENGTH) .
		   $suffix);
    
    my ($message) = $self->InquireRetainedMessages
      (
       Topic 		=> $topic,
       StreamName	=> $streamname,
      );
    
    unless ( ref $message && $message->isa("MQSeries::PubSub::AdminMessage") ) {
	# Don't carp -- InquireRetainedMessages will, if the error isn't ignorable
	return;
    }

    my $attribute = $message->Parameters($key);
    
    if ( ref $attribute eq 'ARRAY' ) {
	return @$attribute;
    }
    else {
	return $attribute;
    }

}

#
# Interface to the data published on the metatopics:
#
# MQ/S/QMgrName/Publishers/Identities/Topic
# MQ/SA/QMgrName/Publishers/AllIdentities/Topic
# MQ/S/QMgrName/Subscribers/Identities/Topic
# MQ/SA/QMgrName/Subscribers/AllIdentities/Topic
#
sub InquireIdentities {

    my $self 		= shift;
    my (%args) 		= @_;

    $self->{Reason} = MQRC_UNEXPECTED_ERROR;
    $self->{CompCode} = MQCC_FAILED;

    my $type		= $args{Type} 		|| "Subscribers";
    my $qmgrname 	= $args{QMgrName} 	|| $self->{QueueManager};
    my $querytopic 	= $args{Topic} 		|| '*';
    my $streamname 	= $args{StreamName} 	|| "SYSTEM.BROKER.DEFAULT.STREAM";
    my $anonymous 	= $args{Anonymous};

    unless ( $type eq 'Publishers' || $type eq 'Subscribers' ) {
	$self->{Carp}->("Invalid argument 'Type': must be either 'Publishers' or 'Subscribers'");
	return;
    }

    my ($admintopic) = ( 
			( $anonymous ? "MQ/SA/" : "MQ/S/" ) .
			$self->_BlankPadName($qmgrname,MQ_Q_MGR_NAME_LENGTH) .
			"/$type" .
			( $anonymous ? "/AllIdentities" : "/Identities" )
		       );
    
    my (@message) = $self->InquireRetainedMessages
      (
       Topic		=> "$admintopic/$querytopic",
       StreamName	=> $streamname,
      );
    
    return unless @message;
    
    my (@result) = ();
    
    foreach my $message ( @message ) {

	my $result = {};
	
	foreach my $key ( 
			 qw(
			    StreamName 
			    Topic
			    PublishTimestamp
			    BrokerCount
			    ApplCount
			    AnonymousCount
			   )
			) {
	    $result->{$key} = $message->Parameters($key);
	}

	$result->{Topic} =~ s:$admintopic/::;

	if ( my $count = $message->Parameters("RegistrationQMgrName") ) {
	    
	    my $maxindex = ref $count eq 'ARRAY' ? scalar @$count : 1;

	    my (@identity) = ();

	    for ( my $index = 0 ; $index < $maxindex ; $index++ ) {

		my $identity = {};

		my $parameters = $message->Parameters();
	    
		foreach my $key (
				 qw(
				    RegistrationQMgrName
				    RegistrationQName
				    RegistrationUserIdentifier
				    RegistrationRegistrationOptions
				    RegistrationTime
				    RegistrationCorrelId
				   )
				) {
		    ( my $shortkey = $key ) =~ s/^Registration//;

		    next unless exists $parameters->{$key};

		    my $value = $parameters->{$key};

		    if ( $maxindex > 1 ) {
			if ( ref $value eq 'ARRAY' ) {
			    $identity->{$shortkey} = $value->[$index];
			}
		    }
		    else {
			$identity->{$shortkey} = $value;
		    }

		}

		push(@identity,$identity);

	    }

	    $result->{$type} = [@identity];

	}

	push(@result,$result);
	
    }

    return @result;

}


#
# This one is special, as its really the building block for the 4
# above.
#
sub InquireRetainedMessages {

    my $self = shift;
    my (%args) = @_;

    $self->{Reason} = MQRC_UNEXPECTED_ERROR;
    $self->{CompCode} = MQCC_FAILED;

    my $topic = $args{Topic};
    my $streamname = $args{StreamName} || "SYSTEM.BROKER.ADMIN.STREAM";
        
    my (@message) = ();

    unless ( 
	    $self->RegisterSubscriber
	    (
	     MsgDesc		=>
	     {
	      Expiry 		=> $self->{Wait},
	     },
	     Options		=>
	     {
	      Topic		=> $topic,
	      StreamName	=> $streamname,
	      RegOpts		=> [qw( 
				       Anon
				       PubOnReqOnly
				      )],
	     },
	    ) 
	   ) {
	$self->{Carp}->("Unable to RegisterSubscriber\n" .
			"Reason   => " . $self->Reason() . "\n");
	return;
    }

    $self->RequestUpdate
      (
       Options		=>
       {
	Topic		=> $topic,
	StreamName	=> $streamname,
       },
      );
    
    if ( $self->Reason() == MQRC_NONE ) {

	while ( 1 ) {
	    my $message = MQSeries::PubSub::AdminMessage->new();
	    unless ( $self->ReplyQ()->Get( Message => $message ) ) {
		$self->{Carp}->("Unable to get message from replyq\n" .
				"Reason => " . $self->ReplyQ()->Reason() . "\n");
		$self->{"Reason"} = $self->ReplyQ()->Reason();
		$self->{"CompCode"} = $self->ReplyQ()->CompCode();
		return;
	    } 
	    last if $self->ReplyQ()->Reason() == MQRC_NO_MSG_AVAILABLE;
	    push(@message,$message);
	}

    }
    elsif ( $self->Reason() != MQRCCF_NO_RETAINED_MSG ) {
	$self->{Carp}->("RequestUpdate failed\n" .
			"Topic 	    => '$topic'\n" .
			"StreamName => '$streamname'\n" .
			"Reason     => " . $self->Reason() . "\n");
	return;
    }

    unless (
	    $self->DeregisterSubscriber
	    (
	     Options		=>
	     {
	      Topic		=> $topic,
	      StreamName	=> $streamname,
	     },
	    )
	   ) {
	$self->{Carp}->("Unable to DeregisterSubscriber\n" .
			"Reason   => " . $self->Reason() . "\n");
	return;
    }

    return @message;

}

1;

__END__

=head1 NAME

MQSeries::PubSub::Broker -- OO class for the MQSeries Publish/Subscribe Broker

=head1 SYNOPSIS

See the documentation for MQSeries::PubSub::Command.

=head1 DESCRIPTION

See above.

=head1 SEE ALSO

  MQSeries::PubSub::Command(3)

=cut
