if vim.g.win64_loaded then
  return
end
vim.g.win64_loaded = true

require('win64.options')
require('win64.keymaps')
require('win64.plugins')
require('win64.lsp')
require('win64.format')
require('win64.check')
