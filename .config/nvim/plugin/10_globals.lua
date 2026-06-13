vim.opt.exrc = true
vim.opt.updatetime = 50
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.isfname:append("@-@")
vim.opt.shortmess:append({ a = true, I = true })

vim.opt.mouse = ""
vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.tabstop = 1
vim.opt.shiftwidth = 1
vim.opt.softtabstop = 1
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.statusline =
  "%f %r%m%=%y %{&fileencoding ? &fileencoding : &encoding} %{&fileformat} | %l:%c %p%%"
