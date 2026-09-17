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
  M.tools .. '/omnisharp-framework/OmniSharp.exe',
  'OmniSharp',
  'omnisharp',
})

M.csharpier = M.first_file({ M.tools .. '/csharpier/CSharpier.dll' })

local function dotnet_runs_net10()
  if not M.dotnet then
    return false
  end
  local exe = vim.fn.exepath(M.dotnet)
  if exe == '' then
    return false
  end
  local root = vim.fs.normalize(vim.fn.fnamemodify(exe, ':h'))
  return vim.fn.glob(root .. '/shared/Microsoft.NETCore.App/10.*') ~= ''
end

local function pick_omnisharp()
  if M.omnisharp_dll and dotnet_runs_net10() then
    return { M.dotnet, M.omnisharp_dll }, 'net10'
  end
  if M.omnisharp_exe then
    return { M.omnisharp_exe }, 'framework'
  end
  if M.omnisharp_dll and M.dotnet then
    return { M.dotnet, M.omnisharp_dll }, 'net10'
  end
  return nil, 'none'
end

M.omnisharp_base, M.omnisharp_kind = pick_omnisharp()

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

  if not M.omnisharp_base then
    return nil
  end
  local command = vim.deepcopy(M.omnisharp_base)

  for _, arg in ipairs(args) do
    table.insert(command, arg)
  end
  return command
end

return M
