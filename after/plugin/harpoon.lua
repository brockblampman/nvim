local harpoon = require("harpoon")

-- CONFIGURATION: Add your harpoon lists here
local harpoon_lists = {
    { name = "default", key = "1" },
    { name = "IA_ADMIN Report", key = "2" },
    { name = "ICRP Security", key = "3" },
    { name = "Missing Metadata FKs", key = "4" },
    { name = "DegreeWorks", key = "5" },
    { name = "RClone Dist", key = "6" },
    { name = "Claude DuckDB", key = "7" },
    { name = "Finances", key = "8" },
    { name = "Workouts", key = "9" },
}

local lists = {}

-- Function to get persistent mode from file
local function get_persistent_mode()
    local mode_file = vim.fn.stdpath('data') .. '/harpoon_mode.txt'
    local file = io.open(mode_file, 'r')
    if file then
        local mode = file:read('*line')
        file:close()
        return mode or "default"
    end
    return "default"
end

-- Function to save mode to file
local function save_persistent_mode(mode)
    local mode_file = vim.fn.stdpath('data') .. '/harpoon_mode.txt'
    local file = io.open(mode_file, 'w')
    if file then
        file:write(mode)
        file:close()
    end
end

-- Global variable to control mode (now persistent)
_G.harpoon_mode = get_persistent_mode()

-- Initialize lists dynamically
for _, list_config in ipairs(harpoon_lists) do
    lists[list_config.name] = harpoon:list(list_config.name)
end

-- Populate default list with harpoon list names (as virtual files)
local default_list = lists["default"]
default_list:clear()
for _, list_config in ipairs(harpoon_lists) do
    if list_config.name ~= "default" then
        default_list:add({
            value = list_config.name,
            context = {
                row = 1,
                col = 1
            }
        })
    end
end

-- Setup with basic configuration
harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    }
})

-- Helper function to get current list
local function get_current_list()
    return lists[_G.harpoon_mode] or lists["default"]
end

-- Helper function to open all files in a list
local function open_all_files_in_list(list_name)
    if list_name == "default" then return end
    
    local list = lists[list_name]
    local items = list.items or {}
    
    for _, item in ipairs(items) do
        if item.value and item.value ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(item.value))
        end
    end
end

-- Custom select function for default list
local function custom_select(list, index)
    if _G.harpoon_mode == "default" then
        local item = list:get(index)
        if item and item.value then
            -- Switch to the selected list mode
            _G.harpoon_mode = item.value
            save_persistent_mode(item.value)
            print("Harpoon mode: " .. item.value)
            -- Open all files in the selected list
            open_all_files_in_list(item.value)
        end
    else
        -- Normal select behavior for other lists
        list:select(index)
    end
end

-- Basic keymaps
vim.keymap.set("n", "<leader>ha", function() get_current_list():add() end)
vim.keymap.set("n", "<leader>hm", function() 
    local current_list = get_current_list()
    if _G.harpoon_mode == "default" then
        -- Override select behavior for default list
        local original_select = current_list.select
        current_list.select = function(self, index, ...)
            custom_select(self, index)
        end
    end
    harpoon.ui:toggle_quick_menu(current_list)
end)

-- Jump to default list and show menu
vim.keymap.set("n", "<leader>hn", function()
    _G.harpoon_mode = "default"
    save_persistent_mode("default")
    local current_list = get_current_list()
    -- Override select behavior for default list
    local original_select = current_list.select
    current_list.select = function(self, index, ...)
        custom_select(self, index)
    end
    harpoon.ui:toggle_quick_menu(current_list)
end)

-- Mode switching keymaps generated dynamically
for _, list_config in ipairs(harpoon_lists) do
    vim.keymap.set("n", "<leader>hl" .. list_config.key, function() 
        _G.harpoon_mode = list_config.name
        save_persistent_mode(list_config.name)
        print("Harpoon mode: " .. list_config.name)
        -- Open all files in the selected list
        open_all_files_in_list(list_config.name)
    end)
end

