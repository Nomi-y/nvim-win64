local M = {}

local source = debug.getinfo(1, 'S').source:sub(2)

M.prefix = vim.fs.normalize(vim.fn.fnamemodify(source, ':p:h:h:h:h:h'))
M.tools = M.prefix .. '/tools'
M.snippets = M.prefix .. '/lib/nvim/snippets'

function M.first_executable(candidates)
  for _, item in ipairs(candidates) do
    if vim.fn.executable(item) == 1 then
      return item
    end
  end
  return nil
end

function M.first_file(candidates)
  for _, item in ipairs(candidates) do
    if vim.fn.filereadable(item) == 1 then
      return item
    end
  end
  return nil
end

M.dotnet = M.first_executable({ 'dotnet' })

M.omnisharp_dll = M.first_file({ M.tools .. '/omnisharp/OmniSharp.dll' })

M.omnisharp_exe = M.first_executable({
  M.tools .. '/omnisharp/OmniSharp.exe',
  M.tools .. '/omnisharp/OmniSharp',
  'OmniSharp',
  'omnisharp',
})

M.csharpier = M.first_file({ M.tools .. '/csharpier/CSharpier.dll' })

function M.omnisharp_command()
  local args = {
    '-z',
    '--hostPID',
    tostring(vim.fn.getpid()),
    'DotNet:enablePackageRestore=false',
    '--encoding',
    'utf-8',
    '--languageserver',
  }

  local command = nil
  if M.dotnet and M.omnisharp_dll then
    command = { M.dotnet, M.omnisharp_dll }
  elseif M.omnisharp_exe then
    command = { M.omnisharp_exe }
  else
    return nil
  end

  for _, arg in ipairs(args) do
    table.insert(command, arg)
  end
  return command
end

return M
