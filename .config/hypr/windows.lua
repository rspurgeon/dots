-- Window rule syntax verified against the Hyprland Lua documentation used by
-- Omarchy Quattro. Static effects match initial window properties.

-- Preserve the existing Slack behavior when Slack opens as a floating window.
o.window("^Slack$", { center = true })

-- Pitch and ghui launch in centered floating terminals sized relative to the
-- focused monitor's logical dimensions (including rotated displays).
o.window("^org\\.omarchy\\.(pitch|ghui)$", {
  float = true,
  center = true,
  size = { "monitor_w * 0.5", "monitor_h * 0.55" },
})

-- Keep the ChatGPT web app at its familiar size and placement.
o.window("^(chromium|chrome)-chatgpt\\.com__-Default$", {
  float = true,
  center = true,
  size = { 1100, 900 },
})

-- Only the Zoom Workplace home window should float; meeting windows retain
-- Quattro's stock Zoom handling.
o.window({
  class = "^zoom$",
  initial_title = "^Zoom Workplace$",
  xwayland = true,
}, {
  float = true,
})
