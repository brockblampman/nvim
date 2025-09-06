vim.api.nvim_set_keymap('n', '<leader>do', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>dn', ':diffthis<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dm', ':diffoff<CR>', { noremap = true, silent = true })
local function disable_diff_all_buffers()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_set_option(buf, 'diff', false)
    end
  end
  vim.api.nvim_set_current_win(current_win)
  vim.api.nvim_set_current_buf(current_buf)
end
vim.api.nvim_set_keymap('n', '<leader>dk', '', { noremap = true, silent = true, callback = disable_diff_all_buffers })


vim.opt.diffopt:append({
  'iwhite',      -- ignore whitespace changes
  'iblank',      -- ignore blank lines
  'algorithm:patience'  -- often better diff algorithm
})
