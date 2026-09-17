local paths = require('win64.paths')

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('win64-lsp-attach', { clear = true }),
  callback = function(event)
    local builtin = require('telescope.builtin')
    local function map(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', builtin.lsp_definitions, 'Goto definition')
    map('gr', builtin.lsp_references, 'Goto references')
    map('gI', builtin.lsp_implementations, 'Goto implementation')
    map('gO', builtin.lsp_document_symbols, 'Document symbols')
    map('gW', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')
    map('<leader>D', builtin.lsp_type_definitions, 'Type definition')
    map('grt', builtin.lsp_type_definitions, 'Goto type definition')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'v' })
    map('<C-k>', vim.lsp.buf.hover, 'Hover documentation')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local group = vim.api.nvim_create_augroup('win64-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
      end, 'Toggle inlay hints')
    end
  end,
})

local omnisharp_config = {
  cmd_env = { DOTNET_ROLL_FORWARD = 'LatestMajor' },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      EnableImportCompletion = true,
      EnableDecompilationSupport = true,
      EnableAnalyzersSupport = false,
    },
    Sdk = {
      IncludePrereleases = true,
    },
  },
}

local function quiet_rpc(command)
  return function(dispatchers, config)
    local on_error = dispatchers.on_error
    dispatchers.on_error = function(code, err)
      if code == vim.lsp.rpc.client_errors.INVALID_SERVER_MESSAGE and err == vim.NIL then
        return
      end
      on_error(code, err)
    end
    return vim.lsp.rpc.start(command, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end
end

local omnisharp_cmd = paths.omnisharp_command()
if omnisharp_cmd then
  omnisharp_config.cmd = quiet_rpc(omnisharp_cmd)
end

vim.lsp.config('omnisharp', omnisharp_config)
vim.lsp.enable('omnisharp')
