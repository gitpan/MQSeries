#
# $Id: pubsub.t,v 14.2 2000/08/15 20:51:23 wpm Exp $
#
# (c) 1999, 2000 Morgan Stanley Dean Witter and Co.
# See ..../src/LICENSE for terms of distribution.
#

BEGIN {
    require "../util/parse_config";
    require "../util/parse_headers";
}

BEGIN {
    $| = 1;
    if ( $::has_mqrfh ) {
	print "1..1\n";
    }
    else {
	print "1..0\n";
	exit 0;
    }
}

END {print "not ok 1\n" unless $loaded;}
use MQSeries::PubSub::Broker 		1.11;
use MQSeries::PubSub::Stream 		1.11;
use MQSeries::PubSub::Message 		1.11;
use MQSeries::PubSub::AdminMessage 	1.11;
$loaded = 1;
print "ok 1\n";

#
# For now, all this test really buys us is a sanity check that there
# are no syntax errors in any of the PubSub related files.
#
# A real test suite for the PubSub API will require a lot of work.
#
