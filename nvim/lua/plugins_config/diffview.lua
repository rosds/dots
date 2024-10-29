local dv = require("diffview")

dv.setup({
	keymaps = {
		view = {
			{
				"n",
				"gq",
				"<Cmd>DiffviewClose<cr>",
			},
		},
		file_history_panel = {
			{
				"n",
				"<c-n>",
				function()
					require("diffview.actions").select_next_entry()
				end,
			},
			{
				"n",
				"<c-p>",
				function()
					require("diffview.actions").select_prev_entry()
				end,
			},
			{
				"n",
				"gq",
				"<Cmd>DiffviewClose<cr>",
			},
		},
	},
})
