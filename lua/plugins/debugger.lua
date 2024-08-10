return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
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
      vim.keymap.set('n', '<leader>du', require 'dapui'.toggle, { desc = 'Toggle debugger UI' })

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

      local js_based_languages = { "typescript", "javascript", "javascriptreact", "typescriptreact" }

      require('dap.ext.vscode').load_launchjs(nil,
        {
          ['pwa-node'] = js_based_languages,
          ['pwa-chrome'] = js_based_languages,
          ['node'] = js_based_languages,
          ['chrome'] = js_based_languages,
        }
      )

      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = os.getenv('HOME') .. '/works/vscode-js-debug',
        -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })

      -- dap.adapters.firefox = {
      --   type = 'executable',
      --   command = 'node',
      --   args = { os.getenv('HOME') .. '/works/vscode-firefox-debug/dist/adapter.bundle.js' },
      -- }

      -- dap.configurations.typescriptreact = {
      --   {
      --     name = 'Debug with Firefox',
      --     type = 'firefox',
      --     request = 'launch',
      --     reAttach = true,
      --     -- url = 'http://localhost:5000',
      --     url = 'https://dev.teamshirts.de',
      --     -- url = 'https://wizard-dev.teamshirts.de/de/DE/generic',
      --     sourceMaps = true,
      --     webRoot = '${workspaceFolder}',
      --     firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox',
      --   }
      -- }


      -- dap.adapters.chrome = {
      --   type = "executable",
      --   command = "node",
      --   args = { os.getenv("HOME") .. "/works/vscode-chrome-debug/out/src/chromeDebug.js" } -- Update this path
      -- }

      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file - nvim",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach - nvim",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome - nvim",
            url = "http://localhost:5000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
          },
        }
      end


      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { '/Users/yasser/works/spreadgroup/vscode-php-debug/out/phpDebug.js' }
      }

      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug',
          port = 9003
        }
      }
    end,
  }
}
