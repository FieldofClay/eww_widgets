#!/bin/bash
set -euo pipefail

get_bn() {
    brightnessctl i -m | cut -d , -f 4 | sed "s/%//"

}

#grab initial read
get_bn


while inotifywait -qq --event modify /sys/class/backlight/intel_backlight/brightness
do
    get_bn
done