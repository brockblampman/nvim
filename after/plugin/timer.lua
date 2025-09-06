local M = {}

-- Timer state
local countdown_end = 0
local countdown_active = false

-- Update function
local function update_display()
  if countdown_active then
    local remaining = countdown_end - os.time()
    if remaining > 0 then
      local mins = math.floor(remaining / 60)
      local secs = remaining % 60
      _G.timer_display = string.format("%02d:%02d", mins, secs)
    else
      _G.timer_display = "🔴 DONE!"
      _G.timer_done = true
      countdown_active = false
      vim.notify("Timer finished!", vim.log.levels.INFO)
    end
  elseif not _G.timer_done then
    _G.timer_display = nil
  end
  
  -- Force bufferline to refresh
  vim.cmd('redrawtabline')
end

-- Start countdown
function M.start_countdown(minutes)
  countdown_end = os.time() + (minutes * 60)
  countdown_active = true
  vim.notify(string.format("Timer started: %d minutes", minutes))
end

-- Stop countdown
function M.stop_countdown()
  countdown_active = false
  _G.timer_display = nil
  _G.timer_done = false
  vim.notify("Timer stopped")
end

-- Update every second
vim.fn.timer_start(1000, update_display, {['repeat'] = -1})

-- Make timer functions globally accessible
_G.timer = M

return M