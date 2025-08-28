return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      width = 72, -- Adjusted width to accommodate new sections, you can change it back to 18 if you prefer

      sections = {
        {
          header = [[
                                                                   
      ████ ██████           █████      ██                 btw
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
        },
        -- Your key shortcuts
        {
          section = 'keys', -- Explicitly define this as a keys section
          value = {
            { icon = '', key = 'f', desc = ' ̲find file', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = '', key = 'n', desc = ' ̲new file', action = ':ene | startinsert' },
            { icon = '', key = 'g', desc = ' ̲grep text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = '', key = 'r', desc = ' ̲recent file', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = '', key = 'c', desc = ' ̲config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '', key = 's', desc = ' ̲session', action = ":lua require('mini.sessions').open()" }, -- Corrected action for session picker
            { icon = '', key = 'L', desc = ' ̲Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = '', key = 'q', desc = ' ̲quit', action = ':qa' },
          },
        },
        -- The custom text row with icons
        {
          align = 'center',
          padding = 1,
          text = {
            { '  Update ', hl = 'Label' },
            { '  Sessions ', hl = '@property' },
            { '  Last Session ', hl = 'Number' },
            { '  Files ', hl = 'DiagnosticInfo' },
            { '  Recent ', hl = '@string' },
          },
        },
        -- Startup section
        { section = 'startup', padding = 1 },
        -- Projects section (now letting Snacks.nvim handle the picker)
        { icon = '󰏓 ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        -- Recent Files section (now letting Snacks.nvim handle the picker)
        { icon = ' ', title = 'Recent Files', limit = 9, section = 'recent_files', indent = 2, padding = 1 },
        -- Additional key-bound actions
        -- { text = 'Update Plugins', action = ':Lazy update', key = 'u' }, -- Added descriptive text
      },
      -- formats = { key = { "" }, }, -- Removed as requested
    },

    -- Individual feature toggles
    bigfile = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- Other disabled features can remain commented out or be removed if not used
  },
}
