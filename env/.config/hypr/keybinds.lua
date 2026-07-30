local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local menucalc    = "rofi -show calc"
local menuemoji   = "rofi -show emoji"
local mainMod     = "SUPER"

-- System
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("DEV_ENV=/home/shivam/personal/dev ~/personal/dev/dev-env && hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + C",         hl.dsp.exec_cmd(menucalc))
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd(menuemoji))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("waypaper --random --backend awww"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy && notify-send \"Screenshot\" \"Copied to clipboard\""))
hl.bind("Print",                   hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/full_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot\" \"Fullscreen saved\""))
hl.bind("SHIFT + Print",           hl.dsp.exec_cmd("grim -g \"$(slurp -o -r -c '##ff0000ff')\" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"))

hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd("hyprpicker | wl-copy"))

-- Brightness
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("$HOME/.local/scripts/new_brightness_control.sh up"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("$HOME/.local/scripts/new_brightness_control.sh down"))

-- Clean up and Update
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("ghostty -e bash -c \"$HOME/.local/scripts/clean_system.sh\""))

-- Applications
hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(terminal .. " -e bash -c \"tmux\""))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("brave"))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down"  }))

-- Move windows with mainMod + CONTROL + vim keys
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.move({ direction = "down"  }))

-- Switch workspaces and move windows with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
