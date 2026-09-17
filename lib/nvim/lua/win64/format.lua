local paths = require('win64.paths')

local formatters = {}
local formatters_by_ft = {}

if paths.csharpier and paths.dotnet then
  formatters.csharpier = {
    command = paths.dotnet,
    args = { paths.csharpier, 'format', '--stdin-path', '$FILENAME' },
    stdin = true,
  }
  formatters_by_ft.cs = { 'csharpier' }
end

require('conform').setup({
  notify_on_error = true,
  formatters = formatters,
  formatters_by_ft = formatters_by_ft,
  format_on_save = {
    timeout_ms = 5000,
    lsp_format = 'fallback',
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
