return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      file_ignore_patterns = { "node_modules", ".git" },
      extensions_list = { "import" },
    },
    config = function(_, opts)
      local telescope = require "telescope"
      local open_with_trouble = require("trouble.sources.telescope").open

      opts.defaults.mappings = {
        i = { ["<c-q>"] = open_with_trouble },
        n = { ["<c-q>"] = open_with_trouble },
      }

      telescope.setup(opts)

      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Telescope import",
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "jq",
        "gopls",
        "delve",
        "goimports",
        "gofumpt",
        "golangci-lint",
        "taplo",
        "yamlfix",
        "graphql-language-service-cli",
        "typescript-language-server",
        "prettierd",
        "nixfmt",
        "nixd",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "yaml",
        "toml",
        "make",
        "bash",
        "json",
        "proto",
        "html",
        "css",
        "go",
        "graphql",
      },
      indent = { enable = true },
      incremental_selection = { enable = true },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      auto_close = true,
      auto_preview = false,
      auto_refresh = false,
      focus = true,
      follow = false,
      warn_no_results = false,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      numhl = true,
    },
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        panel = { enabled = false },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
            next = "<C-]>",
            prev = "<C-[>",
          },
        },
        filetypes = {
          go = true,
          proto = true,
          lua = true,
          ["*"] = false,
        },
      }

      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = "CopilotChat",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {},
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-go" {
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          },
        },
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufWritePre",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "rgroli/other.nvim",
    cmd = "Other",
    config = function()
      require("other-nvim").setup {
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
          {
            context = "test",
            pattern = "(.*).ts$",
            target = "%1_test.ts",
          },
          {
            context = "implementation",
            pattern = "(.*)_test.ts$",
            target = "%1.ts",
          },
        },
      }
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Notes",
        },
      },
    },
  },
}
