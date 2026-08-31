hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 3,
    border_size = 2,
  },

  decoration = {
    rounding = 4,
  },

  misc = {
    -- Prevent terminal alerts and application activation requests from
    -- stealing focus.
    focus_on_activate = false,
  },

  xwayland = {
    force_zero_scaling = true,
  },
})
