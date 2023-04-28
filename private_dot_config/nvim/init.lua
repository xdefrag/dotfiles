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

vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.updatetime = 25
vim.opt.signcolumn = 'yes'
vim.opt.autowriteall = true
vim.opt.copyindent = true
vim.opt.lazyredraw = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.showcmd = false

vim.opt.number = false

vim.opt.scrolloff = 15

vim.opt.clipboard = "unnamedplus"

vim.cmd [[set shortmess+=F]]

-- netrw
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0

-- mode, keys, cmd, opts
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.keymap.set("i", "jk", '<Esc>')
vim.keymap.set("t", "<Esc>", '<C-\\><C-n>')
vim.keymap.set("t", "jk", '<C-\\><C-n>')

vim.keymap.set("n", "<leader>ot", ':terminal<CR>')
vim.keymap.set("n", "<leader>on", ':Explore<CR>')

require 'packer'.startup(function(use)
  use {
    'wbthomason/packer.nvim',
    config = function()
      vim.keymap.set('n', '<leader>ps', ':PackerSync<CR>')
    end
  }

  use {
    'morhetz/gruvbox',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[colorscheme gruvbox]]
    end
  }

  use 'ludovicchabant/vim-gutentags'

  use {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gg", ':Git<CR>')
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
    end
  }

  use { 'tpope/vim-surround' }

  use { 'tpope/vim-dispatch' }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'Comment'.setup {}
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'gitsigns'.setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require 'lualine'.setup {
        tabline = {},
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = false,
              path = 1,
            },
          },
          lualine_x = { 'filetype' },
        },
        inactive_sections = {
          lualine_a = {
            {
              'filename',
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
          theme = 'gruvbox',
          component_separators = '|',
          section_separators = '',
        },
      }
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_char = '┊'
      vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
      vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
    end
  }

  use 'sheerun/vim-polyglot'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-dap.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      -- Telescope
      require 'telescope'.setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      }

      -- Enable telescope fzf native
      require 'telescope'.load_extension 'fzf'
      require 'telescope'.load_extension 'dap'

      --Add leader shortcuts
      vim.keymap.set('n', '<leader><leader>', ':Telescope buffers<CR>')
      vim.keymap.set('n', '<leader>sf', ':Telescope fd previewer=false<CR>')
      vim.keymap.set('n', '<leader>sg', ':Telescope live_grep<CR>')
      vim.keymap.set('n', '<leader>gc', ':Telescope git_commits<CR>')
      vim.keymap.set('n', '<leader>gs', ':Telescope git_stash<CR>')
      vim.keymap.set('n', '<leader>gf', ':Telescope git_files<CR>')
      vim.keymap.set('n', '<leader>sq', ':Telescope quickfix<CR>')
      vim.keymap.set('n', '<leader>sk', ':Telescope keymaps<CR>')
      vim.keymap.set('n', '<leader>sm', ':Telescope marks<CR>')
      vim.keymap.set('n', '<leader>sd', ':Telescope diagnostics<CR>')
      vim.keymap.set('n', '<leader>sc', ':Telescope commands<CR>')
      vim.keymap.set('n', '<leader>sh', ':Telescope help_tags<CR>')
      vim.keymap.set('n', '<leader>sb', ':Telescope file_browser<CR>')
    end
  }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  use {
    'junegunn/vim-easy-align'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {"lua", "go"},
        auto_install = true,
        highlight = {
          enable = true
        },
      }
    end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>', bufopts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wl', function()
          -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
        -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        -- vim.keymap.set('n', '<space>lr', vim.lsp.codelens.run, bufopts)

        -- vim.keymap.set('n', '<leader>ss', ':Telescope lsp_document_symbols<CR>', bufopts)
      end

      local lspconfig = require 'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
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
            buildFlags = { '-tags=integration,statemachine_test' },
            usePlaceholders = false,
            experimentalPackageCacheKey = true,
          },
        },
      }

      lspconfig.gdscript.setup{
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.elixirls.setup{
        cmd = {'/opt/homebrew/bin/elixir-ls'};
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.tsserver.setup{
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.graphql.setup{
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.dockerls.setup{
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.hls.setup{
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
    },
    config = function()
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
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
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'emoji' },
        },
      }

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)
    end
  }

  use 'saadparwaiz1/cmp_luasnip'
  use {
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    config = function()
      require 'luasnip.loaders.from_vscode'.lazy_load()
    end
  }

  use {
    'Pocco81/true-zen.nvim',
    config = function()
      require 'true-zen'.setup {
        integrations = {
          gitsigns = true,
          lualine = true,
          tmux = true,
        },
      }
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'nvim-autopairs'.setup {}
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  }

  -- marks
  use {
    'chentoast/marks.nvim',
    config = function()
      require 'marks'.setup {
        force_write_shada = true,
      }
    end
  }

  use {
    'lifepillar/pgsql.vim',
    config = function()
      vim.cmd [[let g:sql_type_default = 'pgsql']]
    end
  }

  use {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local bufopts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, bufopts)
      vim.keymap.set('n', '<leader>dc', dap.continue, bufopts)
      vim.keymap.set('n', '<leader>di', dap.step_into, bufopts)
      vim.keymap.set('n', '<leader>do', dap.step_over, bufopts)
      vim.keymap.set('n', '<leader>dr', dap.repl.open, bufopts)
    end
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require("dapui").setup {
        mappings = {
          expand = { '<CR>', '<Space>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = { 't', '<Space>' },
        },
      }
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end
  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require 'nvim-dap-virtual-text'.setup {
        commented = true,
      }
    end
  }

  use {
    'ray-x/go.nvim',
    requires = { 'ray-x/guihua.lua' },
    config = function()
      require 'go'.setup {
        lsp_cfg = false,
        lsp_gofumpt = true,
        lsp_on_attach = nil,
        icons = false,
        lsp_keymaps = false,
        lsp_codelens = false,
        lsp_document_formatting = false,
        dap_debug_keymap = true,
        run_in_floaterm = true,
      }

      vim.cmd('autocmd FileType go noremap <Leader>tn :GoTest -n<CR>')
      vim.cmd('autocmd FileType go noremap <Leader>tt :GoTest<CR>')
      vim.cmd('autocmd FileType go noremap <Leader>tf :GoTest -f<CR>')
      vim.cmd('autocmd FileType go noremap <Leader>tp :GoTest -p<CR>')
      vim.cmd('autocmd FileType go noremap <Leader>dt :GoDebug -n<CR>')
      vim.cmd('autocmd FileType go noremap <Leader>a :GoAlt<CR>')
      vim.cmd('autocmd FileType go noremap <Leader>f :GoImport<CR>')

      vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    end
  }

  use {
    'jubnzv/mdeval.nvim',
    config = function ()
      require'mdeval'.setup{
        require_confirmation=false,
        eval_options = {},
      }

      vim.cmd('autocmd FileType md noremap <Leader>e :MdEval<CR>')
    end
  }
end)
