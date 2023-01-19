#!/bin/bash
set -euo pipefail

get_vol() {
    d_sink=$(pactl get-default-sink)
    d_source=$(pactl get-default-source)
    d_sink_volume=$(pamixer --get-volume-human --sink $d_sink)
    d_source_volume=$(pamixer --get-volume-human --source $d_source)
    echo "{\"sink\":\""$d_sink_volume"\",\"source\":\""$d_source_volume"\"}"

}

#grab initial read
get_vol

LC_ALL=C pactl subscribe | \
    while read -r line
    do
        if [[ "$line" == "Event 'change' on sink #"* ]]
        then
            get_vol
        fi
        if [[ "$line" == "Event 'change' on source #"* ]]
        then
            get_vol
        fi
    done