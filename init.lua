require("vim-options")
require("keymaps")
require("config.lazy")
vim.cmd [[highlight Cursor blend=30]]
vim.filetype.add({
  extension = {
    ipynb = "jupyter",
  },
})