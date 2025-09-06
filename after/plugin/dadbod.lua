vim.g.dbs = {
  duckdb = "duckdb:~/pds/utils/_pds.duckdb"
}


local function db_new_query_with_limit()
  vim.cmd('DB')
  vim.schedule(function()
    -- Make the buffer modifiable
    vim.bo.modifiable = true
    
    local lines = {
      '-- ',
      'select *',
      'from table_name',
      '',
      '',
      '',
      'limit 10;'
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {3, 8})  -- Position cursor on the 'b' in 'table_name'
  end)
end

vim.api.nvim_create_user_command('DBLimit', db_new_query_with_limit, {})
vim.keymap.set('n', '<leader>dd', db_new_query_with_limit, { desc = 'New DB query with LIMIT 10' })
local function create_db_query_direct()
  -- Create new split with SQL buffer and set up keymaps for execution
  vim.cmd('vsplit')
  vim.cmd('enew')
  vim.bo.filetype = 'sql'
  vim.b.db = 'duckdb:~/pds/utils/_pds.duckdb'
  
  -- Instead of relying on :w, add a keymap to execute queries
  vim.keymap.set('n', '<leader><CR>', '<cmd>%DB<cr>', { buffer = true, desc = 'Execute SQL query' })
  vim.keymap.set('v', '<leader><CR>', ':DB<cr>', { buffer = true, desc = 'Execute selected SQL' })
  
  vim.schedule(function()
    local lines = {
      '-- ',
      'select *',
      'from table_name',
      '',
      '',
      '',
      'limit 10;'
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {3, 8})
  end)
end

vim.keymap.set('n', '<leader>db', create_db_query_direct, { desc = 'Create new DB query directly' })
vim.keymap.set('n', '<leader>dbt', ':DBUIToggle<CR>', { desc = 'Toggle DBUI' })
