return {
  'monaqa/dial.nvim',
  keys = {
    {
      '<C-a>',
      function()
        return require('dial.map').inc_normal()
      end,
      expr = true,
      mode = 'n',
    },
    {
      '<C-x>',
      function()
        return require('dial.map').dec_normal()
      end,
      expr = true,
      mode = 'n',
    },
    {
      'g<C-a>',
      function()
        return require('dial.map').inc_gnormal()
      end,
      expr = true,
      mode = 'n',
    },
    {
      'g<C-x>',
      function()
        return require('dial.map').dec_gnormal()
      end,
      expr = true,
      mode = 'n',
    },
  },
  config = function()
    local augend = require 'dial.augend'
    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.date.alias['%Y/%m/%d'],
        augend.constant.alias.bool,
        --
        -- Operators
        augend.constant.new { elements = { '&&', '||' } },
        augend.constant.new { elements = { 'yes', 'no' } },
        augend.constant.new { elements = { 'Yes', 'No' } },
        augend.constant.new { elements = { 'and', 'or' } },
        augend.constant.new { elements = { '==', '!=' } },
        augend.constant.new { elements = { '!==', '===' } },
        augend.constant.new { elements = { '++', '--' } },
        augend.constant.new { elements = { '+', '-' } },
        augend.constant.new { elements = { '*', '/' } },
        augend.constant.new { elements = { '++', '--' } },
        augend.constant.new { elements = { 'and', 'or' } },
        augend.constant.new { elements = { '&&', '||' } },
        augend.constant.new { elements = { 'True', 'False' } },
        augend.constant.alias.jan, -- months
        augend.constant.alias.weekday, -- weekdays
      },
    }
  end,
}
