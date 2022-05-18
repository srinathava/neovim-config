if vim.g['cpp_started_ccls_server'] then
    return
end

local lspconfig = require('lspconfig')

local filePath = vim.fn.expand('<abuf>:p:h')
local mwRootDir = lspconfig.util.root_pattern('mw_anchor')(filePath)
if not mwRootDir then
    return
end

local cclsCachePath = mwRootDir .. '/.sbtools/sbcpptags/ccls'
if not vim.fn.filereadable(cclsCachePath) then
    return
end

local job = require('plenary.job')
    job:new({
        command = 'sbcpptags',
        args = {'--ccls-cmd'},
        cwd = mwRootDir,
        on_exit = function(j, exit_code)
            if exit_code ~= 0 then
                return
            end
            vim.defer_fn(function()
                local res = table.concat(j:result(), "")
                local tokens = vim.fn.split(res, " ")
                local ccls_cmd = tokens[2]
                local init_opts = vim.fn.json_decode(vim.fn.matchstr(tokens[3], "'--init=\\zs{.*}\\ze'"))

                lspconfig.ccls.setup({
                    cmd = {ccls_cmd},
                    filetypes = {"c", "cpp", "cuda", "objc", "objcpp"},
                    root_dir =  lspconfig.util.root_pattern('mw_anchor'),
                    init_options = init_opts,
                    offset_encoding = {"utf-8"},
                })
                vim.g['cpp_started_ccls_server'] = true
            end, 0)
        end,
    }):start()
