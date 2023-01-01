require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "lua", "python", "javascript", "markdown" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}

