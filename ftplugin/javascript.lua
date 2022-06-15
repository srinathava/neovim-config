local lspconfig = require('lspconfig')

local filePath = vim.fn.expand('<abuf>:p:h')
local mwRootDir = lspconfig.util.root_pattern('mw_anchor')(filePath)
if not mwRootDir then
    return
end

local nls = require("null-ls")

local Job = require('plenary.job')
Job:new({
    command = 'mw',
    args = {"mwjslint", "--version"},
    cwd = mwRootDir,
    on_exit = function(jobObj, exit_code)
        if exit_code ~= 0 then
            print(vim.inspect(jobObj:stderr_result()))
            return
        end
        vim.defer_fn(function()
            local res = table.concat(jobObj:result(), "")
            local config_file = vim.fn.matchstr(res, "--config \\zs[^ ]*\\ze")
            nls.setup {
                sources = {
                    nls.builtins.diagnostics.eslint_d.with {
                        extra_args = { "-c", config_file }
                    }
                }
            }

        end, 0)
    end,
}):start()
