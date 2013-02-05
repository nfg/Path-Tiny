#!/usr/bin/env perl
use strict;
use warnings;
use Benchmark::Forking qw/cmpthese/;
use Path::Tiny;
use Path::Class;
use File::Fu;
use IO::All;

print "$0\n";

my $file = "/usr/share/dict/words";

my $count = -1;
cmpthese(
    $count,
    {
        'Path::Tiny'  => sub { my $s = path($file)->slurp },
        'Path::Class' => sub { my $s = file($file)->slurp },
        'IO::All'     => sub { my $s = io($file)->slurp },
        'File::Fu'    => sub { my $s = File::Fu->file($file)->read },
    }
);

