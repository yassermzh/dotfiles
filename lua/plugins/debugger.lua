return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({})
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,
        { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Repl" })

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

      dap.adapters.firefox = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/works/vscode-firefox-debug/dist/adapter.bundle.js' },
      }

      dap.configurations.typescriptreact = {
        {
          name = 'Debug with Firefox',
          type = 'firefox',
          request = 'launch',
          reAttach = true,
          url = 'http://localhost:5000',
          -- url = 'https://wizard-dev.teamshirts.de/de/DE/generic',
          sourceMaps = true,
          webRoot = '${workspaceFolder}',
          firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox',
        }
      }
      dap.configurations.typescript = {
        {
          name = 'Debug with Firefox',
          type = 'firefox',
         request = 'launch',
          reAttach = true,
          url = 'http://localhost:5000',
          -- url = 'https://wizard-dev.teamshirts.de/de/DE/generic',
          sourceMaps = true,
          webRoot = '${workspaceFolder}',
          firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox',
        }
      }
    end,
  }
}
