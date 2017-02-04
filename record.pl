# this script is used for recording on windows machines

#!/usr/bin/perl

use strict;
use warnings;
use threads;

my $destination = "C:\\Users\\Hunter\\NVR";
my $ffmpeg = "C:\\Users\\Hunter\\ffmpeg.exe";

my @cmds;

sub setCmd {
    my ($arg1, $arg2) = @_;
    push @cmds, "$ffmpeg -rtsp_transport tcp -y -stimeout 1000000 -i \"$arg1\" -c copy -f segment -segment_time 300 -segment_atclocktime 1 -strftime 1 \"$arg2%Y-%m-%d_%H-%M-%S.mp4\"";
}

setCmd('rtsp://user:password@192.168.0.XXX//Streaming/Channels/1', "$destination\\Camera1\\");
setCmd('rtsp://user:password@192.168.0.XXX//Streaming/Channels/1', "$destination\\Camera2\\");

my @threads;
for my $cmd (@cmds) {
   push @threads, async {
      while (1) {
          system($cmd);
          sleep(5);
      }
   };
}

$_->join() for @threads;
