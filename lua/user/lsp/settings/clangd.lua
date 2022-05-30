local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    cmd = {
        "clangd",
        "--header-insertion=never",
        "--completion-parse=auto",
        "-j=12"
    },
    filetypes = {"c", "cpp", "cuda", "objc", "objcpp"},
    root_dir =  lspconfig.util.root_pattern("mw_anchor", ".git"),
    offset_encodings = { "utf-8" },
    capabilities = capabilities
}
