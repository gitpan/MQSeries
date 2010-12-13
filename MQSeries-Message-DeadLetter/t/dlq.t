#
# $Id: dlq.t,v 33.5 2010/04/01 16:24:47 anbrown Exp $
#
# (c) 1999-2010 Morgan Stanley & Co. Incorporated
# See ..../src/LICENSE for terms of distribution.
#

#
# The 13 has to be updated experimentally if the tests are extended.
#
BEGIN {
    print "1..1\n";
}

#
# We need this to pick up the PERL_DL_NONLAZY definition,
# conditionally.
#
BEGIN {
    require "../util/parse_config";
}

END { print "not ok 1\n" unless $loaded; }
use MQSeries 1.32;
use MQSeries::Message::DeadLetter 1.32 qw( MQDecodeDeadLetter MQEncodeDeadLetter );
$loaded = 1;
print "ok 1\n";

