return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{
				"L3MON4D3/LuaSnip",
				-- follow latest release.
				version = "2.*", -- Replace <CurretnMajor> by the latest release major
				--install jsregexp (optional!).
				build = "make install_jsregexp",
			}, -- Required
		},
		config = function()
			local lsp = require("lsp-zero").preset({})

			lsp.ensure_installed({
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"texlab",
				"zls",
				"pylsp",
			})

			-- Fix Undefined global 'vim'
			lsp.nvim_workspace()

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = lsp.defaults.cmp_mappings({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			})

			cmp_mappings["<Tab>"] = nil
			cmp_mappings["<S-Tab>"] = nil

			lsp.setup_nvim_cmp({
				mapping = cmp_mappings,
			})

			lsp.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = "E",
					warn = "W",
					hint = "H",
					info = "I",
				},
			})
			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.get_next()
					--vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.get_prev()
					--vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end)

			-- (Optional) Configure lua language server for neovim
			local lspconf = require("lspconfig")
			local util = require("lspconfig/util")
			lspconf.lua_ls.setup(lsp.nvim_lua_ls({
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/luarc.jsonc") then
						return
					end
				end,
				settings = {
					lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdPerty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			}))

			lspconf.gopls.setup({
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			lspconf.zls.setup({
				settings = {
					lua = {
						completion_label_details = true,
						inlay_hints = true,
					},
				},
			})
			lspconf.pylsp.setup({})

			lsp.setup()
			-- Required
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},
}
