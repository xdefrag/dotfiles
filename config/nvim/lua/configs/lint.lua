require("lint").linters_by_ft = {
  go = { "golangcilint" },
}

local linting_group = vim.api.nvim_create_augroup("Linting", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = linting_group,
  pattern = "*.go",
  callback = function()
    require("lint").try_lint()
  end,
})
