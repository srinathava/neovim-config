local lspconfig = require('lspconfig')
local clangdopts = require('user.lsp.opts')('clangd')

local sbroots_processed = {}

local function startClangd()
    lspconfig.clangd.setup(clangdopts)

    if vim.b.mwclangd_triggered_filetype == nil then
        vim.b.mwclangd_triggered_filetype = true
        vim.cmd[[doautocmd FileType]]
    end
end

local function log(msg, level)
    vim.api.nvim_notify(msg, level, {})
end

local M = {}
M.setup = function(mwRootDir)
    if sbroots_processed[mwRootDir] ~= nil then
        return
    end
    sbroots_processed[mwRootDir] = true

    local compileCommandsPath = mwRootDir .. '/compile_commands.json'

    if vim.fn.filereadable(compileCommandsPath) ~= 0 then
        startClangd()
        return
    end

    log("mwclangd.setup: compile_commands.json does not exist. Running sbcompilecommands", vim.log.levels.WARN)
    local Job = require('plenary.job')
    Job:new({
        command = 'sbcompilecommands',
        args = {'-mods', '/mathworks/devel/sandbox/savadhan/sbtools/sfcore.cfg'},
        cwd = mwRootDir,
        on_exit = function(j, exit_code)
            if exit_code ~= 0 then
                error(j:stderr_result())
            end
            vim.defer_fn(function()
                log("mwclangd.setup: Done with sbcompilecommands. Starting clangd.", vim.log.levels.WARN)
                startClangd()
            end, 0)
        end,
    }):start()
end

M.startClangd = startClangd
return M
