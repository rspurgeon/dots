local custom_auto = require'lualine.themes.auto'

custom_auto.normal.c.bg = custom_auto.normal.b.bg
custom_auto.insert.c.bg = custom_auto.insert.b.bg
custom_auto.visual.c.bg = custom_auto.visual.b.bg
custom_auto.replace.c.bg = custom_auto.replace.b.bg
custom_auto.normal.c.fg = custom_auto.normal.b.fg
custom_auto.insert.c.fg = custom_auto.insert.b.fg
custom_auto.visual.c.fg = custom_auto.visual.b.fg
custom_auto.replace.c.fg = custom_auto.replace.b.fg

local inactive_color = {
    fg = custom_auto.normal.b.fg,
    bg = custom_auto.normal.b.bg,
}

require('lualine').setup {
    extensions = {'neo-tree', 'fugitive'},
    options = {
        theme = custom_auto,
    },
    sections = {
        lualine_c = {
            { 'filename', path = 1, shorting_target = 25}
        },
        lualine_x = { 'filetype'},
    },
    inactive_sections = {
        lualine_a = {
            {
                color = inactive_color,
            }
        },
        lualine_b = {
            {
                'branch',
                icon = '',
                color = inactive_color,
            }
        },
        lualine_c = {
         {
            'filename',
            path = 1,
            color = inactive_color,
        }
        },
        lualine_x = {
            {
                'filetype',
                color = inactive_color,
            }
        },
        lualine_y = {
            {
                'progress',
                color = inactive_color,
            }
        },
        lualine_z = {
            {
                'location',
                color = inactive_color,
            }
        },
    }
}

