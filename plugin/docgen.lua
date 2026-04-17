local M = {}

-- C/kernel-doc style: /** ... @param: ... Return: ... */
local function generate_c_doc(bufnr, row, line)
    -- strip static/inline/extern prefixes
    local stripped = line:gsub("^%s*static%s+", ""):gsub("^%s*inline%s+", ""):gsub("^%s*extern%s+", "")

    -- match: type *func_name(params) or type* func_name(params)
    local ret, name, params = stripped:match("^%s*([%w_]+%s*%**)%s*([%w_]+)%s*%((.*)%)%s*{?%s*$")
    if not name then
        return nil, "No C function signature found on current line"
    end

    local doc = { "/**", " * " .. name .. "() - " }

    -- parse parameters
    if params and params:match("%S") and not params:match("^%s*void%s*$") then
        for param in params:gmatch("([^,]+)") do
            local pname = param:match("([%w_]+)%s*$")
                or param:match("%*%s*([%w_]+)")
                or param:match("([%w_]+)%s*%[")
            if pname then
                table.insert(doc, " * @" .. pname .. ": ")
            end
        end
    end

    table.insert(doc, " *")

    -- add Return: if not void
    ret = ret and ret:gsub("%s+", " "):gsub("^%s*", ""):gsub("%s*$", "") or ""
    if ret ~= "void" and ret ~= "" then
        table.insert(doc, " * Return: ")
    end

    table.insert(doc, " */")
    return doc, nil
end

-- Go style: // FunctionName does something.
local function generate_go_doc(bufnr, row, line)
    -- match: func (receiver) name(params) return or func name(params) return
    local name, params, ret

    -- method with receiver: func (r *Receiver) Name(params) return
    name, params, ret = line:match("^%s*func%s+%([^)]+%)%s+([%w_]+)%s*%((.-)%)%s*(.-)%s*{?%s*$")

    -- regular function: func Name(params) return
    if not name then
        name, params, ret = line:match("^%s*func%s+([%w_]+)%s*%((.-)%)%s*(.-)%s*{?%s*$")
    end

    if not name then
        return nil, "No Go function signature found on current line"
    end

    local doc = { "// " .. name .. " " }

    -- add parameter hints if present
    if params and params:match("%S") then
        local param_names = {}
        for param in params:gmatch("([^,]+)") do
            -- Go params: name type or name, name2 type
            local pname = param:match("^%s*([%w_]+)")
            if pname then
                table.insert(param_names, pname)
            end
        end
        if #param_names > 0 then
            table.insert(doc, "//")
            table.insert(doc, "// Parameters:")
            for _, pname in ipairs(param_names) do
                table.insert(doc, "//   - " .. pname .. ": ")
            end
        end
    end

    -- add return hint if present
    ret = ret and ret:gsub("^%s*", ""):gsub("%s*$", "") or ""
    if ret ~= "" and ret ~= "error" then
        table.insert(doc, "//")
        table.insert(doc, "// Returns: ")
    end

    return doc, nil
end

-- Rust style: /// Description
local function generate_rust_doc(bufnr, row, line)
    -- match: fn name(params) -> return or pub fn name...
    local name, params, ret = line:match("^%s*pub%s+fn%s+([%w_]+)%s*%((.-)%)%s*%->%s*(.-)%s*{?%s*$")
    if not name then
        name, params, ret = line:match("^%s*fn%s+([%w_]+)%s*%((.-)%)%s*%->%s*(.-)%s*{?%s*$")
    end
    if not name then
        name, params = line:match("^%s*pub%s+fn%s+([%w_]+)%s*%((.-)%)%s*{?%s*$")
    end
    if not name then
        name, params = line:match("^%s*fn%s+([%w_]+)%s*%((.-)%)%s*{?%s*$")
    end

    if not name then
        return nil, "No Rust function signature found on current line"
    end

    local doc = { "/// " }

    -- add parameter hints if present
    if params and params:match("%S") then
        local param_names = {}
        for param in params:gmatch("([^,]+)") do
            local pname = param:match("^%s*([%w_]+)%s*:")
            if pname and pname ~= "self" and pname ~= "&self" and pname ~= "&mut" then
                table.insert(param_names, pname)
            end
        end
        if #param_names > 0 then
            table.insert(doc, "///")
            table.insert(doc, "/// # Arguments")
            table.insert(doc, "///")
            for _, pname in ipairs(param_names) do
                table.insert(doc, "/// * `" .. pname .. "` - ")
            end
        end
    end

    -- add return hint if present
    ret = ret and ret:gsub("^%s*", ""):gsub("%s*$", "") or ""
    if ret ~= "" then
        table.insert(doc, "///")
        table.insert(doc, "/// # Returns")
        table.insert(doc, "///")
        table.insert(doc, "/// ")
    end

    return doc, nil
end

-- Python style: """docstring"""
local function generate_python_doc(bufnr, row, line)
    local name, params = line:match("^%s*def%s+([%w_]+)%s*%((.-)%)%s*:?%s*$")
    if not name then
        name, params = line:match("^%s*async%s+def%s+([%w_]+)%s*%((.-)%)%s*:?%s*$")
    end

    if not name then
        return nil, "No Python function signature found on current line"
    end

    local indent = line:match("^(%s*)") or ""
    local doc = { indent .. '    """' }

    -- parse parameters
    if params and params:match("%S") then
        local param_names = {}
        for param in params:gmatch("([^,]+)") do
            local pname = param:match("^%s*([%w_]+)")
            if pname and pname ~= "self" and pname ~= "cls" then
                table.insert(param_names, pname)
            end
        end
        if #param_names > 0 then
            table.insert(doc, indent .. "")
            table.insert(doc, indent .. "    Args:")
            for _, pname in ipairs(param_names) do
                table.insert(doc, indent .. "        " .. pname .. ": ")
            end
        end
    end

    table.insert(doc, indent .. "")
    table.insert(doc, indent .. "    Returns:")
    table.insert(doc, indent .. "        ")
    table.insert(doc, indent .. '    """')

    return doc, nil
end

-- filetype to generator mapping
local generators = {
    c = generate_c_doc,
    cpp = generate_c_doc,
    h = generate_c_doc,
    go = generate_go_doc,
    rust = generate_rust_doc,
    python = generate_python_doc,
}

function M.generate_doc()
    local bufnr = vim.api.nvim_get_current_buf()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
    local ft = vim.bo[bufnr].filetype

    local generator = generators[ft]
    if not generator then
        vim.notify("No doc generator for filetype: " .. ft, vim.log.levels.WARN)
        return
    end

    local doc, err = generator(bufnr, row, line)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_buf_set_lines(bufnr, row - 1, row - 1, false, doc)

    -- position cursor at first empty description spot
    local cursor_row = row
    local cursor_col = #doc[1]
    for i, docline in ipairs(doc) do
        if docline:match("%s$") or docline:match(":%s*$") or docline:match("%-%s*$") then
            cursor_row = row + i - 1
            cursor_col = #docline
            break
        end
    end

    vim.api.nvim_win_set_cursor(0, { cursor_row, cursor_col })
    vim.cmd("startinsert!")
end

vim.keymap.set("n", "<leader>dg", M.generate_doc)
