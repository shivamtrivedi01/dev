#!/bin/bash

# --- CONFIGURATION ---
DISPLAY_NUM=1
STEP=5
STATE_FILE="/tmp/waybar_contrast.tmp"
# ---------------------

# Function to send the actual DDC/CI command in the background
set_contrast_in_background() {
    pkill -f "ddcutil.*setvcp 12"
    (ddcutil --display $DISPLAY_NUM setvcp 12 $1) &
}

if [ ! -f "$STATE_FILE" ]; then
    initial_contrast=$(ddcutil --display $DISPLAY_NUM getvcp 12 -t | cut -d ' ' -f 4)
    echo "$initial_contrast" > "$STATE_FILE"
fi

current=$(cat "$STATE_FILE")

case "$1" in
    "get")
        echo " $current"
        ;;
    "up")
        new_contrast=$((current + STEP > 100 ? 100 : current + STEP))
        if [ "$current" -ne "$new_contrast" ]; then
            echo "$new_contrast" > "$STATE_FILE"
            set_contrast_in_background "$new_contrast"
        fi
        pkill -RTMIN+8 waybar # Can add whatever RTMIN+n you please, as long as it's an integer. Make sure the signals match between the config and script.
        ;;
    "down")
        new_contrast=$((current - STEP < 0 ? 0 : current - STEP))
        if [ "$current" -ne "$new_contrast" ]; then
            echo "$new_contrast" > "$STATE_FILE"
            set_contrast_in_background "$new_contrast"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "right_click")
	new_contrast=0
	if [ "$current" -ne "$new_contrast" ]; then
            echo "$new_contrast" > "$STATE_FILE"
            set_contrast_in_background "$new_contrast"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "left_click")
	new_contrast=100
     	if [ "$current" -ne "$new_contrast" ]; then
            echo "$new_contrast" > "$STATE_FILE"
            set_contrast_in_background "$new_contrast"
        fi
        pkill -RTMIN+8 waybar
        ;;
esac

