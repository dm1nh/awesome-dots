#!/usr/bin/env bash

launcher() {
  theme="~/.config/rofi/launcher.rasi"
  killall -q rofi
  opt=$(rofi -show drun -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi
}

quit() {
  theme="~/.config/rofi/quit.rasi"
  uptime=$(uptime -p | sed -e 's/up //g')

  killall -q rofi

  # options
  suspend=""
  lock=""
  logout=""
  reboot=""
  shutdown=""

  # variables passed to dmenu
  opts="$suspend\n$lock\n$logout\n$reboot\n$shutdown"

  opt=$(echo -e $opts | rofi -dmenu -p "Uptime: $uptime" -theme $theme -selected-row 2)

  if [ -z $opt ]; then
    exit 0
  fi

  case $opt in
  $shutdown)
    poweroff
    ;;
  $reboot)
    reboot
    ;;
  $logout)
    awesome-client "awesome.quit()"
    ;;
  $lock)
    ~/.config/awesome/utils/util.sh lock
    ;;
  $suspend)
    systemctl suspend
    ;;
  esac
}

screenshot() {
  theme="~/.config/rofi/screenshot.rasi"

  killall -q rofi

  # Options
  fullscreen=""
  window=""
  selection=""

  # Variables passed to dmenu
  opts="$fullscreen\n$window\n$selection"

  opt=$(echo -e $opts | rofi -dmenu -p "scrot" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  case $opt in
  $fullscreen)
    sleep 0.5
    ~/.config/awesome/utils/screenshot.sh --fullscreen
    ;;
  $window)
    sleep 0.5
    ~/.config/awesome/utils/screenshot.sh --window
    ;;
  $selection)
    sleep 0.5
    ~/.config/awesome/utils/screenshot.sh --selection
    ;;
  esac
}

record() {
  # TODO: How can I stop wf-recorder normally without damaging video file.
  if pgrep ffmpeg >/dev/null; then
    ~/.config/awesome/utils/record.sh
  else
    theme="~/.config/rofi/record.rasi"
    killall -q rofi

    # Options
    sound=""
    silent=""

    # Variables passed to dmenu
    opts="$sound\n$silent"

    opt=$(echo -e $opts | rofi -dmenu -p "ffmpeg" -theme $theme)

    if [ -z $opt ]; then
      exit 0
    fi

    case $opt in
    $sound)
      ~/.config/awesome/utils/record.sh --sound
      ;;
    $silent)
      ~/.config/awesome/utils/record.sh --silent
      ;;
    esac
  fi
}

colorpicker() {
  theme="~/.config/rofi/colorpicker.rasi"

  killall -q rofi

  # Options
  hex="HEX"
  rgb="RGB"
  hsl="HSL"

  # Variables passed to dmenu
  opts="$hex\n$rgb\n$hsl"
  opt=$(echo -e "$opts" | rofi -dmenu -p "xcolor" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  sleep 1
  case $opt in
  $hex)
    ~/.config/awesome/utils/xcolor.sh --hex
    ;;
  $rgb)
    ~/.config/awesome/utils/xcolor.sh --rgb
    ;;
  $hsl)
    ~/.config/awesome/utils/xcolor.sh --hsl
    ;;
  esac
}

docs() {
  theme="~/.config/rofi/docs.rasi"
  killall -q rofi

  opt=$(printf "%s\n" $(ls ~/Documents) | rofi -dmenu -p "zathura" -theme $theme)

  if [ -z $opt ]; then
    exit 0
  fi

  zathura "~/Documents/$opt"
  exit 0
}

clients() {
  theme="~/.config/rofi/clients.rasi"
  killall -q rofi
  rofi -show window -p "Clients" -theme $theme
}

case $1 in
launcher) launcher ;;
quit) quit ;;
screenshot) screenshot ;;
record) record ;;
colorpicker) colorpicker ;;
docs) docs ;;
clients) clients ;;
esac
