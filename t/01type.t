#!/usr/bin/perl -w
use strict;

use lib './lib','../lib';

use File::Slurp;
use File::Type;

use Test::More;

=for testing

Set up a list of files to test.

=cut

my $types = {
  "00setup.t" => "application/x-perl",
  "files/blank.jpg" => "image/jpeg",
  "files/blank.tif" => "image/tiff",
  "files/blank.bmp" => "image/x-bmp",
  "files/blank.png" => "image/x-png",
  "files/rebound.wav" => "audio/x-wav",
  "files/tarball.tar" => "application/x-tar",
  "files/tarball.tar.gz" => "application/x-gzip",
  "files/tarball.tar.bz2" => "application/x-bzip2",
  "files/id3lib1.mp3" => "application/octet-stream",
  "files/blank.gif"  => "image/gif",
  "files/blank.zip"  => "application/zip",
  "files/File-Type.html" => "text/html",
  "files/standards.mov" => "video/quicktime",
#  "files/blank.pdf" => "text/pdf",
#  "files/blank.psd" => "image/psd",
#  "files/slkscr.ttf" => "font/ttf",
#  "files/libfile-slurp-perl_2002.0305-1_all.deb" => "application/x-dpkg",
};

plan tests => 2 * scalar keys %{$types};

=for testing

Initialise the object.

=cut

my $ft = File::Type->new();

=for testing

Loop over the objects, testing each both ways.

=cut

foreach my $filename (sort keys %$types) {
  my $mimetype = $types->{$filename};
  is($ft->checktype_filename("t/$filename"), $mimetype, "check file $filename");
  my $data = read_file("t/$filename") || die;
  is($ft->checktype_contents($data), $mimetype, "check data $filename");
}
