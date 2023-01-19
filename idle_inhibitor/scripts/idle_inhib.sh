#!/bin/sh

IDLE_STATUS=`ps ax | grep wayland-idle-inhibitor | grep -v grep  | sed "s/^\s*//" | cut -d " " -f 1`

if [[ -z "$IDLE_STATUS" ]]; then
	#idle inhibitor is not running, start it
	/usr/bin/wayland-idle-inhibitor.py &
	eww update idle_state=""
else
	#idle inhibitor is running, kill it
	kill $IDLE_STATUS
	eww update idle_state=""
fi
