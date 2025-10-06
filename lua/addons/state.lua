local M = {}

-- Path to store addon state
local state_file = vim.fn.stdpath("data") .. "/addon_state.json"

-- Load addon state from JSON file
function M.load()
    local file = io.open(state_file, "r")
    if not file then
        return {} -- Return empty state if file doesn't exist
    end

    local content = file:read("*a")
    file:close()

    local ok, decoded = pcall(vim.json.decode, content)
    if ok and decoded then
        return decoded
    end
    return {}
end

-- Save addon state to JSON file
function M.save(state)
    local encoded = vim.json.encode(state)
    local file = io.open(state_file, "w")
    if file then
        file:write(encoded)
        file:close()
    end
end

-- Toggle a specific addon
function M.toggle(addon_name)
    local state = M.load()
    state[addon_name] = not state[addon_name]
    M.save(state)

    local status = state[addon_name] and "enabled" or "disabled"
    vim.notify(
        string.format("Addon '%s' %s. Restart Neovim to apply changes.", addon_name, status),
        vim.log.levels.INFO
    )
end

-- Check if an addon is enabled
function M.is_enabled(addon_name)
    local state = M.load()
    return state[addon_name] == true
end

return M

