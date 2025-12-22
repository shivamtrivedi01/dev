#!/bin/bash
LOCK=/tmp/brightness-lock
CACHE=/tmp/backlight-value
STEP=${2:-5}
DISPLAYS=(1 2)
MAX=100

exec 9>"$LOCK" || exit
flock -n 9 || exit

# Load cached brightness or initialize once
if [[ -f "$CACHE" ]]; then
  read -r current < "$CACHE"
else
  # ONE-TIME slow call
  raw=$(ddcutil getvcp 10 2>/dev/null)
  current=${raw##*current value = }
  current=${current%%,*}
fi

# Calculate new brightness
if [[ "$1" == "inc" ]]; then
  new=$((current + STEP))
else
  new=$((current - STEP))
fi

# Clamp
(( new > MAX )) && new=$MAX
(( new < 0 )) && new=0

# Save cache
echo "$new" > "$CACHE"

# Apply brightness (fast path)
for d in "${DISPLAYS[@]}"; do
  ddcutil setvcp 10 "$new" -d "$d" --noverify >/dev/null 2>&1 &
done
wait
