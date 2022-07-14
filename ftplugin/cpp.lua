local lspconfig = require('lspconfig')

local mwclangd = require('user.lsp.mwclangd')
local mwccls = require('user.lsp.mwccls')

local filePath = vim.fn.expand('<abuf>:p:h')
local mwRootDir = lspconfig.util.root_pattern('mw_anchor')(filePath)

if not mwRootDir then
    mwclangd.startClangd()
    return
end

mwclangd.setup(mwRootDir)
mwccls.setup(mwRootDir)
