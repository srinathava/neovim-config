local wk = require("which-key")

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
  }
}, { prefix = "<space>" })
