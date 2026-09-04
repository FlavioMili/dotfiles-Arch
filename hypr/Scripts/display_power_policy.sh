#!/usr/bin/env bash

# Use 60 Hz only when power-saver is active and the battery is discharging.
# Return to the highest available refresh rate on AC or in any other profile.

readonly monitor="eDP-1"
readonly battery_status="/sys/class/power_supply/BAT0/status"
readonly low_power_mode="2880x1800@60"
readonly normal_mode="highrr"

last_mode=""

apply_display_policy() {
	local target_mode="$normal_mode"
	local profile
	local status

	profile="$(powerprofilesctl get 2>/dev/null)" || return
	status="$(<"$battery_status")" || return

	if [[ $profile == "power-saver" && $status == "Discharging" ]]; then
		target_mode="$low_power_mode"
	fi

	if [[ $target_mode != "$last_mode" ]]; then
		hyprctl eval \
			"hl.monitor({ output = \"$monitor\", mode = \"$target_mode\", position = \"auto\", scale = \"auto\" })" \
			>/dev/null && last_mode="$target_mode"
	fi
}

apply_display_policy

# React to both profile changes and AC/battery transitions without polling.
dbus-monitor --system \
	"type='signal',sender='org.freedesktop.UPower.PowerProfiles',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" \
	"type='signal',sender='org.freedesktop.UPower',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged'" |
	while IFS= read -r event; do
		if [[ $event == signal* ]]; then
			apply_display_policy
		fi
	done
