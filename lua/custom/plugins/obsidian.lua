return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '/home/vla/obsidian',
      },
      -- {
      --   name = 'work',
      --   path = '~/vaults/work',
      -- },
    },

    -- see below for full list of options 👇
    dir = '/home/vla/obsidian',

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    -- notes_subdir = "/notes",

    -- daily_notes = {
    --   -- Optional, if you keep daily notes in a separate directory.
    --   folder = 'notes/dailies',
    --   -- Optional, if you want to change the date format for the ID of daily notes.
    --   date_format = '%Y-%m-%d',
    --   -- Optional, if you want to change the date format of the default alias of daily notes.
    --   alias_format = '%B %-d, %Y',
    --   -- Optional, default tags to add to each new daily note created.
    --   default_tags = { 'daily-notes' },
    --   -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    --   template = nil,
    -- },
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<leader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    -- Where to put new notes. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = 'current_dir',
  },

  config = function(_, opts)
    require('obsidian').setup(opts)

    -- Set conceallevel to 1 for markdown buffers
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.conceallevel = 1
      end,
    })
  end,

  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = 'telescope.nvim',
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    note_mappings = {
      -- Create a new note from your query.
      new = '<leader>ox>',
      -- Insert a link to the selected note.
      insert_link = '<leader>ol>',
    },
    tag_mappings = {
      -- Add tag(s) to current note.
      tag_note = '<leader>ox>',
      -- Insert a tag at the current location.
      insert_tag = '<leader>ol>',
    },
  },
}
