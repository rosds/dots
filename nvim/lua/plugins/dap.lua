local config = function()
    local dap = require("dap")

    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
    }

    dap.defaults.fallback.force_external_terminal = true
    dap.defaults.fallback.external_terminal = {
        command = "/home/alfonso.ros/.cargo/bin/alacritty",
        args = { "-e" },
    }

    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = true,
        },
    }

    vim.api.nvim_create_user_command("DapCatchThrow", function()
        dap.set_exception_breakpoints({ "catch", "throw" })
    end, {})
end

return {
    {
        "mfussenegger/nvim-dap",
        config = config,
        keys = {
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
            },
            {
                "<leader>dn",
                function()
                    require("dap").step_over()
                end,
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
            },
            {
                "<leader>dd",
                function()
                    require("dap").down()
                end,
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
            },
            {
                "<leader>du",
                function()
                    require("dap").up()
                end,
            },
            {
                "<leader>dg",
                function()
                    require("dap").repl.open()
                end,
            },
            {
                "<leader>dr",
                function()
                    require("dap").restart()
                end,
            },
            {
                "<leader>da",
                function()
                    require("dap").terminate()
                end,
            },
            {
                "<leader>dh",
                function()
                    require("dap.ui.widgets").hover()
                end,
            },
            {
                "<leader>dp",
                function()
                    require("dap.ui.widgets").preview()
                end,
            },
            {
                "<leader>df",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.frames)
                end,
            },
            {
                "<leader>ds",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.scopes)
                end,
            },
        },
        cmd = {
            "DapCatchThrow",
        },
    },
}
