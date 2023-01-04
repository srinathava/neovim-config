return function()
    local vault = '/mathworks/devel/sandbox/savadhan/obsidian/work_stuff'
    if vim.fn.filereadable(vault) == 0 then
        return
    end
    require("obsidian").setup({
        dir = vault,
        completion = {
            nvim_cmp = true
        }
    })
end
