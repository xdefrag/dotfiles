require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Open Fugitive" })

map("n", "<leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { desc = "Find symbols" })

map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Continue" })
map("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<cr>", { desc = "Open REPL" })
map("n", "<leader>ds", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step over" })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step out" })
map("n", "<leader>dt", "<cmd>lua require('dap-go').debug_test()<cr>", { desc = "Debug test" })
map("n", "<leader>dl", "<cmd>lua require('dap-go').debug_last_test()<cr>", { desc = "Debug last test" })

map("n", "<leader>a", ":Other<CR>", { desc = "Alternate file" })

map("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Test nearest" })
map("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Test file" })
map("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug test" })
map("n", "<leader>to", "<cmd>lua require('neotest').output_panel.toggle()<cr>", { desc = "Output panel" })
