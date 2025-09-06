require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--ignore-case",
      "--trim",           -- Removes leading/trailing whitespace from search results
      "--hidden",         -- Searches hidden files (respects .rgignore)
    },
    case_mode = "ignore_case",
    mappings = {
      i = {
        ["<C-u>"] = require('telescope.actions').preview_scrolling_up,
        ["<C-d>"] = require('telescope.actions').preview_scrolling_down,
      },
      n = {
        ["<C-u>"] = require('telescope.actions').preview_scrolling_up,
        ["<C-d>"] = require('telescope.actions').preview_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      sorter = require('telescope.sorters').get_substr_matcher(),
      case_mode = "ignore_case",
    },
    live_grep = {
      additional_args = function(opts)
        return { "--trim", "--ignore-case" }
      end
    },
    grep_string = {
      case_mode = "ignore_case",
    },
    git_files = {
      case_mode = "ignore_case",
    },
  },
})


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>pof', function()
  require('telescope.builtin').find_files({ 
    cwd = '~/OTS/ods', 
    case_mode = "ignore_case",
    sorter = require('telescope.sorters').get_fzy_sorter({ case_mode = "ignore_case" })
  })
end, { desc = 'Find files in first directory' })

vim.keymap.set('n', '<leader>pif', function()
  require('telescope.builtin').find_files({ 
    cwd = '~/pds/utils/sql_codebases', 
    case_mode = "ignore_case",
    sorter = require('telescope.sorters').get_fzy_sorter({ case_mode = "ignore_case" })
  })
end, { desc = 'Find files in first directory' })

vim.keymap.set('n', '<leader>puf', function()
  require('telescope.builtin').find_files({ 
    cwd = '~/pds/personal/upgrade', 
    case_mode = "ignore_case",
    sorter = require('telescope.sorters').get_fzy_sorter({ case_mode = "ignore_case" })
  })
end, { desc = 'Find files in first directory' })

vim.keymap.set('n', '<leader>pos', function()
  require('telescope.builtin').live_grep({ cwd = '~/OTS/ods', case_mode = "ignore_case" })
end, { desc = 'Live grep in ods directory' })

vim.keymap.set('n', '<leader>pis', function()
  require('telescope.builtin').live_grep({ cwd = '~/pds/utils/sql_codebases', case_mode = "ignore_case" })
end, { desc = 'Live grep in idr directory' })

vim.keymap.set('n', '<leader>pus', function()
  require('telescope.builtin').live_grep({ cwd = '~/pds/personal/upgrade', case_mode = "ignore_case" })
end, { desc = 'Live grep in upgrade directory' })

vim.keymap.set('n', '<leader>s', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep files' })

-- Open terminal with Claude Code in current file's directory
vim.keymap.set('n', '<leader>c', function()
  local file_dir = vim.fn.expand('%:p:h')
  vim.cmd('vsplit | terminal')
  vim.fn.chansend(vim.b.terminal_job_id, 'cd "' .. file_dir .. '" && claude code\n')
end, { desc = 'Open terminal with Claude Code in current file directory' })
