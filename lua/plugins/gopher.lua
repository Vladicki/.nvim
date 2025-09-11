return {
  {
    -- NOTE:
    -- GoTagAdd json/yaml
    -- GoIfErr,
    -- GoTestsAll - Generate all tests for all functions/methods in the current file
    --  :GoTestsExp   - Generate tests for only  exported functions/methods in the current file
    --  :GoTestAdd    - Generate one test for a specific function/method(one under cursor)
    -- impl
    -- GoMod tidy ?
    -- GoGet - download a package
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
  },
}
