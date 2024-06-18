#!/usr/bin/env bash

get_date() {
	date '+%Y%m%d-%H%M%S'
}

if pgrep ffmpeg > /dev/null; then
  pkill ffmpeg && awesome-client "awesome.emit_signal('record::stop')" && exit 0
fi

mkdir -p ~/Videos

case $1 in
  --sound)
    name="/home/dm1nh/Videos/record-$(get_date).mp4"
    awesome-client "awesome.emit_signal('record::start')"
    ffmpeg -f x11grab -video_size 1920x1080 -framerate 30 -i $DISPLAY -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac "$name"  &
    ;;
  --silent)
    name="/home/dm1nh/Videos/record-$(get_date).mp4"
    awesome-client "awesome.emit_signal('record::start')"
    ffmpeg -f x11grab -video_size 1920x1080 -framerate 30 -i $DISPLAY -i default -c:v libx264 -preset ultrafast -c:a aac "$name" &
    ;;
esac
