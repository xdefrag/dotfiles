-- basic
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 2

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
    end
  }

  use {
    'nvim-telescope/telescope-project.nvim',
    config = function()
      require 'telescope'.load_extension 'project'
      require 'telescope'.setup {
        extensions = {
          project = {
            base_dirs = { '~/Code' },
            hidden_files = true,
            theme = "dropdown"
          }
        }
      }

      vim.keymap.set('n', '<leader>sp', ':Telescope project<CR>')
    end
  }

  use {
    'junegunn/vim-easy-align'
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'nvim-tree'.setup {
        disable_netrw = false,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }

      vim.keymap.set('n', '<Leader>on', ':NvimTreeToggle<CR>')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      require 'nvim-treesitter.configs'.setup {
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
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        vim.keymap.set('n', '<space>lr', vim.lsp.codelens.run, bufopts)

        vim.keymap.set('n', '<leader>ss', ':Telescope lsp_document_symbols<CR>', bufopts)
      end

      local lspconfig = require 'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            env = {
              GOLANG_PROTOBUF_REGISTRATION_CONFLICT = "ignore",
            },
            directoryFilters = {
              "-graphql",
              "-vendor",
            },
            memoryMode = "DegradeClosed",
            gofumpt = true,
            staticcheck = true,
            buildFlags = { '-tags=integration,statemachine_test' },
          },
        },
      }

      lspconfig.sumneko_lua.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end
  }

  use {
    'hrsh7th/nvim-cmp',
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
          { name = 'neorg' },
        },
      }
    end
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)
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
    'Pocco81/TrueZen.nvim',
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

  -- neorg
  -- Default keybindings:
  -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
  use {
    'nvim-neorg/neorg',
    ft = 'norg',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope', 'Pocco81/TrueZen.nvim' },
    config = function()
      require 'neorg'.setup {
        load = {
          ['core.defaults'] = {},
          ['core.gtd.base'] = {
            config = {
              workspace = 'home'
            }
          },
          ['core.norg.dirman'] = {
            config = {
              workspaces = {
                home = '~/Notes/Home',
                work = '~/Notes/Work',
              }
            }
          },
          ['core.norg.completion'] = {
            config = {
              engine = 'nvim-cmp'
            }
          },
          ['core.norg.concealer'] = {
            config = {}
          },
          ['core.integrations.telescope'] = {
            config = {}
          },
          ['core.norg.journal'] = {
            config = {
              workspace = 'home',
            }
          },
          ['core.export'] = {
            config = {}
          },
          ['core.presenter'] = {
            config = {
              -- zen_mode : Zen mode plugin to use. Currenly suppported:
              -- zen-mode (https://github.com/folke/zen-mode.nvim)
              -- truezen (https://github.com/Pocco81/TrueZen.nvim)
              zen_mode = 'truezen',
            }
          },
        }
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
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require 'diffview'.setup {
        -- keymaps = {
        --   disable_defaults = false,
        --   view = {},
        -- },
      }
    end
  }
end)
