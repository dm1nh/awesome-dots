return {
  {
    "echasnovski/mini.hipatterns",
    event = "LazyFile",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
          shorthand = {
            pattern = "()#%x%x%x()%f[^%x%w]",
            group = function(_, _, data)
              ---@type string
              local match = data.full_match
              local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
              local hex_color = "#" .. r .. r .. g .. g .. b .. b

              return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
            end,
            extmark_opts = { priority = 2000 },
          },
          hsl_color = {
            pattern = "hsl%(%d+,? %d+,? %d+%)",
            group = function(_, match)
              local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
              h, s, l = tonumber(h), tonumber(s), tonumber(l)
              local hex_color = Utils.hsl_to_hex(h, s, l)
              return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
            end,
          },
        },
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load()
        end,
        desc = "Stop saving session",
      },
    },
    opts = {},
  },
  { -- provide some functions for other plugins
    "nvim-lua/plenary.nvim",
  },
  { -- provide icons
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override_by_filename = require("dm1nh.defaults").override_web_devicons.filename,
      override_by_extension = require("dm1nh.defaults").override_web_devicons.extension,
    },
  },
}
