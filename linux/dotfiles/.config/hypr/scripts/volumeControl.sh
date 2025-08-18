#!/usr/bin/env bash

# Get Volume
get_volume() {
	volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}')
	echo "$volume"
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Volume : $(get_volume) %"
}

# Increase Volume
inc_volume() {
	wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && notify_user
}

# Decrease Volume
dec_volume() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify_user
}

# Toggle Mute
toggle_mute() {
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	if [ "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{gsub(/\[|\]/, "", $3); print $3}')" == "MUTED" ]; then
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Volume Switched OFF"
	else
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Volume Switched ON"
	fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
else
	get_volume
fi