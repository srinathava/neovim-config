local function root_dir()
    local bufdir = vim.fn.expand('%:p')
    if bufdir == "" then
        bufdir = vim.fn.getcwd()
    end
    return require('lspconfig').util.root_pattern('.git')(bufdir)
end

local function find_files()
    require('telescope.builtin').find_files({ cwd = root_dir() })
end

local function grep_files()
    require('telescope.builtin').live_grep({ cwd = root_dir() })
end

-- Telescope
return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
        {"<F4>", find_files},
        {"<leader>ff", find_files, desc = "Find files" },
        {"<leader>fs", grep_files, desc = "Search in files" },
        {"<F3>", "<CMD>Telescope buffers<CR>"}
    },
    -- This dependency allows FZF style completion, i.e., you can put
    -- spaces between characters etc.
    dependencies = {
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }
    },
    config = function()
        require('telescope').load_extension('fzf')
    end
}
