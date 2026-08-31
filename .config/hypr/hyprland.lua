-- Omarchy Quattro user configuration.
-- Package defaults load first; these small modules contain only intentional
-- overrides so future Omarchy updates can continue improving the defaults.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

require("default.hypr.omarchy")

require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")
require("hypr.workspaces")
require("hypr.windows")

require("default.hypr.toggles")
