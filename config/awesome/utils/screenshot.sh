#!/usr/bin/env bash

mkdir -p ~/Pictures
case $1 in
--fullscreen)
	scrot "/home/dm1nh/Pictures/ss-%Y%m%d-%H%M%S.png"
  awesome-client "
    local naughty = require('naughty')
    naughty.notification({
      app_name = 'screenshot',
      title = 'Screenshot',
      message = 'Your screenshot has been saved.',
    })
  "
	;;
--window)
	scrot -u "/home/dm1nh/Pictures/ss-%Y%m%d-%H%M%S.png"
  awesome-client "
    local naughty = require('naughty')
    naughty.notification({
      app_name = 'screenshot',
      title = 'Screenshot',
      message = 'Your screenshot has been saved.',
    })
  "
	;;
--selection)
	scrot -s -f "/home/dm1nh/Pictures/ss-%Y%m%d-%H%M%S.png"
  awesome-client "
    local naughty = require('naughty')
    naughty.notification({
      app_name = 'screenshot',
      title = 'Screenshot',
      message = 'Your screenshot has been saved.',
    })
  "
	;;
esac
