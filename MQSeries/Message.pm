#
# $Id: Message.pm,v 15.1 2000/08/16 00:41:32 wpm Exp $
#
# (c) 1999, 2000 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#

package MQSeries::Message;

require 5.004;

use strict qw(vars refs);
use Carp;
use English;

use MQSeries;

use vars qw($VERSION);

$VERSION = '1.12';

sub new {

    my $proto = shift;
    my $class = ref($proto) || $proto;
    my %args = @_;

    my %MsgDesc = ();

    my $self =
      {
       # This needs to be a hard reference.  See MQSeries::Queue::Put()
       MsgDesc 		=> \%MsgDesc,
       # XXX - performance impact on default buffer size?
       BufferLength 	=> 32767,
       Carp 		=> \&carp,
      };

    bless ($self, $class);

    #
    # First thing -- override the Carp routine if given.
    #
    if ( $args{Carp} ) {
	if ( ref $args{Carp} ne "CODE" ) {
	    carp "Invalid argument: 'Carp' must be a CODE reference\n";
	    return;
	} else {
	    $self->{Carp} = $args{Carp};
	}
    }

    if ( exists $args{MsgDesc} ) {
	if ( ref $args{MsgDesc} eq "HASH" ) {
	    #$self->{MsgDesc} = $args{MsgDesc};
	    %MsgDesc = %{$args{MsgDesc}};
	} else {
	    $self->{Carp}->("Invalid argument: 'MsgDesc' must be a HASH reference.\n");
	    return;
	}
    }

    #
    # I don't want this key to exist unless it was passed in as an
    # argument
    #
    if ( exists $args{Data} && defined $args{Data} ) {
	$self->Data($args{Data});
    }

    #
    # Sanity check other args
    #
    if ( exists $args{BufferLength} && defined $args{BufferLength} ) {
	return unless defined $self->BufferLength($args{BufferLength});
    }

    return $self;

}

#
# Unlike *most* of these methods (here, and in most other code), this
# returns a hard reference to the entire hash
#
sub MsgDesc {

    my $self = shift;

    if ( $_[0] ) {
	if ( exists $self->{MsgDesc}->{$_[0]} ) {
	    return $self->{MsgDesc}->{$_[0]};
	} else {
	    $self->{Carp}->("No such MsgDesc field: $_[0]\n");
	    return;
	}
    } else {
	return $self->{MsgDesc};
    }

}

#
# Set the data value, if given.  With no args, it just returns the
# data value.  Same for the buffer.
#
sub Data {
    my $self = shift;
    if ( defined $_[0] ) {
	$self->{Data} = $_[0];
    }
    return $self->{Data};
}

sub Buffer {
    my $self = shift;
    if ( defined $_[0] ) {
	$self->{Buffer} = $_[0];
    }
    return $self->{Buffer};
}

sub BufferLength {

    my $self = shift;

    if ( scalar @_ > 0 ) {

	my $BufferLength = $_[0];

	if (
	    $BufferLength >= 0 and
	    $BufferLength == int($BufferLength)
	   ) {
	    $self->{BufferLength} = $BufferLength;
	} else {
	    $self->{Carp}->("Invalid argument: 'BufferLength' must be a positive integer.\n");
	    return undef;
	}
    }

    return $self->{BufferLength};
}

1;

__END__

=head1 NAME

MQSeries::Message -- OO interface to MQSeries messages

=head1 SYNOPSIS

  use MQSeries;
  use MQSeries::Message;

  #
  # Create a vanilla MQSeries::Message object for getting messages
  #
  my $getmsg = MQSeries::Message->new();

  #
  # Create a message for putting strings, which requires the
  # MQMD.Format field to be specified.  This is essential for
  # character codeset conversion. 
  #
  my $putmsg = MQSeries::Message->new
    (
     MsgDesc 		=>
     {
      Format		=> MQFMT_STRING,
     },
    );

  #
  # Create a reply message, copying the CorrelId from the MsgId of a
  # request.  This reply is also a string.
  #
  my $request = MQSeries::Message->new();

  # Assume we get the message via an MQSeries::Queue object...

  my $reply = MQSeries::Message->new
    (
     MsgDesc 		=>
     {
      Format		=> MQFMT_STRING,
      CorrelId 		=> $request->MsgDesc("MsgId"),
     },
    );

