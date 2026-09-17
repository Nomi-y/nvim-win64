local paths = require('win64.paths')

local function run(cmd)
  local ok, result = pcall(function()
    return vim.system(cmd, { text = true }):wait()
  end)
  if ok and result.code == 0 then
    return vim.trim((result.stdout or ''):gsub('\n.*', ''))
  end
  return nil
end

local function report()
  local lines = {
    'Neovim setup check',
    '',
    'neovim        ' .. table.concat({ vim.version().major, vim.version().minor, vim.version().patch }, '.'),
    'install root  ' .. paths.prefix,
    'shell         ' .. vim.o.shell,
    '',
  }

  local dotnet_version = paths.dotnet and run({ paths.dotnet, '--version' })
  local omnisharp_cmd = paths.omnisharp_command()

  table.insert(lines, 'dotnet        ' .. (dotnet_version or 'NOT FOUND'))
  local omnisharp_shown = 'NOT FOUND'
  if omnisharp_cmd then
    local head = #omnisharp_cmd > 1 and table.concat(omnisharp_cmd, ' ', 1, 2) or omnisharp_cmd[1]
    omnisharp_shown = head .. '  [' .. paths.omnisharp_kind .. ']'
  end
  table.insert(lines, 'omnisharp     ' .. omnisharp_shown)
  table.insert(lines, 'csharpier     ' .. (paths.csharpier or 'NOT FOUND'))
  table.insert(lines, 'ripgrep       ' .. (vim.fn.exepath('rg') ~= '' and vim.fn.exepath('rg') or 'NOT FOUND'))
  table.insert(lines, 'fd            ' .. (vim.fn.exepath('fd') ~= '' and vim.fn.exepath('fd') or 'NOT FOUND'))
  table.insert(lines, '')

  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    table.insert(lines, 'lsp clients   none attached to this session')
  else
    for _, client in ipairs(clients) do
      table.insert(lines, 'lsp client    ' .. client.name .. ' (id ' .. client.id .. ')')
    end
  end

  table.insert(lines, '')
  local plugins = {}
  for _, dir in ipairs(vim.fn.globpath(paths.prefix .. '/lib/nvim/pack/bundle/start', '*', false, true)) do
    table.insert(plugins, vim.fn.fnamemodify(dir, ':t'))
  end
  table.insert(lines, 'plugins       ' .. #plugins .. ' loaded from pack/bundle/start')
  table.insert(lines, '              ' .. table.concat(plugins, ' '))

  return lines
end

vim.api.nvim_create_user_command('SetupCheck', function()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, report())
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'
  vim.cmd.split()
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_height(0, 22)
end, { desc = 'Show the setup report' })
