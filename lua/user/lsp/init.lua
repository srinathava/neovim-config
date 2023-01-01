local lspconfig = require('lspconfig')
local lspinstaller = require('nvim-lsp-installer')
local configs = require 'lspconfig.configs'
local opts = require('user.lsp.opts')

-- LSP servers which are do not special configuration for mw specific files
local servers = {"pyright", "sumneko_lua", "cssls", "emmet_ls", "tsserver", "rust_analyzer", "bashls"}

lspinstaller.setup {
    ensure_installed = servers
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

for _, name in pairs(servers) do
    lspconfig[name].setup(opts(name))
end
