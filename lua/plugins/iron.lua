return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")

    iron.setup {
      config = {
        repl_definition = {
          python = {
            command = {"python3"},
            format = require("iron.fts.common").bracketed_paste
          },
          r = {
            command = { "R", "--quiet" }
            },
        },
        repl_open_cmd = require("iron.view").split.vertical.botright(),
      },
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_mark = "<leader>sm",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr = "<leader>s<cr>",
        interrupt = "<leader>s<space>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
      highlight = {
        italic = true
      },
      ignore_blank_lines = true,
    }
  end,
}
