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
    next if -e "$fn.html";
    print STDERR scalar(@queue), " $fn\n";
    system("mkdir -p " . dirname($fn) . " 2> /dev/null");
    $fetched{$fn} = 1;
    my $html = get("$prefix$fn");
    $html =~ s|(<a\s+href=")/wiki/(.*?)(")|$1 . handle_link($fn, $2) . $3|eg;
    write_file("$fn.html", $html);
}

sub handle_link {
    my ($base, $dest) = @_;
    $dest =~ s/\?.*$//;
    $dest =~ s|/$|/start|;
    unless ($dest =~ m{^(?:br-pt|cn|fr|it|pl|ru|tr)/}) {
        push @queue, $dest
            unless $fetched{$dest};
    }
    my $prefix = $base =~ m|/| ? dirname($base) : '';
    $prefix =~ s{[^/]+}{..}g;
    "$prefix/$dest.html";
}
