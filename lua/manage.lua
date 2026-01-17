---@diagnostic disable: undefined-field
local M = {}
local plug_dir = vim.fn.stdpath("data") .. "/plugins"

local function ensure(spec)
    local repo = type(spec) == "string" and spec or spec[1]
    local name = repo:match(".+/(.+)$")
    local path = plug_dir .. "/" .. name

    if not vim.uv.fs_stat(path) then
        vim.fn.mkdir(plug_dir, "p")
        local cmd = { "git", "clone", "--depth=1" }
        if spec.branch then
            table.insert(cmd, "-b")
            table.insert(cmd, spec.branch)
        end
        table.insert(cmd, "https://github.com/" .. repo)
        table.insert(cmd, path)
        print("Installing " .. name .. "...")
        vim.fn.system(cmd)
    end

    vim.opt.rtp:append(path)
    local lua_path = path .. "/lua"
    if vim.uv.fs_stat(lua_path) then
        package.path = package.path .. ";" .. lua_path .. "/?.lua;" .. lua_path .. "/?/init.lua"
    end
end

function M.setup()
    for _, spec in ipairs(require("plugin-list")) do
        ensure(spec)
    end
end

function M.update()
    local handle = vim.uv.fs_scandir(plug_dir)
    if not handle then return print("No plugins installed") end
    while true do
        local name, t = vim.uv.fs_scandir_next(handle)
        if not name then break end
        if t == "directory" then
            print("Updating " .. name .. "...")
            vim.fn.system({ "git", "-C", plug_dir .. "/" .. name, "pull", "--ff-only" })
        end
    end
    print("Done!")
end

function M.list()
    local handle = vim.uv.fs_scandir(plug_dir)
    if not handle then return print("No plugins installed") end
    while true do
        local name, t = vim.uv.fs_scandir_next(handle)
        if not name then break end
        if t == "directory" then print(name) end
    end
end

function M.clean()
    local installed = {}
    local handle = vim.uv.fs_scandir(plug_dir)
    if handle then
        while true do
            local name, t = vim.uv.fs_scandir_next(handle)
            if not name then break end
            if t == "directory" then installed[name] = true end
        end
    end

    local wanted = {}
    for _, spec in ipairs(require("plugin-list")) do
        local repo = type(spec) == "string" and spec or spec[1]
        wanted[repo:match(".+/(.+)$")] = true
    end

    for name in pairs(installed) do
        if not wanted[name] then
            print("Removing " .. name .. "...")
            vim.fn.delete(plug_dir .. "/" .. name, "rf")
        end
    end
    print("Done!")
end

return M
