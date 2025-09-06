require("todo-comments").setup({
  keywords = {
    BACKLOG = { icon = " "},
    NOW = { icon = " ", color = "error" },
    NEXT = { icon = " ", color = "warning" },
    JIRA = { icon = "󰗚 ", color = "info" },
    ARCHIVE = { icon = "󰄛 ", color = "hint" },
    PERSONAL = { icon = " ", color = "error" },
    },
  merge_keywords = true,
})



vim.api.nvim_set_keymap('n', '<leader>tt', ':TodoTelescope<CR>', { noremap = true, silent = true })
