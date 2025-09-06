require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "html", "python", "bash", "yaml","toml","ini","sql", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- Add this section to enable folding
  fold = {
    enable = true,
  },
  -- Optional: Add this if you want treesitter-based indentation
  indent = {
    enable = true,
  },
}

-- FOLDING CONFIGURATION
-- Global Tree-sitter folding settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99  -- Start with all folds open

-- FOLDING KEYMAPS (Built-in Vim)
-- za - Toggle fold under cursor
-- zR - Open all folds  
-- zM - Close all folds
-- zo - Open fold under cursor
-- zc - Close fold under cursor
-- zr - Reduce fold level (open one level)
-- zm - More folding (close one level)

-- Python-specific folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldlevel = 99  -- Start with all folds open
  end,
})
