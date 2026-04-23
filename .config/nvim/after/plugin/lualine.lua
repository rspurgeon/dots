local ok, lualine = pcall(require, 'lualine')
if not ok then
    return
end

local palette = {
    dark = "#000F06",
    panel = "#000F06",
    panel_alt = "#4A4D49",
    text = "#B7BDB5",
    text_dim = "#676B66",
    teal = "#6B9E8A",
}

local active = {
    bg = palette.teal,
    fg = palette.dark,
    gui = "bold",
}

local panel = {
    bg = palette.panel,
    fg = palette.text,
}

local panel_alt = {
    bg = palette.panel_alt,
    fg = palette.text,
}

local inactive = {
    bg = palette.panel,
    fg = palette.text_dim,
}

local tmux_theme = {
    normal = { a = active, b = panel, c = panel },
    insert = { a = active, b = panel, c = panel },
    visual = { a = active, b = panel, c = panel },
    replace = { a = active, b = panel, c = panel },
    command = { a = active, b = panel, c = panel },
    inactive = { a = inactive, b = inactive, c = inactive },
}

lualine.setup {
    extensions = {'neo-tree', 'fugitive'},
    options = {
        globalstatus = true,
        theme = tmux_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            {
                'mode',
                fmt = function(str)
                    return ' ' .. str .. ' '
                end,
            }
        },
        lualine_b = {
            { 'branch', icon = '' }
        },
        lualine_c = {
            { 'filename', path = 1, shorting_target = 40 }
        },
        lualine_x = {
            { 'filetype', color = panel_alt }
        },
        lualine_y = {
            { 'progress', color = panel }
        },
        lualine_z = {
            { 'location', color = active }
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            { 'filename', path = 1, color = inactive }
        },
        lualine_x = {
            { 'filetype', color = inactive }
        },
        lualine_y = {},
        lualine_z = {},
    }
}
