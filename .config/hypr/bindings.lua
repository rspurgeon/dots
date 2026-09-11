-- Preserve Avery's familiar bindings while retaining Quattro defaults for
-- everything not explicitly changed here.
local function rebind(keys, description, dispatcher, options)
  hl.unbind(keys)
  o.bind(keys, description, dispatcher, options)
end

-- Use Quattro's unified Omarchy launcher on Super+Space, with the dedicated
-- applications-only view available on Super+Alt+Space.
rebind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle")
rebind("SUPER + ALT + SPACE", "Apps menu", "omarchy-menu toggle apps")

-- Vim-style focus. Arrow-key focus is intentionally disabled as on Omarchy 3.
for _, keys in ipairs({
  "SUPER + LEFT",
  "SUPER + RIGHT",
  "SUPER + UP",
  "SUPER + DOWN",
}) do
  hl.unbind(keys)
end

rebind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
rebind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
rebind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
rebind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))

-- Vim-style swapping. These replace Quattro's Hardware, Herdr keybindings,
-- and Lock bindings on Super+Ctrl+H/K/L; those actions are relocated below.
rebind("SUPER + CTRL + H", "Swap window left", hl.dsp.window.swap({ direction = "l" }))
rebind("SUPER + CTRL + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
rebind("SUPER + CTRL + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
rebind("SUPER + CTRL + L", "Swap window right", hl.dsp.window.swap({ direction = "r" }))

-- Cycle windows rather than workspaces. Alt+Tab remains intentionally unused.
hl.unbind("ALT + TAB")
hl.unbind("ALT + SHIFT + TAB")
rebind("SUPER + TAB", "Cycle to next window", hl.dsp.window.cycle_next())

-- Preserve familiar application and utility entry points.
rebind("SUPER + SHIFT + RETURN", "Light terminal", { launch = "alacritty-light" })
rebind("SUPER + SHIFT + P", "Pitch", "pitch-view-float")
rebind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })
rebind("SUPER + SHIFT + R", "ghui", "ghui-float")

-- Activity remains on Super+Shift+T rather than Quattro's Super+Ctrl+T.
hl.unbind("SUPER + CTRL + T")
rebind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Keep Avery's keybinding help location.
rebind("SUPER + SHIFT + K", "Keybindings", "omarchy-menu-keybindings")

-- Preserve the solid Kong background shortcut and move Quattro's picker.
rebind("SUPER + CTRL + SPACE", "Kong background", "kong-bg")
rebind("SUPER + CTRL + ALT + SPACE", "Background picker", "omarchy-menu toggle background")

-- Relocated defaults displaced by Vim-style navigation.
rebind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
rebind("SUPER + CTRL + ALT + H", "Hardware menu", "omarchy-menu toggle hardware")
rebind("SUPER + CTRL + ALT + L", "Lock system", "omarchy-system-lock")

-- Quattro's Super+Ctrl+E emoji and Super+Ctrl+V clipboard bindings remain
-- enabled. The retired Super+Alt+R recording helper is intentionally omitted;
-- use Quattro's Alt+Print screen recording binding.
