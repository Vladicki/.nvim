-- _ + _ folder tree
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      columns = { 'icon' },
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-q>'] = { 'actions.close', mode = 'n' },
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-l>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      },
      view_options = {
        show_hidden = true,
      },
    }

    -- Open parent directory in current window
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    -- Open parent directory in floating window
    vim.keymap.set('n', '<space>-', require('oil').toggle_float)

    -- Yank path of current file, or the entry under cursor when in oil
    vim.keymap.set('n', '<leader>y', function()
      local oil = require 'oil'
      local path
      if vim.bo.filetype == 'oil' then
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        if entry and dir then
          path = dir .. entry.name
        end
      else
        path = vim.fn.expand '%:p'
      end

      if path and path ~= '' then
        vim.fn.setreg('+', path)
        vim.notify('Yanked: ' .. path)
      else
        vim.notify('No file path to yank', vim.log.levels.WARN)
      end
    end, { desc = '[Y]ank file path' })
  end,
}
