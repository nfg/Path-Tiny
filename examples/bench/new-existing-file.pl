#!/usr/bin/env perl
use strict;
use warnings;
use Benchmark::Forking qw/cmpthese/;
use Path::Tiny;
use Path::Class;
use File::Fu;
use IO::All;

print "$0\n";

my $tmpdir = Path::Tiny->tempdir;
my $file = $tmpdir->child("foo.txt");
$file->touch;
$file = "$file";

my $count = -1;
cmpthese(
    $count,
    {
        'Path::Tiny'  => sub { path($file) },
        'Path::Class' => sub { file($file) },
        'IO::All'     => sub { io($file) },
        'File::Fu'    => sub { File::Fu->file($file) },
    }
);

