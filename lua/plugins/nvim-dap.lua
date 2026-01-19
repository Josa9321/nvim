return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")
        dap_virtual_text.setup()
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
        vim.fn.sign_define("DapBreakpoint", { text = "🐞" })
        vim.keymap.set('n', '<Leader>dt', function() dap.toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
        vim.keymap.set('n', '<F5>', function() dap.step_over() end)
        vim.keymap.set('n', '<F6>', function() dap.step_into() end)
        vim.keymap.set('n', '<F4>', function() dap.step_out() end)

        -- Debuggers config
        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = '/home/josa/ms-vscode.cpptools-1.29.3-linux-x64/extension/debugAdapters/bin/OpenDebugAD7',
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
            },
        }
        -- dap.adapters.gdb = {
        --     type = "executable",
        --     command = "gdb",
        --     args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        -- }
        -- dap.configurations.c = {
        --     {
        --         name = "Launch",
        --         type = "gdb",
        --         request = "launch",
        --         program = function()
        --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --         end,
        --         args = {}, -- provide arguments if needed
        --         cwd = "${workspaceFolder}",
        --         stopAtBeginningOfMainSubprogram = false,
        --     },
        --     {
        --         name = "Select and attach to process",
        --         type = "gdb",
        --         request = "attach",
        --         program = function()
        --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --         end,
        --         pid = function()
        --             local name = vim.fn.input('Executable name (filter): ')
        --             return require("dap.utils").pick_process({ filter = name })
        --         end,
        --         cwd = '${workspaceFolder}'
        --     },
        --     {
        --         name = 'Attach to gdbserver :1234',
        --         type = 'gdb',
        --         request = 'attach',
        --         target = 'localhost:1234',
        --         program = function()
        --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --         end,
        --         cwd = '${workspaceFolder}'
        --     }
        -- }
        -- dap.configurations.cpp = dap.configurations.c
        -- dap.configurations.rust = dap.configurations.c
    end,
}
