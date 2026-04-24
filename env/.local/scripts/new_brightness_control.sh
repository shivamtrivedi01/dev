#!/bin/bash

# --- CONFIGURATION ---
STEP=5
# ---------------------

get_display_number() {
    case "$1" in
        "benq") echo "1" ;;
        "lenovo") echo "2" ;;
        *) echo "$1" ;;
    esac
}

set_brightness_in_background() {
    local disp=$1
    local val=$2
    pkill -f "ddcutil.*--display $disp.*setvcp 10"
    (ddcutil --display $disp setvcp 10 $val) &
}

get_brightness() {
    local disp=$1
    local state_file="/tmp/waybar_brightness_$disp.tmp"

    if [ ! -f "$state_file" ]; then
        initial_brightness=$(ddcutil --display $disp getvcp 10 -t 2>/dev/null | cut -d ' ' -f 4)
        echo "$initial_brightness" > "$state_file"
    fi
    cat "$state_file"
}

set_brightness() {
    local disp=$1
    local new_brightness=$2
    local state_file="/tmp/waybar_brightness_$disp.tmp"

    echo "$new_brightness" > "$state_file"
    set_brightness_in_background "$disp" "$new_brightness"
    pkill -RTMIN+8 waybar
}

handle_action() {
    local disp=$1
    local action=$2
    local state_file="/tmp/waybar_brightness_$disp.tmp"
    local current

    if [ ! -f "$state_file" ]; then
        current=$(ddcutil --display $disp getvcp 10 -t 2>/dev/null | cut -d ' ' -f 4)
        echo "$current" > "$state_file"
    else
        current=$(cat "$state_file")
    fi

    case "$action" in
        "get")
            echo " $current"
            ;;
        "up")
            new_brightness=$((current + STEP > 100 ? 100 : current + STEP))
            if [ "$current" -ne "$new_brightness" ]; then
                set_brightness "$disp" "$new_brightness"
            fi
            ;;
        "down")
            new_brightness=$((current - STEP < 0 ? 0 : current - STEP))
            if [ "$current" -ne "$new_brightness" ]; then
                set_brightness "$disp" "$new_brightness"
            fi
            ;;
        "right_click")
            new_brightness=0
            if [ "$current" -ne "$new_brightness" ]; then
                set_brightness "$disp" "$new_brightness"
            fi
            ;;
        "left_click")
            new_brightness=100
            if [ "$current" -ne "$new_brightness" ]; then
                set_brightness "$disp" "$new_brightness"
            fi
            ;;
    esac
}

if [ -z "$1" ]; then
    echo "Usage: $0 <benq|lenovo> <get|up|down|left_click|right_click>"
    exit 1
fi

DISPLAY=$(get_display_number "$1")
ACTION="$2"

handle_action "$DISPLAY" "$ACTION"