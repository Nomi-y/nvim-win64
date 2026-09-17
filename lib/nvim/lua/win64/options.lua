local paths = require('win64.paths')

local is_windows = vim.fn.has('win32') == 1
local bin = paths.prefix .. '/bin'
if is_windows then
  bin = bin:gsub('/', '\\')
end
if vim.fn.isdirectory(bin) == 1 then
  local sep = is_windows and ';' or ':'
  local current = vim.env.PATH or ''
  if not (sep .. current .. sep):find(sep .. bin .. sep, 1, true) then
    vim.env.PATH = bin .. sep .. current
  end
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

vim.g.VM_maps = {
  ['Add Cursor Up'] = '<A-K>',
  ['Add Cursor Down'] = '<A-J>',
  ['Select All'] = '<A-a>',
}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shortmess:append('I')
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

if is_windows then
  local shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
  vim.o.shell = shell
  vim.o.shellcmdflag = '-NoLogo -NoProfile -Command'
  vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('win64-highlight-yank', { clear = true }),
  callback = function()
    local hl = vim.hl or vim.highlight
    hl.on_yank()
  end,
})
