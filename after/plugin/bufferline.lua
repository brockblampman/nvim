require('bufferline').setup {
    options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        custom_areas = {
            right = function()
                local areas = {
                    { text = (_G.harpoon_mode or "default"), fg = "#8ec07c" },
                }
                if _G.timer_display then
                    table.insert(areas, { text = " | " .. _G.timer_display, fg = "#f6c177" })
                end
                return areas
            end,
        },
    }
}



vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