See MQSeries::Queue SYNOPSIS section as well.

=head1 DESCRIPTION

The MQSeries::Message object is an OO mechanism for creating MQSeries
messages, and putting and getting them onto MQSeries queues,
with an interface which is much simpler than the full MQI.

This module is used together with MQSeries::QueueManager and
MQSeries::Queue.  These objects provide a subset of the MQI, with a
simpler interface.

=head1 METHODS

=head2 new

The arguments to the constructor are a hash, with the following
key/value pairs (there are no required keys):

  Key            Value
  ===            =====
  Data           Scalar
  BufferLength   Positive Integer
  MsgDesc        MQI MsgDesc hash (MQMD structure)
  Carp           CODE reference

=over 4

=item Data

When creating a message to be put into a queue, the B<Data> should be
specified.  This must be a simple scalar value.  Other subclasses of
MQSeries::Message support the direct encoding of complex data
structure, for example perl references can be sent and retreived as
MQSeries messages using the MQSeries::Message::Storable module.

The Data method will set the Data portion of the message if it is
passed any defined value, and will simply return the data otherwise.
Thus, to clear any existing Data from a message, one would pass the
empty string:

  $message = MQSeries::Message->new( Data => "foo" );
  $message->Data(""); # Clears Data value entirely

In order to query the Data value, the method must be called with no
further arguments;

  $data = $message->Data(); # Returns Data unmolested

=item Buffer

This method will return the raw, converted buffer when one exists.
This is really only relevant for a message type which uses a
PutConvert and/or GetConvert method to translate the raw buffer
returned from MQGET().

=item BufferLength

This sets the BufferLength of the messages to be extracted using
MQGET.  The default is 32K, and if the messages to be received from
the queue are expected to be larger, this must be set appropriately.

=item MsgDesc

The value of this key is a hash refernece which sets the key/values of
the MsgDesc structure.  See the "MQSeries Application Programming
Reference" documentation for the possible keys and values of the MQMD
structure.

Also, see the examples section for specific usage of this feature.
This is one area of the API which is not easily hidden; you have to
know what you are doing.

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

  my $message = MQSeries::Message->new( Carp => \&MyLogger )
    || die "Unable to create message.\n";

The default, as one might guess, is Carp::carp();

=back 

=head2 Data

This method is used to set or query the value of the Data structure.
If an argument is specified, then the given data is assigned as the
Data value for this object.  If no argument is given, then the current
Data value is returned.

The Data can be any arbitrary perl data structure, however, it must be
convertible to a scalar by means of the PutConvert and GetConvert
hooks in MQSeries::QueueManager and MQSeries::Queue objects.  See the
documentation for those classes for more details.

If the GetConvert and PutConvert hooks are not used, then the data
must be a simple scalar value.

=head2 BufferLength

This method is used to set or query the current BufferLength used when
extracting messages.  If given an argument, the BufferLength is set to
the given value.  If the given value is not a positive integer, then
an error is generated, and a false value returned.

With no argument, the current BufferLength is returned.

=head2 MsgDesc

This method can be used to query the MsgDesc data structure.  If no
argument is given, then the entire MsgDesc hash is returned.  If a
single argument is given, then this is interpreted as a specific key,
and the value of that key in the MsgDesc hash is returned.

=head1 ERROR HANDLING

Most methods return a true or false value indicating success of
failure, and internally, they will call the carp subroutine (either
Carp::carp, or something user-defined) with a text message indicating
the cause of the failure.

=head1 SUBCLASSES

This class is designed to be subclassed, and follows all the usual
rules (see the "perltoot" documentation provided with the core perl
distribution).  In particular, the PutConvert and GetConvert arguments
usually supplied to either the MQSeries::QueueManager or
MQSeries::Queue constructors are not necessary if you implement a
subclass of MQSeries::Message with methods of the same name.

See the MQSeries::Message::Storable documentation for an example of
one such class.

See also the section "CONVERSION PRECEDENCE" in the
MQSeries::QueueManager documentation.

=head1 SEE ALSO

MQSeries(3), MQSeries::QueueManager(3), MQSeries::Queue(3),
MQSeries::Message::Storable(3), MQSeries::Message::Event(3)

=cut
