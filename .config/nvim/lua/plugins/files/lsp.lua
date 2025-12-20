return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"j-hui/fidget.nvim",
	},
	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities())

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"zls",
				"rust_analyzer",
				"gopls",
				"pyright",
				"ts_ls",
				"lua_ls",
			},
			handlers = {
				function(name)
					require("lspconfig")[name].setup({ capabilities = capabilities })
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								completeUnimported = true,
								usePlaceholders = true,
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
				end,
				["lua_ls"] = function()
					local path = vim.split(package.path, ";")
					table.insert(path, "lua/?.lua")
					table.insert(path, "lua/?/init.lua")
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								telemetry = { enable = false },
								runtime = {
									version = "LuaJIT",
									path = path,
								},
								diagnostics = {
									globals = {
										"vim",
									},
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.fn.expand("$VIMRUNTIME/lua"),
									},
								},
							},
						},
					})
				end,
				["arduino_language_server"] = function()
					require("lspconfig").arduino_language_server.setup({
						capabilities = capabilities,
						cmd = {
							"arduino-language-server",
							"-cli-config",
							"$ARDUINO_DIRECTORIES_DATA/arduino-cli.yaml",
						},
					})
				end,
			},
		})

		require("fidget").setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf, remap = false }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set("n", "<leader>af", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>ak", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<leader>aj", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, opts)
			end

		})

_G.shift_k_enabled = false
vim.api.nvim_create_augroup("LspGroup", {})

vim.api.nvim_create_autocmd("CursorHold", {
    group = "LspGroup",
    callback = function()
        if not _G.shift_k_enabled then
            vim.diagnostic.open_float(nil, {
                scope = "cursor",
                focusable = true,
                close_events = {
                    "CursorMoved",
                    "CursorMovedI",
                    "BufHidden",
                    "InsertCharPre",
                    "WinLeave",
                  },
            })
        end
    end,
    desc = "Show diagnostic error info on CursorHold"
})
vim.api.nvim_create_autocmd({"CursorMoved", "BufEnter"}, {
    callback = function()
        _G.shift_k_enabled = false
    end
})
function _G.show_docs()
    _G.shift_k_enabled = true
    vim.api.nvim_command("doautocmd CursorMovedI") -- Run autocmd to close diagnostic window if already open

    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    else
        --vim.lsp.buf.hover() -- use if you want to use builtin LSP hover
        vim.api.nvim_command("Lspsaga hover_doc")
    end
end

vim.keymap.set("n", "K",  _G.show_docs, {noremap = true, silent = true})

			end,
}
