return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		keys = {
			["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
			["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
			["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
			["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
		},
	},
	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"tpope/vim-fugitive",
	},
}
