-- Avery's two 4K displays. Positions are expressed in logical coordinates at
-- 1.25 scale; DP-2 is rotated 90 degrees.
hl.env("GDK_SCALE", "1")

hl.monitor({
  output = "HDMI-A-1",
  mode = "3840x2160@120",
  position = "0x672",
  scale = 1.25,
  transform = 0,
})

hl.monitor({
  output = "DP-2",
  mode = "3840x2160@60",
  position = "3072x0",
  scale = 1.25,
  transform = 1,
})
