vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F9>', function() require('dap').disconnect() end)

vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

local dap = require('dap')
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
      command = '/home/mateusz/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb', -- adjust as needed, must be absolute Path
      args = { "--port", "${port}" },
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
