-- Pin workspaces to Avery's displays so Super+1..9 remains predictable.
for workspace = 1, 6 do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = "HDMI-A-1",
    default = workspace == 1,
    persistent = true,
  })
end

for workspace = 7, 9 do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = "DP-2",
    default = workspace == 7,
    persistent = true,
  })
end
