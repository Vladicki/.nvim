return {
  {
    -- NOTE:
    -- GoTagAdd adds tags to the scruct json/yaml
    -- GoIfErr,
    -- GoTestsAll - Generate all tests for all functions/methods in the current file
    --  :GoTestsExp   - Generate tests for only  exported functions/methods in the current file
    --  :GoTestAdd    - Generate one test for a specific function/method(one under cursor)
    -- :GoImpl [receiver] [interface]
    --      :GoImpl [interface]  " also you can put a cursor on the struct and run
    -- GoMod tidy updates go.mod file
    --      :GoMod init new-shiny-project
    -- GoGet - download a package
    -- :GoWork sync  - go work commands
    -- GoGenerate +/% run go generate in cwd +/ for the current file
    'olexsmir/gopher.nvim',
    ft = 'go',
    -- branch = "develop"
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@module "gopher"
    ---@type gopher.Config
    opts = {},
    config = function()
      -- Only set keymaps if gopher loaded successfully
      local ok, _ = pcall(require, 'gopher')
      if not ok then
        return
      end

      -- GoIfErr: insert if err != nil checks
      vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<CR>', { desc = ': Insert if err != nil' })

      -- GoTestsAll: generate tests for all functions/methods in the current file
      vim.keymap.set('n', '<leader>gt', '<cmd>GoTestsAll<CR>', { desc = 'Go: Generate all tests' })

      -- GoTagAdd: add struct tags (json/yaml)
      vim.keymap.set('n', '<leader>gT', '<cmd>GoTagAdd<CR>', { desc = 'Go: Add struct tags' })

      -- GoMod tidy: update go.mod file
      vim.keymap.set('n', '<leader>gm', '<cmd>GoMod tidy<CR>', { desc = 'Go: Tidy go.mod' })

      -- GoWork sync: manage Go workspace
      vim.keymap.set('n', '<leader>gw', '<cmd>GoWork sync<CR>', { desc = 'Go: Sync workspace' })

      -- GoCmt: generate comment for function/struct/etc.
      vim.keymap.set('n', '<leader>gc', '<cmd>GoCmt<CR>', { desc = 'Go: Generate comment' })

      -- GoImpl: open command with :GoImpl ready for typing
      vim.keymap.set('n', '<leader>gi', ':GoImpl ', { desc = 'Go: Implement interface', silent = false })
    end,
  },
}
