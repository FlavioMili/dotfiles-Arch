#!/bin/bash

# toggles hypridle on/off

get_state() {
    if pgrep -x "hypridle" >/dev/null; then
        echo "locked"
    else
        echo "unlocked"
    fi
}

if [[ "${1:-}" == "--status" ]]; then
    echo "{\"icon\": \"$(get_state)\"}"
    exit 0
fi

# Toggle state
if [[ "$(get_state)" == "locked" ]]; then
    pkill -x "hypridle"
    notify-send "Hypridle killed!"
else
    hypridle &
    notify-send "Hypridle resurrected!"
fi

# Output new state
echo "{\"icon\": \"$(get_state)\"}"
