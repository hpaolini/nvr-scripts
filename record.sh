#!/bin/bash

dir     = "/Volumes/disk3/nvr"
ffmpeg  = "/Users/hunter/Scripts/ffmpeg"

function format_command {
    echo "$1 -rtsp_transport tcp -y -stimeout 1000000 -i \"$2\" -c copy -f segment -segment_time 300 -segment_atclocktime 1 -strftime 1 \"$3%Y-%m-%d_%H-%M-%S.mp4\" </dev/null > /dev/null 2>&1"
}

command[0] = format_command $ffmpeg "rtsp://user:password@192.168.0.XXX//Streaming/Channels/1" "$dir/Camera1/"
command[1] = format_command $ffmpeg "rtsp://user:password@192.168.0.XXX//Streaming/Channels/1" "$dir/Camera2/"

for i in "${!command[@]}"; do
    (while true; do
        eval "${command[i]}"
        sleep 5
    done) &
done
