#!/usr/bin/env bash
set -u

temperature=${1:?temperature required}
exec 9>"${XDG_RUNTIME_DIR:?}/hyprsunset-temperature.lock"
flock 9

if hyprctl hyprsunset temperature "$temperature" >/dev/null 2>&1; then
    exit 0
fi

# An older or unresponsive instance can hold the compositor's CTM manager
# without providing a usable socket. Only restart instances in this session.
for proc in /proc/[0-9]*; do
    [[ $(cat "$proc/comm" 2>/dev/null) == hyprsunset ]] || continue
    tr '\0' '\n' < "$proc/environ" 2>/dev/null | grep -Fxq "HYPRLAND_INSTANCE_SIGNATURE=${HYPRLAND_INSTANCE_SIGNATURE:?}" || continue
    kill "${proc##*/}" 2>/dev/null || true
done

for attempt in {1..30}; do
    pgrep -x hyprsunset >/dev/null || break
    sleep 0.1
done

nohup hyprsunset >"$XDG_RUNTIME_DIR/hyprsunset-recovery.log" 2>&1 9>&- </dev/null &
for attempt in {1..30}; do
    if hyprctl hyprsunset temperature "$temperature" >/dev/null 2>&1; then
        exit 0
    fi
    sleep 0.1
done

command -v notify-send >/dev/null && notify-send "Hyprsunset" "Could not set the screen temperature. See $XDG_RUNTIME_DIR/hyprsunset-recovery.log."
exit 1
