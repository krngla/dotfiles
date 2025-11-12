return {
	"mason-org/mason-lspconfig.nvim", -- Optional
	opts = {
		ensure_installed = {
			"lua_ls",
			"rust_analyzer",
			"gopls",
			"texlab",
			"zls",
			"pylsp",
			"ols",
			"glsl_analyzer",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "neovim/nvim-lspconfig" },
	},
}
