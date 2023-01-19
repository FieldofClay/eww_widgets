#!/bin/bash
set -euo pipefail

echo "Disconnected"
nmcli -t con show --active | cut -d : -f 1


LC_ALL=C nmcli monitor | \
    while read -r line
    do
        if [[ "$line" == *" is now the primary connection" ]]
        then
            echo $line | sed "s/' is now the primary connection//" | sed "s/'//"
        fi
        if [[ "$line" == "Connectivity is now 'none'" ]]
        then
            echo "Disconnected"
        fi
    done