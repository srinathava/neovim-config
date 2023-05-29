return function()
    require('lualine').setup({
        sections = {
            lualine_c = {
                { 'filename', path = 1, symbols = { readonly = '[RO]' } }
            }
        },
        theme = 'tokyonight'
    })
end

