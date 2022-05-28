-- Setup for very simple to configure plugins

local function setup(pluginName, opts)
    local status_ok, plugin = pcall(require, pluginName)
    if not status_ok then
        return
    end
    plugin.setup(opts)
end

setup('gitsigns', {})
