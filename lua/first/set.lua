-- NEOVIM SETTINGS INDEX
-- =====================
-- CORE EDITOR SETTINGS
--   Line numbers (absolute & relative)
--   Indentation (4 spaces, smart)
--   Search behavior (case, highlighting)
--   File handling (no swap, undo history)
--   Display (colors, scrolloff, signs)
--   Clipboard integration
--
--
-- THEME CUSTOMIZATION
--   Rose-pine color overrides
--   Markview plugin highlights
-- =====================

-- CORE EDITOR SETTINGS
vim.o.nu = true
vim.o.relativenumber = true
vim.opt.ignorecase = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.undoreload = 10000
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.updatetime = 50
vim.opt.clipboard:append("unnamedplus")

-- THEME CUSTOMIZATION
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "rose-pine*",
  callback = function()
    local p = require('rose-pine.palette')
    vim.api.nvim_set_hl(0, 'MarkviewHeading1', { fg = p.love, bold = true })
    vim.api.nvim_set_hl(0, 'MarkviewHeading2', { fg = p.foam, bold = true })
    vim.api.nvim_set_hl(0, 'MarkviewHeading3', { fg = p.rose, bold = true })
    vim.api.nvim_set_hl(0, 'MarkviewCode', { fg = p.foam, bg = p.surface })
    vim.api.nvim_set_hl(0, 'MarkviewTableHead', { fg = p.text, bg = p.overlay })
  end,
})

