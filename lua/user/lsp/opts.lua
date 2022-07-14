local handlers = require('user.lsp.handlers')

handlers.setup()

return function (name)
    local common_opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    local total_opts = common_opts
    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. name)
    if has_custom_opts then
        total_opts = vim.tbl_deep_extend("force", server_custom_opts, common_opts)
    end

    return total_opts
end
