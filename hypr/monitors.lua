-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- External Dell (DP-4) to the left, laptop (eDP-1) to the right.
-- DP-4 is 3840x2160 @ scale 1.6 -> logical width 2400, so eDP-1 starts at x=2400.
hl.monitor({ output = "DP-4", mode = "preferred", position = "0x0", scale = omarchy_monitor_scale })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "2400x0", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
