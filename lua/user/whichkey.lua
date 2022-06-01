local wk = require("which-key")
local Terminal = require('toggleterm.terminal').Terminal

-- https://stackoverflow.com/questions/6380820/get-containing-path-of-lua-file
local function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

local cmd = 'lazygit'
if vim.fn.executable('nvr') then
    -- If nvr is found, then use it within neovim
    cmd = 'lazygit -ucf ~/.config/lazygit/config.yml,'..script_path()..'lazygit_nvr.yml'
end
cmd = "VIM= VIMRUNTIME= "..cmd

local lazygit = Terminal:new({
    cmd = cmd,
    hidden = true,
    direction = "float"
})
function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

-- timeoutlen of a reasonably small number works best to bring up the
-- window for not so frequently used shortcuts "fast enough"
vim.o.timeoutlen = 200

wk.setup()
wk.register({
  m = {
    name = "MathWorks",
    c = { "<cmd>MWCompileProject<cr>", "Compile current project" },
    o = { "<cmd>MWOpenFile<cr>", "Open file" },
  },
  t = {
    name = "Terminal",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Floating" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
  },
  g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" }
}, { prefix = "<space>" })
