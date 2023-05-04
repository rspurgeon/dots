local custom_auto = require'lualine.themes.auto'

custom_auto.normal.c.bg = custom_auto.normal.b.bg
custom_auto.insert.c.bg = custom_auto.insert.b.bg

require('lualine').setup {
    extensions = {'neo-tree', 'fugitive'},
    options = {
        theme = custom_auto
    },
    sections = {
        lualine_c = {
            { 'filename', path = 1, shorting_target = 25 }
        },
        lualine_x = { 'filetype' },
    }
}

