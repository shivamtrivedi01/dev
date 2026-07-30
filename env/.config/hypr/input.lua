hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:caps_toggle",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "adaptive",
        touchpad = {
            natural_scroll = false,
            disable_while_typing = false,
        },
    },
})

hl.device({
    name = "tpps/2-elan-trackpoint",
    accel_profile = "flat",
})

-- hl.device({
--     name = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })
