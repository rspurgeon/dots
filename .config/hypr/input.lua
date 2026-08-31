hl.config({
  input = {
    follow_mouse = 2,
    kb_layout = "us",
    kb_options = "ctrl:nocaps,altwin:swap_alt_win",
    repeat_rate = 20,
    repeat_delay = 600,
    numlock_by_default = true,

    touchpad = {
      scroll_factor = 0.4,
    },
  },
})

-- Preserve terminal-specific touchpad scrolling.
o.window("(Alacritty|kitty)", { scroll_touchpad = 1.5 })
o.window("com\\.mitchellh\\.ghostty", { scroll_touchpad = 0.2 })
