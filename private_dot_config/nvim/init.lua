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

vim.cmd [[set shortmess+=F]]
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require'go.format'.goimport() ]], false)

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
      vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tagsopts<CR>]], opts)
      vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
    end
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

      vim.api.nvim_set_keymap('n', '<Leader>on', ':NvimTreeToggle<CR>', { noremap=true, silent=true })
    end
  }

  -- treesitter
  -- use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap=true, silent=true }
      vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      end

      -- lspconfig setup
      local lspconfig = require'lspconfig'

      lspconfig.gopls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
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

  -- -- go
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
  --     -- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require'go.format'.goimport() ]], false)
  --   end
  -- }

  -- neorg
  use {
    "nvim-neorg/neorg",
    requires = "nvim-lua/plenary.nvim",
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
                home = "~/notes/home"
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
        }
      }
    end
  }
end)
