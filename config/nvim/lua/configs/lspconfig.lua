local configs = require "nvchad.configs.lspconfig"

local custom_on_attach = function(client, bufnr)
  configs.on_attach(client, bufnr)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  buf_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local servers = {
  gopls = {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        buildFlags = { "-tags", "integration" },
        staticcheck = true,
        gofumpt = true,
        verboseOutput = true,
        completeUnimported = true,
        experimentalPostfixCompletions = true,
        usePlaceholders = true,
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
        },
        hints = {
          constantValues = true,
          parameterNames = true,
          assignVariableType = true,
          rangeVariableTypes = true,
          compositeLiteralTypes = true,
          compositeLiteralFields = true,
          functionTypeParameters = true,
        },
      },
    },
  },
  graphql = {},
  tsserver = {},
  nixd = {},
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = custom_on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
