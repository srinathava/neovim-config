local lspconfig = require('lspconfig')
local lspinstaller = require('nvim-lsp-installer')
local handlers = require('user.lsp.handlers')

handlers.setup()

local myservers = {"pyright", "sumneko_lua", "clangd"}

lspinstaller.setup {
    ensure_installed = myservers
}

for _, name in pairs(myservers) do
    local common_opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    local total_opts = common_opts
    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. name)
    if has_custom_opts then
        total_opts = vim.tbl_deep_extend("force", server_custom_opts, common_opts)
    end
    lspconfig[name].setup(total_opts)
end
