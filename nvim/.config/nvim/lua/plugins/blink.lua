return {
  {
    "saghen/blink.cmp",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      completion = {
        menu = {
          -- Disable auto popup in writing-oriented buffers.
          auto_show = function()
            local ft = vim.bo.filetype
            return not vim.tbl_contains({
              "markdown",
              "text",
              "gitcommit",
            }, ft)
          end,
        },
      },
      keymap = {
        -- Keep LazyVim's default enter preset and make Ctrl+Space explicit.
        preset = "enter",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      },
    },
  },
}
