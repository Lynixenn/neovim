local state = require("addons.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

-- Dynamic Addon Scanner
local function get_available_addons()
    local addons = {}
    local addon_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/addons/modules", "*.lua", true, true)

    for _, file_path in ipairs(addon_files) do
        local addon_name = vim.fn.fnamemodify(file_path, ":t:r")
        local ok, addon_config = pcall(require, "addons.modules." .. addon_name)

        if ok and addon_config and addon_config.display then
            table.insert(addons, {
                name = addon_name,
                display = addon_config.display,
            })
        end
    end
    return addons
end

-- Telescope picker
function M.show()
    local available_addons = get_available_addons()
    local current_state = state.load()

    local entries = {}
    for _, addon in ipairs(available_addons) do
        local enabled = current_state[addon.name]
        local icon = enabled and "✓" or "✗"
        local status = enabled and "(enabled)" or "(disabled)"
        table.insert(entries, {
            display = string.format("%s %s %s", icon, addon.display, status),
            name = addon.name,
            enabled = enabled,
        })
    end

    pickers.new({}, {
        prompt_title = "Toggle Addons (restart required)",
        finder = finders.new_table({
            results = entries,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.display,
                    ordinal = entry.display,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                    state.toggle(selection.value.name)
                end
            end)
            return true
        end,
    }):find()
end

return M

