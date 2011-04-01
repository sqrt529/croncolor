#!/usr/bin/perl
# croncolor.pl - Prints colorized crontab from stdin
#
# Copyright (C) 2010 Joachim "Joe" Stiegler <blablabla@trullowitsch.de>
#
# This program is free software; you can redistribute it and/or modify it under the terms
# of the GNU General Public License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program;
# if not, see <http://www.gnu.org/licenses/>.
#
# --
# To see the output colorized within 'less', use the '-r' option

use warnings;
use strict;
use Term::ANSIColor;
use Getopt::Std;
use IO::Select;

our ($opt_h);

if ( (!getopts("h")) or (defined($opt_h)) ) {
	die "usage: crontab -l | $0 \n";
}

my @lines;

my $s = IO::Select->new;
$s->add(\*STDIN);

if ($s->can_read(0)) {
	while (<STDIN>) {
		push @lines, $_;
	}
}
else {
	die "can't get data from STDIN\n";
}

foreach my $line (@lines) {
	if ($line =~ /^#/) {
		print color 'green';
		print $line;
		next;
	}
	elsif ($line =~ /^$/) {
		print "\n";
		next;
	}
	else {
		my @cronline = split(' ', $line);

		print color 'bold green';
		print $cronline[0]." ";
		print color 'reset';

		print color 'bold cyan';
		print $cronline[1]." ";
		print color 'reset';

		print color 'bold magenta';
		print $cronline[2]." ";
		print color 'reset';

		print color 'bold yellow';
		print $cronline[3]." ";
		print color 'reset';

		print color 'bold blue';
		print $cronline[4]." ";
		print color 'reset';

		for (my $i = 5; $i <= scalar(@cronline) - 1; $i++) {
			print $cronline[$i]." ";
		}
		print "\n";
	}
}
