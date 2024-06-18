#!/bin/bash

check_redshift() {
  GAMMAX=$(xrandr --verbose | grep 'Gamma' | awk -F ':' '{print $2}' | tr -d ' ')
  GAMMAY=$(xrandr --verbose | grep 'Gamma' | awk -F ':' '{print $3}' | tr -d ' ')
  GAMMAZ=$(xrandr --verbose | grep 'Gamma' | awk -F ':' '{print $4}' | tr -d ' ')

  if [ $GAMMAX != 1.0 ] | [ $GAMMAY != 1.0 ] | [ $GAMMAZ != 1.0 ]; then
    exit 0
  else
    exit 1
  fi
}

test_awesome() {
  Xephyr -br -ac -noreset -screen 800x600 :1 & sleep 2 ; DISPLAY=:1 awesome
}

idle() {
  killall xidlehook &> /dev/null
  xidlehook \
    --not-when-audio \
    --timer 180 \
      'xrandr --output "HDMI-A-0" --brightness .5' \
      'xrandr --output "HDMI-A-0" --brightness 1' \
    --timer 120 \
      'xrandr --output "HDMI-A-0" --brightness 1; awesome-client "lock_screen_show()"' \
      '' \
    --timer 1200 \
      'systemctl suspend' \
      ''
}

case $1 in
  check_redshift) check_redshift ;;
  test_awesome) test_awesome ;;
  idle) idle ;;
esac
