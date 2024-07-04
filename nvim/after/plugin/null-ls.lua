local status, null_ls = pcall(require, "null-ls")
if not status then
    return
end

--- Selects the first existing configuration from the input table
--- the first existing file path is returned
local function select_configuration(configurations)
    -- for every string type, check if it is a valid path to an existing file
    for _, path in ipairs(configurations) do
        if vim.fn.exists(path) then
            return path
        end
    end
    error("failed to select configuration")
end

--------------------------------------------------------------------------------
-- Python linters
--------------------------------------------------------------------------------

local pep257 = {
    name = "pep257",
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "python" },
    generator = null_ls.generator({
        command = "pep257",
        args = { "$FILENAME" },
        to_stdin = false,
        from_stderr = true,
        to_temp_file = true,
        format = "raw",
        on_output = function(params, done)
            local output = params.output
            if not output then
                return done()
            end
            local diagnostics = {}
            for row, code, message in output:gmatch("[^:]+:(%d+)[^D]+(D%d+): ([^\n]+)") do
                table.insert(diagnostics, {
                    row = row,
                    code = code,
                    message = message,
                })
            end
            return done(diagnostics)
        end,
    }),
}

local black = null_ls.builtins.formatting.black.with({
    extra_args = {
        "--config",
        select_configuration({
            "/home/alfonso.ros/ade-home/gc/17495-add-vsomip-bazel-repository/apex_ws/src/apex_tools/repo/file-format/black-config.toml",
        }),
    },
})

--------------------------------------------------------------------------------
-- C++ linters
--------------------------------------------------------------------------------

local helpers = require("null-ls.helpers")

local uncrustify = {
    name = "uncrustify",
    filetypes = { "c", "cpp" },
    method = null_ls.methods.FORMATTING,
    generator = helpers.formatter_factory({
        command = "uncrustify",
        to_stdin = true,
        args = function()
            return {
                "-q",
                "-c",
                vim.fn.expand("~/gc/ament_code_style.cfg"),
                "-l",
                "CPP",
            }
        end,
    }),
}

--------------------------------------------------------------------------------
-- Null-ls setup
--------------------------------------------------------------------------------

local cspell_config = {
    find_json = function()
        local init = vim.fn.expand("$MYVIMRC")
        local init_dir = vim.fn.fnamemodify(init, ":p:h")
        return init_dir .. "/cspell.json"
    end,
}

local cspell = require("cspell")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    debug = false,
    sources = {
        -- c++
        null_ls.builtins.formatting.clang_format.with({
            extra_args = { "--style", "file" },
        }),
        uncrustify,

        -- python
        -- flake8,
        -- pep257,
        -- null_ls.builtins.formatting.autopep8,
        -- null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy.with({
            env = function(params)
                local maybe_ws = vim.fn.findfile("WORKSPACE", path .. ";")
                if maybe_ws == "" then
                    return {}
                else
                    return { MYPYPATH = vim.fn.fnamemodify(maybe_ws, ":p:h") }
                end
            end,
        }),

        -- fennel
        null_ls.builtins.formatting.fnlfmt,

        -- bazel
        null_ls.builtins.formatting.buildifier,

        --lua
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),

        -- grammar & spell
        null_ls.builtins.diagnostics.write_good,
        cspell.diagnostics.with({
            config = cspell_config,
        }),
        cspell.code_actions.with({
            config = cspell_config,
        }),
    },

    -- formatting on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        -- filter = function(cli)
                        --     -- use only null-ls for formatting
                        --     return cli.name == "null-ls"
                        -- end,
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})

--------------------------------------------------------------------------------
-- Null-ls commands
--------------------------------------------------------------------------------

--- List sources in the target buffer
-- @param bufnr number: the target buffer where to list the sources
-- @param filter_ft string: the filetype to filter the sources
local function load_sources(bufnr, filter_ft)
    local sources = null_ls.get_sources()
    local source_names = {}
    for _, source in ipairs(sources) do
        if source.filetypes[filter_ft] then
            if source["_disabled"] then
                table.insert(source_names, "🔴 " .. source.name)
            else
                table.insert(source_names, "🟢 " .. source.name)
            end
        end
    end
    vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, source_names)
    vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
    return #source_names
end

local function sources_prompt()
    -- get current buffer filetype
    local buf_ft = vim.bo.filetype

    -- take the name of the source in the current line and call toggle_source
    local toogle_selection = function()
        local line = vim.fn.line(".")
        local name = vim.fn.getline(line):match("%w+$")
        local query = { name = name }
        null_ls.toggle(query)

        -- 0 works here because this function is exec inside the widget
        load_sources(0, buf_ft)
    end

    local buf = vim.api.nvim_create_buf(false, true)

    local sources_count = load_sources(buf, buf_ft)

    vim.keymap.set("n", "<CR>", toogle_selection, { buffer = buf })
    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(0, false)
    end, { buffer = buf })

    local gwidth = vim.api.nvim_list_uis()[1].width
    local gheight = vim.api.nvim_list_uis()[1].height

    local width = 30
    local height = sources_count

    local opts = {
        relative = "editor",
        anchor = "NW",
        style = "minimal",
        width = width,
        height = height,
        row = (gheight - height) * 0.4,
        col = (gwidth - width) * 0.5,
        border = "single",
    }
    local win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_win_set_option(win, "winhl", "FloatBorder:Pmenu")
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

vim.api.nvim_create_user_command("NullLsSources", sources_prompt, {})
local n = require("keymaps").normal
n({
    ["<leader>ns"] = ":NullLsSources<CR>",
})
