-- KEYMAP INDEX / CHEAT SHEET
-- =========================
-- CORE SETUP
--   <leader> = <Space>
--   <Esc> (terminal mode) = Exit terminal mode
--
-- INSERT MODE NAVIGATION (macOS Option+hjkl)
--   Option+h = Left    │ Option+j = Down
--   Option+k = Up      │ Option+l = Right
--
-- GIT & EXTERNAL TOOLS
--   <leader>gg = LazyGit in new tab
--   <leader>pv = NetRW file explorer
--   Option-Caps = LazyGit Escape
--
-- TERMINAL MANAGEMENT
--   <leader>tm = New terminal
--   <leader>tb = Terminal in bottom split
--   <leader>rt = Jump to terminal buffer
--
-- DISPLAY TOGGLES
--   <leader>wr = Toggle word wrap
--
-- BUFFER MANAGEMENT
--   <leader>bd = Close buffer (smart)
--   <leader>D  = Delete all buffers
--
-- WINDOW MANAGEMENT
--   <leader>wc = Close window
--   <leader>wh/j/k/l = Navigate windows
--   <leader>wn = Open todo in new split
--   <leader>w<arrows> = Resize windows
--
-- CLIPBOARD & FILE OPERATIONS
--   <Cmd-v> (cmd mode) = Paste from clipboard
--   <leader>y = Yank word under cursor
--   <leader>p = Replace word with paste
--
-- RAINBOW CSV (when viewing CSV files)
--   <leader>rd = Rainbow delimiter simple
--   <leader>rl = Rainbow lint
--   <leader>ra = Rainbow align
--   <leader>rs = Rainbow shrink
--
-- TIMER CONTROLS
--   <leader>t5  = 5 minute timer
--   <leader>t15 = 15 minute timer
--   <leader>t25 = 25 minute timer (Pomodoro)
--   <leader>tc  = Custom timer
--   <leader>ts  = Stop timer
-- =========================

-- CORE SETUP
vim.g.mapleader = " " 
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- INSERT MODE NAVIGATION (macOS Option+hjkl)
vim.api.nvim_set_keymap('i', '˙', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '∆', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '˚', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '¬', '<Right>', { noremap = true, silent = true })

-- GIT & EXTERNAL TOOLS
vim.keymap.set('n', '<leader>gg', function()
  vim.cmd('tabnew')  
  vim.cmd('terminal lazygit')
  vim.cmd('startinsert')
end, { desc = 'LazyGit in terminal' })
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*lazygit',
    callback = function()
        vim.keymap.set('t', '<A-Esc>', '<Esc>', { buffer = true })
    end
})
vim.keymap.set("n","<leader>pv", vim.cmd.Ex) -- NetRW, vim's default directory explorer.  Good to have/know.

-- TERMINAL MANAGEMENT
vim.api.nvim_set_keymap('n', '<leader>tm', ':terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tb', ':belowright split | terminal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rt', ':b term<CR>', { desc = 'Jump to terminal buffer' })

-- DISPLAY TOGGLES
vim.api.nvim_set_keymap('n', '<leader>wr', ':set wrap!<CR>', { noremap = true, silent = true })

-- BUFFER MANAGEMENT
local function close_buffer_not_pane()
  if vim.bo.modified then
    print("Buffer has unsaved changes. Save first or use :bd! to force close.")
    return
  end
  local current_buf = vim.fn.bufnr('%')
  local buffer_list = vim.tbl_filter(function(buf)
    return vim.fn.buflisted(buf) == 1
  end, vim.fn.range(1, vim.fn.bufnr('$')))
  if #buffer_list <= 1 then
    vim.cmd('enew')
  else
    local idx = -1
    for i, buf in ipairs(buffer_list) do
      if buf == current_buf then
        idx = i
        break
      end
    end
    if idx ~= -1 then
      -- Get next buffer, or loop to first if at end
      local next_idx = (idx % #buffer_list) + 1
      vim.cmd('buffer ' .. buffer_list[next_idx])
    end
  end
  
  vim.cmd('bdelete ' .. current_buf)
end
vim.keymap.set('n', '<Leader>bd', close_buffer_not_pane, { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>D', ':%bd!<CR>', { noremap = true, silent = true, desc = 'Delete buffer' })

-- WINDOW MANAGEMENT
vim.api.nvim_set_keymap('n', '<leader>wc', ':close<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wn', function()
  vim.cmd('rightbelow vnew ~/pds/personal/_todo.md')
end, { noremap = true, silent = true })
local keymap = vim.keymap.set
keymap('n', '<leader>w<Up>', ':resize +10<CR>', { desc = 'Increase window height' })
keymap('n', '<leader>w<Down>', ':resize -10<CR>', { desc = 'Decrease window height' })
keymap('n', '<leader>w<Left>', ':vertical resize +20<CR>', { desc = 'Decrease window width' })
keymap('n', '<leader>w<Right>', ':vertical resize -20<CR>', { desc = 'Increase window width' })

-- CLIPBOARD & FILE OPERATIONS
vim.keymap.set('c', '<D-v>', '<C-r>+', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', 'yiw', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', 'viwp', { noremap = true, silent = true })

-- TIMER CONTROLS
vim.keymap.set("n", "<leader>t5", function() _G.timer.start_countdown(5) end, { desc = "5 min timer" })
vim.keymap.set("n", "<leader>t15", function() _G.timer.start_countdown(15) end, { desc = "15 min timer" })
vim.keymap.set("n", "<leader>t25", function() _G.timer.start_countdown(25) end, { desc = "25 min timer" })
vim.keymap.set("n", "<leader>tc", function()
  local minutes = vim.fn.input("Timer minutes: ")
  minutes = tonumber(minutes)
  if minutes and minutes > 0 then
    _G.timer.start_countdown(minutes)
  end
end, { desc = "Custom timer" })
vim.keymap.set("n", "<leader>ts", function() _G.timer.stop_countdown() end, { desc = "Stop timer" })





