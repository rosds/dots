local function split_run(cmd)
    if type(cmd) == "string" then
        cmd = { cmd }
    end

    vim.cmd.split("term://" .. table.concat(cmd, " "))
    -- vim.cmd.Dispatch(table.concat(cmd, " "))
end

local function fixup_current_file()
    local last_commit = require("utils.git").file_last_commit()
    split_run("git commit --no-verify --fixup=" .. last_commit)
end

local function fixup_and_rebase_current_file()
    local last_commit = require("utils.git").file_last_commit()
    split_run({
        "git commit --no-verify --fixup=" .. last_commit .. "&&",
        "git -c sequence.editor=true rebase --autostash --interactive --autosquash " .. last_commit .. "^ &&",
    })
end

vim.api.nvim_create_user_command("FixupBuffer", fixup_and_rebase_current_file, {})

local n = require("keymaps").normal
local v = require("keymaps").visual
local ag = require("augroup").augroup

n({
    ["<leader>gg"] = ":G<cr>",
    ["<leader>glo"] = ":0Gclog --max-count=10<cr>",
    ["<leader>gll"] = ":Git log --oneline --max-count=20<cr>",
    -- ["<leader>gll"] = ":Gclog --max-count=10<cr>",
    ["<leader>gl"] = ":diffget //3<cr>",
    ["<leader>gh"] = ":diffget //2<cr>",
    ["<leader>gf"] = fixup_current_file,
    ["<leader>gF"] = fixup_and_rebase_current_file,
})

v({
    ["<leader>gb"] = ":GBrowse<cr>",
    ["<leader>gl"] = ":Gclog<cr>",
})

ag("my_fugitive")({
    {
        { "BufEnter", "BufWinEnter" },
        pattern = "fugitive://*",
        callback = function()
            n({
                go = { ":Gedit<cr>", buffer = true },
                gpf = { ":G push --force-with-lease<cr>", buffer = true },
            })
        end,
    },
})
