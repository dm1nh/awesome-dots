return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { -- better dap ui
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      keys = {
        {
          "<leader>du",
          function()
            require("dapui").toggle()
          end,
          desc = "Toggle Dap UI",
        },
        {
          "<leader>de",
          function()
            require("dapui").eval()
          end,
          mode = { "n", "v" },
          desc = "Eval",
        },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    { -- virtual text for the debugger
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    { -- add keys
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
        },
      },
    },

    { -- mason.nvim integration
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },

    { -- vscode launch.json parser
      "folke/neoconf.nvim",
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no exec)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(require("dm1nh.defaults").icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define("Dap" .. name, {
        text = sign[1],
        texthl = sign[2] or "DiagnosticInfo",
        linehl = sign[3],
        numhl = sign[3],
      })
    end

    -- setup dap config by VsCode launch.json file
    local vscode = require("dap.ext.vscode")
    local _filetypes = require("mason-nvim-dap.mappings.filetypes")
    local filetypes = vim.tbl_deep_extend("force", _filetypes, {
      ["node"] = {
        "javascriptreact",
        "typescriptreact",
        "typescript",
        "javascript",
      },
      ["pwa-node"] = {
        "javascriptreact",
        "typescriptreact",
        "typescript",
        "javascript",
      },
    })
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str, {}))
    end
    vscode.load_launchjs(nil, filetypes)
  end,
}
