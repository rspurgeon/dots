-- Silence known noisy/deprecated startup messages early
-- Ensure packer and plugin specs load so :Packer* commands exist
pcall(require, "rick.packer")
require("rick.remap")
require("rick.set")
