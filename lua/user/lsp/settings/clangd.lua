local lspconfig = require('lspconfig')
return {
    cmd = {
        "/mathworks/hub/share/sbtools/external-apps/llvm/llvm-13.0.0/install/deb11-64/bin/clangd",
        "--header-insertion=never",
        "--completion-parse=auto",
        "-j=12"
    },
    filetypes = {"c", "cpp", "cuda", "objc", "objcpp"},
    root_dir =  lspconfig.util.root_pattern("mw_anchor", ".git"),
    offset_encodings = { "utf-8" }
}
