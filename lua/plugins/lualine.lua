return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' '
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    vim.o.laststatus = vim.g.lualine_laststatus
    local icons = {
      diagnostics = { Error = ' ', Warn = ' ', Info = ' ', Hint = '󰌵 ' },
      git = { added = ' ', modified = ' ', removed = ' ' },
    }
    local function filesize()
      local size = vim.fn.getfsize(vim.fn.expand '%')
      if size <= 0 then
        return ''
      end
      local units = { 'B', 'KB', 'MB', 'GB' }
      local i = 1
      while size > 1024 and i < #units do
        size = size / 1024
        i = i + 1
      end
      return string.format('%.1f%s', size, units[i])
    end
    return {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'snacks_dashboard' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          { 'diagnostics', symbols = icons.diagnostics },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
        },
        lualine_x = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' },
          },
          {
            'diff',
            symbols = icons.git,
            source = function()
              local gs = vim.b.gitsigns_status_dict
              if gs then
                return { added = gs.added, modified = gs.changed, removed = gs.removed }
              end
            end,
          },
        },
        lualine_y = {
          { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          filesize,
          function()
            return ' ' .. os.date '%R'
          end,
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }
  end,
}
