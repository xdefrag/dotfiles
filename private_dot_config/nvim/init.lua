-- basic
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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

-- packer
require'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'morhetz/gruvbox',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[colorscheme gruvbox]]
    end
  }

  -- essentials
  use 'ludovicchabant/vim-gutentags'

  use {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gg", ':Git<CR>')
    end
  }

  use { 'tpope/vim-surround' }

  use { 'tpope/vim-dispatch' }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require'Comment'.setup{}
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
    config = function()
      require 'lualine'.setup {
        options = {
          icons_enabled = false,
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

  -- file picker
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Telescope
      require'telescope'.setup {
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
      require'telescope'.load_extension'fzf'

      --Add leader shortcuts
      local opts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').fd({previewer = false})<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
    end
  }

  use {
    'nvim-telescope/telescope-project.nvim',
    config = function ()
      require'telescope'.load_extension'project'
      require'telescope'.setup {
        extensions = {
          project = {
            base_dirs = {'~/Code'},
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

  -- tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'nvim-tree'.setup{
        disable_netrw = false,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }

      vim.keymap.set('n', '<Leader>on', ':NvimTreeToggle<CR>')
    end
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require'nvim-treesitter.configs'.setup{
        highlight = {
          enable = true
        },
      }
    end
  }

  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        vim.keymap.set('n', '<space>lr', vim.lsp.codelens.run, bufopts)
      end

      local lspconfig = require'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      lspconfig.gopls.setup{
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            env = {
              GOLANG_PROTOBUF_REGISTRATION_CONFLICT = "ignore",
            },
            -- memoryMode = "DegradeClosed",
            gofumpt = true,
            staticcheck = true,
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
              -- Setup your lua path
              path = runtime_path,
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
      capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)
    end
  }

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  -- go
  -- use {
  --   'ray-x/go.nvim',
  --   config = function()
  --     local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  --     require 'go'.setup({
  --         lsp_cfg = {
  --           capabilities = capabilities,
  --         },
  --       })
  --
  --     vim.keymap.set("n", "<Leader>a", ":GoAlt<Enter>")
  --   end
  -- }
  --
  use {
    'Pocco81/TrueZen.nvim',
    config = function ()
      require'true-zen'.setup{
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
    "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter, telescope",
    requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope", "Pocco81/TrueZen.nvim" },
    config = function()
      require 'neorg'.setup {
        load = {
          ["core.defaults"] = {},
          ["core.gtd.base"] = {
            config = {
              workspace = 'home'
            }
          },
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                home = "~/Notes/Home",
                work = "~/Notes/Work",
              }
            }
          },
          ["core.norg.completion"] = {
            config = {
              engine = 'nvim-cmp'
            }
          },
          ["core.norg.concealer"] = {
            config = {}
          },
          ["core.integrations.telescope"] = {
            config = {}
          },
          ["core.norg.journal"] = {
            config = {
              workspace = 'home',
            }
          },
          ["core.export"] = {
             config = {}
          },
          ["core.presenter"] = {
            config = {
              -- zen_mode : Zen mode plugin to use. Currenly suppported:
              -- zen-mode (https://github.com/folke/zen-mode.nvim)
              -- truezen (https://github.com/Pocco81/TrueZen.nvim)
              zen_mode = "truezen",
            }
          },
        }
      }
    end
  }

  -- marks
  use {
    "chentoast/marks.nvim",
    config = function ()
      require'marks'.setup{}
    end
  }

  use {
    "lifepillar/pgsql.vim",
    config = function ()
      vim.cmd [[let g:sql_type_default = 'pgsql']]
    end
  }
end)

