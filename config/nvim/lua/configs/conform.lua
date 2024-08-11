-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    go = { "gofumpt", "goimports" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    toml = { "taplo" },
    yaml = { "yamlfix" },
    json = { "jq" },
    nix = { "nixfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
