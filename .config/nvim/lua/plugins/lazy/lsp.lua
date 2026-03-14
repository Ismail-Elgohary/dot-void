return {
	{
	    "williamboman/mason-lspconfig.nvim",
		build = ":MasonUpdate",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {}, build = ":MasonUpdate" },
			{ "neovim/nvim-lspconfig" },
		},
		config = function()
			require("mason").setup({})
			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					"clangd",
					"zls",
					"efm",
					"gopls",
					"rust_analyzer",
					"basedpyright",
					"ruff",
					"ts_ls",
					"lua_ls",
					"phpactor",
				},
			})

			vim.lsp.config("*", {
				capabilities = vim.lsp.protocol.make_client_capabilities(),
				on_attach = function(_, bufnr)
					local opts = { buffer = bufnr, remap = false }
					vim.lsp.inlay_hint.enable(false)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "k", vim.lsp.buf.hover, opts)
					vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>af", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>ak", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set("n", "<leader>aj", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
					vim.keymap.set("n", "<leader>bf", function()
						require("conform").format({
							async = true,
							lsp_format = "fallback",
						})
					end, opts)
					--[[
					vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, opts)
					if client.server_capabilities.document_range_formatting then
						vim.keymap.set("v", "<leader>bf", vim.lsp.buf.format, opts)
					end
					]]
				end,
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--enable-config",
					"--clang-tidy",
					"--background-index",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						completeunimported = true,
						useplaceholders = true,
						staticcheck = true,
						gofumpt = true,
						analyses = {
							unusedparams = true,
							unusedvariable = true,
							unusedwrite = true,
						},
					},
				},
			})


         vim.lsp.config("lua_ls", {
				filetypes = { "lua" },
				settings = {
					Lua = {
						telemetry = { enable = false },
						codeLens = { enable = true },
						hint = { enable = true },
						runtime = {
							version = jit and "LuaJIT" or _VERSION or "Lua 5.1",
							pathStrict = true,
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
							},
						},
					},
				},
			})


			vim.lsp.config("ts_ls", {
				init_options = {
					maxtsservermemory = 3 * 1024,
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vim.fn.expand(
								"$mason/packages/vue-language-server/node_modules/@vue/language-server"
							),
							languages = { "vue" },
							confignamespace = "typescript",
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			vim.lsp.config("arduino_language_server", {
				cmd = {
					"arduino-language-server",
					"-cli-config",
					vim.fn.expand("$arduino_directories_data/arduino-cli.yaml"),
				},
			})
		end,
	},
}
