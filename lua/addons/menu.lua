local state = require("addons.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

-- Define available addons
local addons = {
    { name = "lsp",         display = "Code Completion setup (Language Server Support, Code Completion, Formatting...)" },
    { name = "compiler",    display = "Compiler (Build & Run)" },
    { name = "rust",        display = "Rust Extras (Rustacean & extended Cargo Support)" },
    { name = "java",        display = "Java Extras (Extended Java Support + Debug)" },
    { name = "typst",       display = "Typst markup support (Live Preview & Compilation)" },
    { name = "code-extras", display = "Code Addons (Codelens & Hints & breadcrumbs)" },
    { name = "git-extras",  display = "Lazygit Neovim Integration (Graphical Git Helper)" },
}

-- Create custom telescope picker
function M.show()
    local current_state = state.load()

    -- Build entries with current status
    local entries = {}
    for _, addon in ipairs(addons) do
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
