#! /usr/bin/perl

use strict;
use warnings;

use File::Basename;
use File::Slurp;
use LWP::Simple;

my $prefix = 'http://www.cppreference.com/wiki/';
my @queue = qw(start);
my %fetched;

while (my $fn = shift @queue) {
    next if -e rewrite_ctor_op($fn) .".html";
    print STDERR scalar(@queue), " $fn\n";
    system("mkdir -p " . dirname($fn) . " 2> /dev/null");
    $fetched{$fn} = 1;
    my $html = get("$prefix$fn");
    $html =~ s|(<a\s+href=")/wiki/(.*?)(")|$1 . handle_link($fn, $2) . $3|eg;
    utf8::encode($html);
    write_file(rewrite_ctor_op($fn) . ".html", $html);
}

sub handle_link {
    my ($base, $dest) = @_;
    $dest =~ s/\?.*$//;
    $dest =~ s|/$|/start|;
    unless ($dest =~ m{^(?:br-pt|cn|cz|de|es|fr|it|jp|nl|pl|ro|ru|sk|tr|tw|_media)/}) {
        push @queue, $dest
            unless $fetched{$dest};
    }
    my $prefix = $base =~ m|/| ? dirname($base) . '/' : '';
    $prefix =~ s{[^/]+}{..}g;
    $dest = rewrite_ctor_op($dest);
    "$prefix$dest.html";
}

sub rewrite_ctor_op {
    my $fn = shift;
    if ($fn =~ m{([^/]+)/([^/]+)_(?:constructors|(operators))$} && $1 eq $2) {
	if (! defined $3) { # ctor
	    $fn = "$`$1/$1";
	} else { # operator
	    $fn = "$`$1/operator";
	}
    }
    $fn;
}
