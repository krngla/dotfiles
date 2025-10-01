return {
	"hrsh7th/nvim-cmp" ,
	version = false,
	event = "InsertEnter",
	dependencies = {
		{"hrsh7th/cmp-nvim-lsp"},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/cmp-cmdline'},
		{'hrsh7th/nvim-cmp'},
		{'petertriho/cmp-git'},
		{
			'L3MON4D3/LuaSnip',
			version = "2.*",
			build = "make install_jsregexp",
			},
		{'saadparwaiz1/cmp_luasnip'},
	},
	opts = function()
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		})

		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()
		local auto_select = true
		return {
			auto_brackets = {},
			completion = {
				completionopt = "meny,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			},
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = nil,
				["<S-Tab>"] = nil,
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},{
				{ name = 'buffer' },
			})
		}
	end,
}
