#!/usr/bin/env bash

# see https://codeberg.org/z3rOR0ne/dyetide/src/branch/main/dye

# for use in rgb_to_hsl
dec_to_float() {
    echo "scale=8; $1 / 255" | bc -l
}

# for use in rgb_to_hsl
find_min_max() {
    max=$1
    min=$1
    for arg in "$@"
    do
        if [[ "$(echo "$arg > $max" | bc -l)" -eq 1 ]]; then
            max=$arg
        elif [[ "$(echo "$arg < $max" | bc -l)" -eq 1 ]]; then
            min=$arg
        fi
    done
}

# converted from Garry Tan's JS function (see credits)
rgb_to_hsl() {
    r=$(dec_to_float "$1")
    g=$(dec_to_float "$2")
    b=$(dec_to_float "$3")

    find_min_max "$r" "$g" "$b"

    # initial hue/saturation/lightness values are equivalent to $min+$max/2
    h=$(echo "scale=8; ($max + $min) / 2" | bc -l)
    s=$(echo "scale=8; ($max + $min) / 2" | bc -l)
    l=$(echo "scale=8; ($max + $min) / 2" | bc -l)

    # if $min and $max are equal,, then color is greyscale, and only lightness
    # value is needed
    if (( $(echo "$min $max" | awk '{print ($1 == $2)}') )); then
        h=0
        s=0
        l="$(echo "scale=8; $max + $min" | bc -l)"
    else
        #calculate difference between max and min
        d="$(echo "scale=8; $max - $min" | bc -l)"

        # calculate hue (not the same as calculate_hue func in hex_to_hsl)
        # if red is predominant hue in find_min_max
        if (( $(echo "$max $r" | awk '{print ($1 == $2)}') )); then
            h=$(echo "scale=8; ($g - $b) / $d" | bc -l)
            # then if g is less than b
            if (( $(echo "$g $b" | awk '{print ($1 < $2)}') )); then
                h=$(echo "scale=8; $h + 6" | bc -l)
            fi
        # if green is predominant hue in find_min_max
        elif (( $(echo "$max $g" | awk '{print ($1 == $2)}') )); then
            h=$(echo "scale=8; ($b - $r) / $d + 2" | bc -l)
        # if blue is predominant hue in find_min_max
        else
            h=$(echo "scale=8; ($r - $g) / $d + 4" | bc -l)
        fi

        h=$(echo "scale=8; $h / 6" | bc -l)

        # calculate saturation (not the same as calculate_saturation func in hex_to_hsl)
        if (( $(echo "$l 0.5" | awk '{print ($1 > $2)}') )); then
            s=$(echo "scale=8; $d / (2 - $max - $min)" | bc -l)
        else
            s=$(echo "scale=8; $d / ($max + $min)" | bc -l)
        fi

        # calculate lightness
        l=$(echo "scale=8; ($max + $min) / 2" | bc -l)
    fi

    # convert back to 360 color wheel values
    h=$(printf "%.0f" "$(echo "$h * 360" | bc -l)")
    s=$(printf "%.0f" "$(echo "$s * 100" | bc -l)")
    l=$(printf "%.0f" "$(echo "$l * 100" | bc -l)")

    # clamp the results between 0 and max values
    h=$(echo "$h" | awk '{print ($1 > 360 ? 360 : $1 < 0 ? 0 : $1)}' | xargs printf "%d")
    s=$(echo "$s" | awk '{print ($1 > 100 ? 100 : $1 < 0 ? 0 : $1)}' | xargs printf "%d")
    l=$(echo "$l" | awk '{print ($1 > 100 ? 100 : $1 < 0 ? 0 : $1)}' | xargs printf "%d")

    # if a fourth arg is provided (alpha channel)
    if [[ -n "$4" ]]; then
        a="$4"
        if [[ $(echo "scale=2; $a > 1" | bc -l) -eq 1 ]]; then
            error "alpha channel cannot be greater than 1.0"
        fi
    else
        a=""
    fi

    # print out final values
    if [[ -n "$a" ]]; then
        printf "%s\n" "hsla($h, $s%, $l%, $a)"
    else
        printf "%s\n" "hsl($h, $s%, $l%)"
    fi
}

case $1 in
  --hex)
    clr=$(xcolor -f hex)
    printf "%s" "$clr" | xclip -selection clipboard
    awesome-client "
      local naughty = require('naughty')
      naughty.notification({
        app_name = 'colorpicker',
        title = '$clr',
        message = 'Color has been copied to clipboard',
      })
    "
    ;;
  --rgb)
    clr=$(xcolor -f rgb)
    printf "%s" "$clr" | xclip -selection clipboard
    awesome-client "
      local naughty = require('naughty')
      naughty.notification({
        app_name = 'colorpicker',
        title = '$clr',
        message = 'Color has been copied to clipboard',
      })
    "
    ;;
  --hsl)
    IFS=";" read -ra vals <<< "$(xcolor -f plain)"
    clr=$(rgb_to_hsl ${vals[@]})
    printf "%s" "$clr" | xclip -selection clipboard
    awesome-client "
      local naughty = require('naughty')
      naughty.notification({
        app_name = 'colorpicker',
        title = '$clr',
        message = 'Color has been copied to clipboard',
      })
    "
esac

