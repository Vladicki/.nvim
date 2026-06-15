return {
	"jiaoshijie/undotree",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = true,
	keys = {
		{ "<leader>U", "<cmd>lua require('undotree').toggle()<cr>", desc = "Undotree" },
	},
	opts = {
		float_diff = true,
		layout = "left_bottom",
		ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
		window = { winblend = 30 },
		keymaps = {
			["j"] = "move_next",
			["k"] = "move_prev",
			["J"] = "move_change_next",
			["K"] = "move_change_prev",
			["<cr>"] = "action_enter",
			["p"] = "enter_diffbuf",
			["q"] = "quit",
		},
	},
}
