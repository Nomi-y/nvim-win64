local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
map('n', '<leader>wd', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

map({ 'n', 'v', 'i' }, '<F2>', vim.lsp.buf.rename, { desc = 'LSP rename' })
map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
map('n', '<leader>R', function()
  if vim.fn.exists(':lsp') == 2 then
    vim.cmd('lsp restart')
  else
    vim.cmd('LspRestart')
  end
end, { desc = 'Restart LSP' })

map('n', '<leader>li', function()
  vim.cmd('checkhealth vim.lsp')
end, { desc = 'LSP info' })
map('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = 'Show keybindings' })

map('n', 'J', '10j', { desc = 'Move down 10 lines' })
map('n', 'K', '10k', { desc = 'Move up 10 lines' })
map('n', 'j', 'gj')
map('n', 'k', 'gk')

map({ 'n', 'i' }, '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
map('v', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })

local function move_line(direction)
  local mode = vim.api.nvim_get_mode().mode
  if mode:match('[vV]') or mode == '\22' then
    if direction == 'up' then
      vim.cmd("normal! '<k'<gv")
    else
      vim.cmd("normal! '>j'>gv")
    end
  else
    if direction == 'up' then
      vim.cmd('move-2')
    else
      vim.cmd('move+')
    end
  end
end

map({ 'n', 'v' }, '<A-j>', function()
  move_line('down')
end, { desc = 'Move line down' })

map({ 'n', 'v' }, '<A-k>', function()
  move_line('up')
end, { desc = 'Move line up' })

map('i', '<A-j>', function()
  move_line('down')
end, { desc = 'Move line down' })

map('i', '<A-k>', function()
  move_line('up')
end, { desc = 'Move line up' })

map('n', '<C-S-7>', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment' })

map('v', '<C-S-7>', '<Esc><Cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment' })

map('i', '<C-S-7>', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus window left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus window right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus window below' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus window above' })

map({ 'n', 'i' }, '<F1>', '<Nop>', { noremap = true, silent = true })
