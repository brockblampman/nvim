-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Plugins (configurations are in after/plugin/)
  use {
    'cameron-wags/rainbow_csv.nvim',
    config = function()
        require 'rainbow_csv'.setup()
    end,
    -- optional lazy-loading below
    module = {
        'rainbow_csv',
        'rainbow_csv.fns'
    },
    ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
    }
  }
  
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.8', requires = 'nvim-lua/plenary.nvim' }
  
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'mbbill/undotree'
  
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = { 
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      { 's1n7ax/nvim-window-picker', version = '2.*' }
    }
  }

  use 'sindrets/diffview.nvim'
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'ThePrimeagen/harpoon', branch = 'harpoon2', requires = 'nvim-lua/plenary.nvim' }
  use { 'kdheepak/lazygit.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'akinsho/bufferline.nvim', tag = '*', requires = 'nvim-tree/nvim-web-devicons' }
  
  use 'nvim-lua/plenary.nvim' -- don't forget to add this one if you don't have it yet!
  use 'tpope/vim-dadbod'                   -- Core database interface
  use 'kristijanhusak/vim-dadbod-ui'       -- UI for exploring databases
  use 'kristijanhusak/vim-dadbod-completion' 

  use {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    config = function()
      require('render-markdown').setup({
        render_modes = { 'n', 'c', 't', 'i' },
        enabled = true,
      })
    end
  }

end)
