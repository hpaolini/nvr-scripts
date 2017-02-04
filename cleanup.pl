#!/usr/bin/perl

use strict;
use warnings;
use File::Find;

# directory where media is stored
#my $backup_root = "/Volumes/disk3/nvr/";
my $backup_root = "C:\\Users\\Hunter\\NVR";

my @file_list;
my @find_dirs       = ($backup_root);               # directories to search
my $now             = time();                       # get current time
my $days            = 14;                           # how many days old
my $seconds_per_day = 60 * 60 * 24;                 # seconds in a day
my $AGE             = $days * $seconds_per_day;     # age in seconds

find (sub {
  my $file = $File::Find::name;
  if (-f $file) {
    push (@file_list, $file);
  }
}, @find_dirs);

for my $file (@file_list) {
  my @stats = stat($file);
  if ($now-$stats[9] > $AGE) {
    unlink $file;
  }
}
