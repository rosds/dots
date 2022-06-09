local status, null_ls = pcall(require, "null-ls")
if not status then return end

--------------------------------------------------------------------------------
-- Text linters
--------------------------------------------------------------------------------

local offset_to_row_col = function(offset)
    local row = vim.fn.byte2line(offset)
    local row_offset = vim.fn.line2byte(row)
    return row, offset - row_offset + 2 -- 1-indexed
end

local helpers = require("null-ls.helpers")
local languagetool = {
    name = "languagetool",
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "markdown", "text" },
    generator = null_ls.generator({
        command = "languagetool",
        args = { "$FILENAME" },
        to_stdin = false,
        from_stderr = false,
        format = "json",
        check_exit_code = function(code)
            return code <= 1
        end,
        condition = function()
            return vim.fn.executable("languagetool") == 1
        end,
        on_output = helpers.diagnostics.from_json({
            attributes = {
                offset = "offset",
                length = "length",
                rule = "rule",
            },
            adapters = {
                {
                    row = function(entries)
                        local row, _ = offset_to_row_col(entries["offset"])
                        return row
                    end,
                    col = function(entries)
                        local _, col = offset_to_row_col(entries["offset"])
                        return col
                    end,
                    end_row = function(entries)
                        local row, _ = offset_to_row_col(entries["offset"] + entries["length"])
                        return row
                    end,
                    end_col = function(entries)
                        local _, col = offset_to_row_col(entries["offset"] + entries["length"])
                        return col
                    end,
                    code = function(entries)
                        return entries["rule"]["id"]
                    end,
                },
            },
        }),
    }),
}

--------------------------------------------------------------------------------
-- Python linters
--------------------------------------------------------------------------------

-- ament_flake8
local ament_flake8_path = "/opt/ApexTools/bin/ament_flake8"
local ament_pep257_path = "/opt/ApexTools/bin/ament_pep257"

local ament_flake8 = null_ls.builtins.diagnostics.flake8.with({
    command = ament_flake8_path,
    args = { "$FILENAME" },
    condition = function()
        return vim.fn.executable(ament_flake8_path) == 1
    end,
    env = {
        PYTHONPATH = "/opt/ApexTools/lib/python3.8/site-packages",
    },
})

local ament_pep257 = {
    name = "ament_pep257",
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "python" },
    generator = null_ls.generator({
        command = ament_pep257_path,
        env = {
            PYTHONPATH = "/opt/ApexTools/lib/python3.8/site-packages",
        },
        args = { "$FILENAME" },
        to_stdin = false,
        from_stderr = false,
        format = "line",
        check_exit_code = function(code)
            return code <= 1
        end,
        condition = function()
            return vim.fn.executable(ament_pep257_path) == 1
        end,
        on_output = helpers.diagnostics.from_pattern(
            [[:(%d+)[^:]+: (%w+): (.+)]],
            { 'row', 'code', 'message' }
        ),
    }),
}


--------------------------------------------------------------------------------
-- C++ linters
--------------------------------------------------------------------------------

-- ament_cpplint
local ament_cpplint_path = "/opt/ApexTools/bin/ament_cpplint"
local ament_clang_format_path = "/opt/ApexTools/bin/ament_clang_format"

local ament_clang_format = null_ls.builtins.formatting.clang_format.with({
    name = "ament_clang_format",
    command = ament_clang_format_path,
    condition = function()
        return vim.fn.executable(ament_clang_format_path) == 1
    end,
    env = {
        PYTHONPATH = "/opt/ApexTools/lib/python3.8/site-packages",
    },
})

local ament_cpplint = null_ls.builtins.diagnostics.cpplint.with({
    name = "ament_cpplint",
    command = ament_cpplint_path,
    condition = function()
        return vim.fn.executable(ament_cpplint_path) == 1
    end,
    env = {
        PYTHONPATH = "/opt/ApexTools/lib/python3.8/site-packages",
    },
})

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

local clang_format = null_ls.builtins.formatting.clang_format.with({
    extra_args = { '-style=file' },
})

--------------------------------------------------------------------------------
-- Null-ls setup
--------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
    debug = true,
    sources = {
        -- c++
        ament_cpplint,
        ament_clang_format,
        uncrustify,

        -- python
        ament_flake8,
        ament_pep257,
        null_ls.builtins.formatting.autopep8,
        -- null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.black,

        -- markdown, text
        languagetool,

        -- fennel
        null_ls.builtins.formatting.fnlfmt,

        -- bazel
        null_ls.builtins.formatting.buildifier,
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
}

--------------------------------------------------------------------------------
-- Null-ls commands
--------------------------------------------------------------------------------

local function sources_prompt()
    -- writes the list of sources to the buffer
    local function load_sources(bufnr)
        local sources = null_ls.get_sources()
        local source_names = {}
        for _, source in ipairs(sources) do
            if source.filetypes[vim.bo.filetype] then
                if source["_disabled"] then
                    table.insert(source_names, "🔴 " .. source.name)
                else
                    table.insert(source_names, "🟢 " .. source.name)
                end
            end

        end
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, source_names)
        return #source_names
    end

    -- take the name of the source in the current line and call toggle_source
    local toogle_selection = function()
        local line = vim.fn.line('.')
        local name = vim.fn.getline(line):match("%w+$")
        print(name)
        local query = { name = name }
        null_ls.toggle(query)
        load_sources(0)
    end

    local buf = vim.api.nvim_create_buf(false, true)
    local sources_count = load_sources(buf)

    vim.keymap.set('n', '<CR>', toogle_selection, { buffer = buf })
    vim.keymap.set('n', 'q', function() vim.api.nvim_win_close(0, false) end, { buffer = buf })

    local gwidth = vim.api.nvim_list_uis()[1].width
    local gheight = vim.api.nvim_list_uis()[1].height

    local width = 30
    local height = sources_count

    local opts = {
        relative = 'editor',
        anchor = 'NW',
        style = 'minimal',
        width = width,
        height = height,
        row = (gheight - height) * 0.4,
        col = (gwidth - width) * 0.5,
        border = 'single',
    }
    local win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_win_set_option(win, 'winhl', 'FloatBorder:Pmenu')
end

vim.api.nvim_create_user_command("NullLsSources", sources_prompt, {})
local n = require 'keymaps'.normal
n {
    ["<leader>ns"] = ":NullLsSources<CR>",
}
