#!/usr/bin/perl

use 5.016;
use warnings;
use autodie;

use File::Copy qw(copy);

my $destination = $ARGV[0];
die qq(I need a destination.\n) if not defined $destination;
die qq($destination: No such directory\n) if not -d $destination;

my $raw_files = <STDIN>;
my @lines = split( qq(\0), $raw_files);

for (@lines) {
  my $line = $_;
  my $new_name = $line =~ s(/)(^)rg;

  my $from = $line;
  my $to = qq($destination/$new_name);

  say qq($from -> $to);

  copy("$from", "$to") or die qq(Copy failed\n);

}

say qq(All done!);
