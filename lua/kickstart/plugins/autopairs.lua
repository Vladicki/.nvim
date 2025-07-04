-- autopairs
-- https://github.com/windwp/nvim-autopairs
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = true,
  opts = {
    check_ts = true, -- enable treesitter integration for smarter pairing
    disable_filetype = { -- Disable autopairs for some filetypes
      'TelescopePrompt',
      'vim',
    },
    enable_check_bracket_line = true, -- Don't add closing pair if it already exists on the line
    ignored_next_char = '[%w%.]', -- Don't add closing pair if next char is alphanumeric or `.`
  },
}
