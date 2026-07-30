hl.window_rule({
    name  = "windowrule-1",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "windowrule-2",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "windowrule-3",
    match = {
        class = "^(firefox)$",
        title = "^(Picture-in-Picture)$",
    },
    float = true,
    pin   = true,
})

hl.window_rule({
    name    = "windowrule-4",
    match   = { class = "^(ghostty)$" },
    opacity = "0.3 0.4",
})

hl.window_rule({
    name    = "windowrule-5",
    match   = { class = "^(obsidian)$" },
    opacity = "0.85 0.85",
})

hl.window_rule({
    name    = "windowrule-6",
    match   = { class = "^(org.gnome.Nautilus)$" },
    opacity = "0.85 0.85",
})

hl.window_rule({
    name  = "windowrule-7",
    match = { class = "^(xwaylandvideobridge)$" },

    no_anim          = true,
    no_initial_focus = true,
    max_size         = "1 1",
    no_blur          = true,
    no_focus         = true,
    opacity          = "0.0 override",
})

hl.window_rule({
    name  = "windowrule-8",
    match = { class = "^(org%.pulseaudio%.pavucontrol)$" },
    float = true,
    size  = "800 600",
    center = true,
})
