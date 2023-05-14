-- basic
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 4

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.updatetime = 25
vim.opt.signcolumn = "yes"
vim.opt.autowriteall = true
vim.opt.copyindent = true
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.showcmd = false

vim.opt.number = false

vim.opt.scrolloff = 15

vim.opt.clipboard = "unnamedplus"

vim.cmd([[set shortmess+=F]])

-- netrw
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0

-- mode, keys, cmd, opts
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ot", ":terminal<CR>")
vim.keymap.set("n", "<leader>on", ":NvimTreeFocus<CR>")

vim.keymap.set("n", "<leader>cp", ':let @+=expand("%") . \':\' . line(".")<CR>')

require("packer").startup(function(use)
	use({
		"wbthomason/packer.nvim",
		config = function()
			vim.keymap.set("n", "<leader>ps", ":PackerSync<CR>")
		end,
	})

	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.opt.termguicolors = true
			vim.cmd([[colorscheme gruvbox]])
		end,
	})

	use("ludovicchabant/vim-gutentags")

	use({
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":Git<CR>")
			vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
		end,
	})

	use({ "tpope/vim-surround" })

	use({ "tpope/vim-dispatch" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({})
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				tabline = {},
				sections = {
					lualine_c = {
						{
							"filename",
							file_status = false,
							path = 1,
						},
					},
					lualine_x = { "filetype" },
				},
				inactive_sections = {
					lualine_a = {
						{
							"filename",
							file_status = false,
							path = 1,
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				options = {
					icons_enabled = true,
					theme = "gruvbox",
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_char = "┊"
			vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
			vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
		end,
	})

	use("sheerun/vim-polyglot")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-dap.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			-- Telescope
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})

			-- Enable telescope fzf native
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("dap")

			--Add leader shortcuts
			vim.keymap.set("n", "<leader><leader>", ":Telescope buffers<CR>")
			vim.keymap.set("n", "<leader>sf", ":Telescope fd previewer=false<CR>")
			vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<CR>")
			vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>")
			vim.keymap.set("n", "<leader>gs", ":Telescope git_stash<CR>")
			vim.keymap.set("n", "<leader>gf", ":Telescope git_files<CR>")
			vim.keymap.set("n", "<leader>sq", ":Telescope quickfix<CR>")
			vim.keymap.set("n", "<leader>sk", ":Telescope keymaps<CR>")
			vim.keymap.set("n", "<leader>sm", ":Telescope marks<CR>")
			vim.keymap.set("n", "<leader>sc", ":Telescope commands<CR>")
			vim.keymap.set("n", "<leader>sh", ":Telescope help_tags<CR>")
		end,
	})

	use({
		"junegunn/vim-easy-align",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"go",
					"rust",
					"javascript",
					"typescript",
					"proto",
					"toml",
					"yaml",
					"json",
				},
				auto_install = true,
				ident = { enabled = true },
				highlight = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			})
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	})

	use({
		"williamboman/mason.nvim",
		run = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup({})
		end,
	})

	use({
		"williamboman/mason-lspconfig.nvim",
		after = "mason.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = nil,
				automatic_installation = true,
			})
		end,
	})

	use({
		"jay-babu/mason-null-ls.nvim",
		after = { "mason.nvim", "mason-lspconfig.nvim", "null-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
			})
		end,
	})

	use({
		"jay-babu/mason-nvim-dap.nvim",
		after = { "mason.nvim", "mason-lspconfig.nvim" },
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = nil,
				automatic_installation = true,
			})
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		after = { "mason.nvim", "mason-lspconfig.nvim" },
		config = function()
			local lsp_on_attach = function(_, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", bufopts)
				-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
				-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
				-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
				-- vim.keymap.set('n', '<space>wl', function()
				-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)
				-- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
				-- vim.keymap.set('n', '<space>lr', vim.lsp.codelens.run, bufopts)

				vim.keymap.set("n", "<leader>sw", ":Telescope lsp_document_symbols<CR>", bufopts)
				vim.keymap.set("n", "<leader>ss", ":Telescope lsp_workspace_symbols<CR>", bufopts)

				vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", bufopts)
			end

			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = lsp_on_attach,
				settings = {
					gopls = {
						-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
						env = {
							GOLANG_PROTOBUF_REGISTRATION_CONFLICT = "ignore",
						},
						directoryFilters = {
							"-graphql/exec_gqlgen.go",
							"-vendor",
						},
						-- memoryMode = "DegradeClosed",
						gofumpt = true,
						staticcheck = true,
						buildFlags = { "-tags=integration,statemachine_test" },
						usePlaceholders = false,
						experimentalPackageCacheKey = true,
					},
				},
			})

			lspconfig.gdscript.setup({
				capabilities = capabilities,
				on_attach = lsp_on_attach,
			})

			lspconfig.elixirls.setup({
				cmd = { "/opt/homebrew/bin/elixir-ls" },
				capabilities = capabilities,
				on_attach = lsp_on_attach,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = lsp_on_attach,
			})

			lspconfig.graphql.setup({
				capabilities = capabilities,
				on_attach = lsp_on_attach,
			})

			lspconfig.dockerls.setup({
				capabilities = capabilities,
				on_attach = lsp_on_attach,
			})

			lspconfig.hls.setup({
				capabilities = capabilities,
				on_attach = lsp_on_attach,
			})
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local luasnip = require("luasnip")
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "copilot", keyword_length = 0 },
					{ name = "luasnip" },
					{ name = "emoji" },
				},
			})
		end,
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
		end,
	})

	use("saadparwaiz1/cmp_luasnip")
	use({
		"L3MON4D3/LuaSnip",
		requires = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	})

	use({
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	})

	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
				update_focused_file = {
					enable = true,
					update_root = false,
					ignore_list = {},
				},
			})
		end,
	})

	use({
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup({
				integrations = {
					gitsigns = true,
					lualine = true,
					tmux = true,
				},
			})
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	})

	-- marks
	use({
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				force_write_shada = true,
			})
		end,
	})

	use({
		"lifepillar/pgsql.vim",
		config = function()
			vim.cmd([[let g:sql_type_default = 'pgsql']])
		end,
	})

	use({
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local bufopts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, bufopts)
			-- vim.keymap.set("n", "<leader>dc", dap.continue, bufopts)
			-- vim.keymap.set('n', '<leader>di', dap.step_into, bufopts)
			-- vim.keymap.set('n', '<leader>do', dap.step_over, bufopts)
			-- vim.keymap.set('n', '<leader>dr', dap.repl.open, bufopts)
		end,
	})

	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup({
				mappings = {
					expand = { "<CR>", "<Space>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = { "t", "<Space>" },
				},
			})
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	})

	use({
		"theHamsta/nvim-dap-virtual-text",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
		end,
	})

	use({
		"jubnzv/mdeval.nvim",
		config = function()
			require("mdeval").setup({
				require_confirmation = false,
				eval_options = {},
			})

			vim.cmd("autocmd FileType md noremap <Leader>e :MdEval<CR>")
		end,
	})

	use({
		"nvim-tree/nvim-web-devicons",
	})

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})

			local opts = { silent = true, noremap = true }

			vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
			vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
			vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
			vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
			vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		after = { "mason.nvim", "mason-lspconfig.nvim", "nvim-lspconfig" },
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
				sources = {
					null_ls.builtins.code_actions.gomodifytags,
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.code_actions.shellcheck,
					-- null_ls.builtins.code_actions.statix,
					null_ls.builtins.diagnostics.buf,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "postgres" }, -- change to your dialect
					}),
					null_ls.builtins.diagnostics.staticcheck,
					null_ls.builtins.formatting.buf,
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.gdformat,
					null_ls.builtins.formatting.gofumpt,
					-- null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.jq,
					-- null_ls.builtins.formatting.nixpkgs_fmt,
					-- null_ls.builtins.formatting.pg_format,
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.taplo,
					null_ls.builtins.formatting.yamlfmt,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	})

	use({
		"klen/nvim-test",
		config = function()
			require("nvim-test").setup({})

			vim.keymap.set("n", "<leader>tt", ":TestSuite<CR>")
			vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
			vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>")
			vim.keymap.set("n", "<leader>ti", ":TestInfo<CR>")
		end,
	})

	use({
		"simrat39/rust-tools.nvim",
		after = { "nvim-lspconfig", "null-ls.nvim", "nvim-dap", "plenary.nvim" },
		config = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					on_attach = function(_, bufnr)
						local bufopts = { buffer = bufnr }

						vim.keymap.set("n", "<leader>dc", ":RustDebuggables<CR>", bufopts)
						vim.keymap.set("n", "K", rt.hover_actions.hover_actions, bufopts)
						vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, bufopts)

						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
						vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", bufopts)
						vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", bufopts)
						vim.keymap.set("n", "<leader>sw", "<Cmd>Telescope lsp_document_symbols<CR>", bufopts)
						vim.keymap.set("n", "<leader>ss", "<Cmd>Telescope lsp_workspace_symbols<CR>", bufopts)
					end,
				},
			})
		end,
	})

	use({
		"rgroli/other.nvim",
		config = function()
			require("other-nvim").setup({
				mappings = {
					{
						context = "test",
						pattern = "(.*).go$",
						target = "%1_test.go",
					},
					{
						context = "implementation",
						pattern = "(.*)_test.go$",
						target = "%1.go",
					},
				},
			})

			vim.keymap.set("n", "<leader>a", ":Other<CR>")
		end,
	})
end)
