#!/usr/local/bin/perl

use warnings;
use strict;

use lib './lib','../lib';

use IO::File;
use File::Type::Builder;

my $in  = new IO::File;
my $out = new IO::File "> cases.pl";
die "No output file!" unless defined ($out);

my ($line, $count) = (0, 0);
my $build = File::Type::Builder->new();

if ($in->open("< mime-magic")) {
  while (<$in>) {
    $line++;
    
    my $data = $_;
    chomp $data;

    # special case for a couple of lines that are unparsable
    next if ($data =~ m/Content-Type/);

    my $parsed = $build->parse_magic($data, $line);
    if (!defined $parsed) {
      # warn "Skipping line $line\n";
      next;
    }
    
    # output to new line
    if ($parsed->{pattern_type} eq 'string') {
      my $code = $build->string($parsed);    
      next unless defined($code);

      print $out $code;
      $count++;
    
    } elsif ($parsed->{pattern_type} eq 'beshort') {
      my $code = $build->beshort($parsed);      
      next unless defined($code);

      print $out $code;
      $count++;
    }      

    
  }
}

print "Read $line lines. Written $count conditions.\n";

exit;

__END__