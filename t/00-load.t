#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'DHX::Accordion' ) || print "Bail out!\n";
}

diag( "Testing DHX::Accordion $DHX::Accordion::VERSION, Perl $], $^X" );
