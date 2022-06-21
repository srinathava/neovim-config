local lspconfig = require('lspconfig')
local lspinstaller = require('nvim-lsp-installer')
local handlers = require('user.lsp.handlers')
local configs = require 'lspconfig.configs'

handlers.setup()

local myservers = {"pyright", "sumneko_lua", "clangd", "emmet_ls", "cssls", "tsserver", "matlabls"}

lspinstaller.setup {
    ensure_installed = myservers
}

if not configs.matlabls then
    configs.matlabls = {
        default_config = {
            cmd = {
                "node",
                "/mathworks/inside/labs/dev/matlab_coder_tools/matlabls/matlabls/server/out/main.js",
                "--matlabLaunchCmdArgs=-nodisplay",
                "--stdio"
            },
            filetypes = {'matlab'},
            root_dir = lspconfig.util.root_pattern('mw_anchor'),
            single_file_support = false,
        },
        commands = {},
        docs = {
            description = [[
            Experimental matlabls server
            ]],
            default_config = {
                root_dir = [[
                root_pattern('mw_anchor')
                ]],
                capabilities = [[default capabilities]],
            },
        }
    }
end

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
