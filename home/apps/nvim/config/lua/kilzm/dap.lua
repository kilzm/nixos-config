local Remap    = require('kilzm.keymap')
local nnoremap = Remap.nnoremap

local dap      = require('dap')

local dapui = require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
    },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.odin = dap.configurations.c

nnoremap("<leader>dt", dapui.toggle, { desc = "Toggle Dap UI" })
nnoremap("<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
nnoremap("<leader>dc", dap.continue, { desc = "Continue" })
nnoremap("<F1>", dap.step_over, { desc = "Step over" })
nnoremap("<F2>", dap.step_into, { desc = "Step into" })
nnoremap("<F3>", dap.step_out, { desc = "Step out" })
nnoremap("<leader>dh", require('dap.ui.widgets').hover, { desc = "Step out" })
