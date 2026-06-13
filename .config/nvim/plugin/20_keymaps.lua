vim.g.mapleader = " "

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>q", "<cmd>Oil<CR>")
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set({'n', 'x', 'v'}, '<leader>p', '"+p:"')

vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true })
end)



vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, {
    border = "rounded",
    source = "always",
  })
end, { desc = "Show diagnostic" })
