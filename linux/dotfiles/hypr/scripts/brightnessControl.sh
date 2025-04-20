!/usr/bin/env bash

# Get brightness
get_backlight() {
	LIGHT=$(printf "%.0f\n" $(brightnessctl | awk -F '[()]' '/Current/ {print $2}'))
	echo "${LIGHT}"
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight) %"
}

# Increase brightness
inc_backlight() {
	brightnessctl s +5% && notify_user
}

# Decrease brightness
dec_backlight() {
	current=$(get_backlight)
	if [[ "$current" -le 5 ]]; then
		notify_user
	else
		brightnessctl s 5%- && notify_user
	fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
