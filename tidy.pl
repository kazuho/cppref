#! /usr/bin/perl

use strict;
use warnings;

use File::Basename;
use File::Find;
use File::Slurp;

find(
    {
        wanted => sub {
            my $fn = $_;
            return if -d $fn;
            $fn =~ s|^orig/||;
            my $html = read_file("orig/$fn")
                or die "failed to read file:orig/$fn:$!";
            $html =~ s{<head>.*?(<title>.*?</title>)</head>}{<head>$1</head>}s;
            $html =~ s{<div class="header">.*?(<div class="breadcrumbs">)}{$1}s;
            $html =~ s{<div class="plugin_translation">.*?</ul></div>}{}s;
            $html =~ s{<div class="secedit">.*?</form></div>}{}sg;
            $html =~ s{<div class="bar" id="bar__bottom">.*?</body>}{</div></div></body>}s;
            system("mkdir -p " . dirname("doc/$fn")) == 0
                or die "mkdir failed:$?";
            write_file("doc/$fn", $html);
        },
        no_chdir => 1,
    },
    'orig',
);
