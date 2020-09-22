#!/usr/bin/perl

use strict;
use warnings;

sub get_vendor {
  my $file = shift;

  my $vendor = `grep vendor '${file}' | head -n1 | cut -d= -f2`;
  chomp($vendor);

  $vendor =~ s{[^0-9a-zA-Z \-_]}{}g;

  return $vendor;
}

sub mkpath {
  my $dir = shift;

  if ( ! -d $dir ) {
    system(qw(mkdir -p), $dir);
  }
}

sub path {
  return join "/", @_;
}

sub basename {
  my $fn = shift;

  my $out = `basename '${fn}'`;
  chomp($out);

  return $out;
}

sub copy {
  my ($from, $to) = @_;
  system('cp', $from, $to);
}

sub replace {
  my ($from, $to, $file) = @_;
  system(qw(sed -i), "s|${from}|${to}|", $file);
}

sub main {
  my $rootdir = shift;

  if ( ! -d $rootdir ) {
    exit 0;
  }

  for my $type (qw(Generators Effects)) {
    for my $vst (qw(VST VST3)) {
      my $src = path($rootdir, 'Installed', $type, $vst);

      my @files = `find "${src}" -type f -name '*.nfo'`;

      for my $file (@files) {
        chomp($file);

        my $vendor = get_vendor($file);
        my $dest = path($rootdir, 'Vendors', $type, $vst, $vendor);
        
        mkpath($dest);

        my $nfo = $file;
        my $fst = $file; $fst =~ s{\.nfo$}{.fst};

        for my $from ($nfo, $fst) {
          next if ( ! -e $nfo || ! -e $fst );
          my $to = path($dest, basename($from));

          if (! -e $to) {
            copy($from, $to);

            if ($to =~ m{\.nfo$}) {
              my $target = "%FLPluginDBPath%\\\\Installed\\\\$type\\\\$vst";
              my $result = $target;
                 $result =~ s{Installed}{Vendors};
                 $result =~ s{$vst}{$vst\\\\$vendor};

              replace($target, $result, $to);
            }
          }
        }

        print "done: " . $file . "\n";
      }
    }
  }
}

main @ARGV;
