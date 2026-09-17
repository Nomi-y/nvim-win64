local paths = require('win64.paths')

require('catppuccin').setup({
  flavour = 'mocha',
  transparent_background = true,
})
vim.cmd.colorscheme('catppuccin-nvim')

require('Comment').setup({
  mappings = { basic = true, extra = true },
  opleader = { line = 'gc', block = 'gb' },
})

require('nvim-autopairs').setup({})
require('ibl').setup()

require('which-key').setup({
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-...> ',
      M = '<M-...> ',
      D = '<D-...> ',
      S = '<S-...> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
    },
  },
  spec = {
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>c', group = 'Code' },
  },
})

require('mini.ai').setup({ n_lines = 500 })
require('mini.surround').setup()

local statusline = require('mini.statusline')
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
  return '%2l:%-2v'
end

require('nvim-web-devicons').setup({})

require('telescope').setup({
  defaults = {
    path_display = { 'truncate' },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
})
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require('telescope.builtin')
local map = vim.keymap.set
map('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
map('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
map('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
map('n', '<leader>ss', builtin.builtin, { desc = 'Search select telescope' })
map('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = 'Search resume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = 'Search recent files' })
map('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

map('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = 'Fuzzily search in current buffer' })

map('n', '<leader>s/', function()
  builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files' })
end, { desc = 'Search in open files' })

require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
  git_status = {
    symbols = {
      added = '',
      modified = '',
      deleted = '',
      renamed = '',
      untracked = '',
      ignored = '',
      unstaged = '',
      staged = '',
      conflict = '',
    },
  },
})
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })

require('toggleterm').setup({
  size = 15,
  direction = 'horizontal',
  open_mapping = false,
})
map('n', 'gz', '<cmd>ToggleTerm direction=horizontal size=15<CR>', { desc = 'Toggle terminal' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<leader>tc', '<cmd>ToggleTerm<CR>', { desc = 'Close terminal' })

local luasnip = require('luasnip')
luasnip.config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
})
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load({ paths = paths.snippets })

require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'snippet_forward',
      'fallback',
    },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-e>'] = {},
    ['<C-space>'] = {
      function(cmp)
        cmp.show({ providers = { 'snippets' } })
      end,
    },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
})
