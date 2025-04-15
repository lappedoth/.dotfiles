return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "github/copilot.vim",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("BufReadPre", {
        pattern = "*.py",
        callback = function()
          require("lazy").load({ plugins = { "copilot.vim" } })
        end,
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              local filetype = vim.api.nvim_buf_get_option(ctx.bufnr, "filetype")
              if filetype == "tex" then
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local line = vim.api.nvim_get_current_line()
                local char_before_cursor = line:sub(col, col)
                return char_before_cursor == "\\"
              end
              return true
            end,
          },
          {
            name = "luasnip",
            entry_filter = function(entry, ctx)
              local filetype = vim.api.nvim_buf_get_option(ctx.bufnr, "filetype")
              if filetype == "tex" then
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local line = vim.api.nvim_get_current_line()
                local char_before_cursor = line:sub(col, col)
                return char_before_cursor == "\\"
              end
              return true
            end,
          },
          { name = "buffer" },
          { name = "path" },
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      vim.g.vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
    end,
    ft = { "tex" },
  },
}
