return {
  'jonarrien/telescope-cmdline.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { 'Q', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' },
    { '<leader><leader>', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        cmdline = {
          picker = {
            layout_config = {
              width = 120,
              height = 25,
            },
          },
          mappings = {
            complete = '<Tab>',
            run_selection = '<C-CR>',
            run_input = '<CR>',
          },
          overseer = {
            enabled = true,
          },
        },
      },
    }

    -- Load the cmdline extension
    require('telescope').load_extension 'cmdline'
  end,
}
