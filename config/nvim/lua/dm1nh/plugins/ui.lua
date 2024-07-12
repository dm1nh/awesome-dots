return {
  { -- better vim.notify()
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all notifications",
      },
      {
        "<leader>uN",
        function()
          require("telescope").extensions.notify.notify()
        end,
        desc = "Notifications History",
      },
    },
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      Utils.on_very_lazy(function()
        vim.notify = require("notify")
      end)
    end,
  },

  { -- my simple statusline
    "statusline",
    dev = true,
    config = function()
      require("statusline").setup()
    end,
  },

  { -- mini.files
    "echasnovski/mini.files",
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          if not require("mini.files").close() then
            require("mini.files").open()
          end
        end,
        desc = "Mini files",
      },
      { -- nice way to do that like oil
        "-",
        function()
          local MiniFiles = require("mini.files")
          local current_file = vim.fn.expand("%")
          local _ = MiniFiles.close() or MiniFiles.open(current_file, false)
          vim.defer_fn(function()
            MiniFiles.reveal_cwd()
          end, 30)
        end,
      },
    },
    config = function()
      local minifiles = require("mini.files")
      -- create mappings for splits
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          local window = minifiles.get_target_window()
          -- ensure doesn't make weired behaviour on directories
          if window == nil or minifiles.get_fs_entry().fs_type == "directory" then
            return
          end
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)
          minifiles.set_target_window(new_target_window)
          minifiles.go_in({})
          minifiles.close()
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = "Split " .. direction
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- set up ability to confirm changes with :w
          vim.api.nvim_set_option_value("buftype", "acwrite", { buf = buf_id })
          vim.api.nvim_buf_set_name(buf_id, string.format("mini.files-%s", vim.loop.hrtime()))
          vim.api.nvim_create_autocmd("BufWriteCmd", {
            buffer = buf_id,
            callback = function()
              minifiles.synchronize()
            end,
          })
          -- Tweak keys to your liking
          map_split(buf_id, "gs", "belowright horizontal")
          map_split(buf_id, "gv", "belowright vertical")
        end,
      })
      -- make rounded borders, credit to MariaSolos
      vim.api.nvim_create_autocmd("User", {
        desc = "Add rounded corners to minifiles window",
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          vim.api.nvim_win_set_config(args.data.win_id, { border = "rounded" })
        end,
      })

      -- change default directory icon
      local my_prefix = function(fs_entry)
        if fs_entry.fs_type == "directory" then
          return "󰉋 ", "MiniFilesDirectory"
        end
        return minifiles.default_prefix(fs_entry)
      end

      -- g~ to set current directory
      local files_set_cwd = function()
        -- Works only if cursor is on the valid file system entry
        local cur_entry_path = minifiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.chdir(cur_directory)
      end

      -- toggle dotfiles
      local hide_patterns = { "node_modules" }
      local show_dotfiles = false

      local filter_show = function()
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".") and not vim.tbl_contains(hide_patterns, fs_entry.name)
      end

      local gio_open = function()
        local fs_entry = minifiles.get_fs_entry()
        if fs_entry ~= nil then
          vim.notify(vim.inspect(fs_entry))
          vim.fn.system(string.format("gio open '%s'", fs_entry.path))
        end
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        minifiles.refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id })
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
          vim.keymap.set("n", "<CR>", gio_open, { buffer = buf_id })
        end,
      })

      -- setup opts
      minifiles.setup({
        content = {
          prefix = my_prefix,
          filter = show_dotfiles and filter_show or filter_hide,
          sort = function(entries)
            -- technically can filter entries here too, and checking gitignore for _every entry individually_
            -- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
            -- at once, which is much more performant.
            local all_paths = table.concat(
              vim
                .iter(entries)
                :map(function(entry)
                  return entry.path
                end)
                :totable(),
              "\n"
            )
            local output_lines = {}
            local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
              stdout_buffered = true,
              on_stdout = function(_, data)
                output_lines = data
              end,
            })

            -- command failed to run
            if job_id < 1 then
              return entries
            end

            -- send paths via STDIN
            vim.fn.chansend(job_id, all_paths)
            vim.fn.chanclose(job_id, "stdin")
            vim.fn.jobwait({ job_id })
            return require("mini.files").default_sort(vim
              .iter(entries)
              :filter(function(entry)
                return not vim.tbl_contains(output_lines, entry.path)
              end)
              :totable())
          end,
        },
        mappings = {
          -- synchronize = "w", -- use :w to secure the changes
          go_in_plus = "<CR>",
        },
        options = {
          permanent_delete = false,
          use_as_default_explorer = true,
        },
        windows = {
          width_focus = 32,
          width_nofocus = 20,
        },
      })
    end,
  },

  { -- telescope
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    keys = function()
      local b = require("telescope.builtin")

      return {
        -- for convenience
        {
          "<leader><leader>",
          b.find_files,
          desc = "Files",
        },
        {
          "<leader>b",
          function()
            b.buffers({ sort_mru = true, sort_lastused = true })
          end,
          desc = "Buffers",
        },
        {
          "<leader>/",
          b.live_grep,
          desc = "Grep",
        },
        -- search
        {
          "<leader>sb",
          function()
            b.buffers({ sort_mru = true, sort_lastused = true })
          end,
          desc = "Buffers",
        },
        { "<leader>sc", b.command_history, desc = "Last commands" },
        { "<leader>sf", b.find_files, desc = "Files" },
        { "<leader>sg", b.git_files, desc = "Git files" },
        { "<leader>sR", b.oldfiles, desc = "Recent files" },
        { "<leader>sr", b.live_grep, desc = "Grep" },
        { "<leader>sh", b.help_tags, desc = "Help tags" },
        { "<leader>sm", b.man_pages, desc = "Man pages" },
        -- Git
        { "<leader>gc", b.git_commits, desc = "Git commits" },
        { "<leader>gs", b.git_status, desc = "Git status" },
      }
    end,
    config = function()
      require("telescope").setup({})
    end,
  },

  { -- help me remember neovim keybindings
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["z"] = { name = "+fold" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>B"] = { name = "+buffers", _ = "which_key_ignore" },
        ["<leader>c"] = { name = "+code", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "+git", _ = "which_key_ignore" },
        ["<leader>gh"] = { name = "+hunk", _ = "which_key_ignore" },
        ["<leader>q"] = { name = "+session", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "+search", _ = "which_key_ignore" },
        ["<leader>u"] = { name = "+ui", _ = "which_key_ignore" },
        ["<leader>ut"] = { name = "+toggle", _ = "which_key_ignore" },
        ["<leader>x"] = { name = "+diagnostics", _ = "which_key_ignore" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  { -- trouble
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Workspace diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location list (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix list (Trouble)",
      },
    },
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>ghd", gs.diffthis, "Diff this")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff this ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns select hunk")
      end,
    },
  },

  {
    "nvimdev/indentmini.nvim",
    config = function()
      require("indentmini").setup() -- use default config
    end,
  },

  { -- zen mode
    "folke/zen-mode.nvim",
    config = function()
      vim.wo.wrap = false
      vim.wo.number = false
      vim.wo.rnu = false
      require("zen-mode").setup({
        window = {
          width = 120,
        },
      })
    end,
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Zen mode",
      },
    },
  },
}
