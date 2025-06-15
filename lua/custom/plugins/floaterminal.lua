-- ~/.config/nvim/lua/custom/plugins/floaterminal.lua

return {
  -- Use a dummy plugin just to make Lazy.nvim happy (it won't install anything extra)
  {
    'folke/which-key.nvim', -- or any small plugin you're already using
    config = function()
      -- Your floating terminal logic goes here

      local state = {
        floating = {
          buf = -1,
          win = -1,
        },
      }

      local function CreateFloatingTerminal(opts)
        opts = opts or {}

        local width = opts.width or math.floor(vim.o.columns * 0.8)
        local height = opts.height or math.floor(vim.o.lines * 0.8)

        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local buf = nil
        if vim.api.nvim_buf_is_valid(opts.buf) then
          buf = opts.buf
        else
          buf = vim.api.nvim_create_buf(false, true)
        end

        local win_opts = {
          style = 'minimal',
          relative = 'editor',
          width = width,
          height = height,
          row = row,
          col = col,
          border = 'rounded',
        }

        local win = vim.api.nvim_open_win(buf, true, win_opts)

        return { buf = buf, win = win }
      end

      local function toggle_terminal()
        if not vim.api.nvim_win_is_valid(state.floating.win) then
          state.floating = CreateFloatingTerminal { buf = state.floating.buf }
          if vim.bo[state.floating.buf].buftype ~= 'terminal' then
            vim.cmd.term()
          end
        else
          vim.api.nvim_win_hide(state.floating.win)
        end
      end

      vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})
      vim.keymap.set('n', '<space>tt', toggle_terminal, { desc = 'Open Floating Terminal' })
    end,
  },
}
