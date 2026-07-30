local function load_wal_colors()
    local colors = {}
    local f = io.open(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.conf", "r")
    if f then
        for line in f:lines() do
            local name, value = line:match("^%$([%w_]+)%s*=%s*(.+)$")
            if name and value then
                colors[name] = value
            end
        end
        f:close()
    end
    return colors
end

local wal = load_wal_colors()

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 8,
        border_size = 1,
        col = {
            active_border   = wal.foreground or "rgba(ffffffcc)",
            inactive_border = wal.color1 or "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 3,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled  = true,
            size     = 5,
            passes   = 3,
            vibrancy = 0.1696,
        },
        shadow = {
            enabled         = true,
            range           = 20,
            render_power    = 3,
            color           = "rgba(171717aa)",
            color_inactive  = "rgba(101010aa)",
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
    },
})
