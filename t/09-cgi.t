#!/usr/bin/perl -w
#
# 09-cgi.t
#
# cgi test script
#
# run the cgi-test and check the resulting output
#

BEGIN { unshift @INC, "lib", "../lib" }
use strict;
use File::Basename;
use PDF::Create;
use Test::More tests => 2;
use Config;

my $pdfname = $0;
$pdfname =~ s/\.t/\.pdf/;
my $cginame = File::Spec->catfile(dirname($0) . "/09-cgi-script.pl");

#
# run the cgi
#
ok( !system(qq($cginame | $Config{"perlpath"} -n -e "print if \$. > 2" >$pdfname)), "CGI executes" );

################################################################
#
# Check the resulting pdf for errors with pdftotext
#
SKIP: {
	skip '/usr/bin/pdftotext not installed', 1 if (! -x '/usr/bin/pdftotext');
    my $out = `/usr/bin/pdftotext $pdfname /dev/null 2>&1`;
    ok( $out eq "", "pdftotext $out");
}

