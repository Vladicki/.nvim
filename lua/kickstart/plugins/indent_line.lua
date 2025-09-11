return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      scope = {
        enabled = true,
        highlight = { 'IblScope' }, -- highlight for the *current* scope
        show_start = true,
        show_end = true,
      },
    },
  },
}
