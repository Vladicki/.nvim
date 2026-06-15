return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = true,
      char = '│',
      scope = {
        enabled = true,
        char = '│',
        underline = false,
      },
    },
    scope = { enabled = true },
  },
}
