local obsidian = require("obsidian")
local nmap = function(keys, func, desc)
  if desc then
    desc = 'Obsidian: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

obsidian.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/personal/fragment",
    }
  },

  -- Optional, if you keep notes in a specific subdirectory of your vault.
  notes_subdir = "notes",

  -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
  -- levels defined by "vim.log.levels.*".
  log_level = vim.log.levels.INFO,

  daily_notes = {
    folder = "notes/daily",
    date_format = "%Y-%m-%d",
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil
  },
  -- Where to put new notes created from completion. Valid options are
  --  * "current_dir" - put new notes in same directory as the current buffer.
  --  * "notes_subdir" - put new notes in the default notes subdirectory.
  new_notes_location = "current_dir",

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    nvim_cmp = true,
    min_chars = 2,


    wiki_link_func = function(opts)
      if opts.label ~= opts.path then
        return string.format("[[%s|%s]]", opts.path, opts.label)
      else
        return string.format("[[%s]]", opts.path)
      end
    end,
  },

  -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
  -- way then set 'mappings = {}'.
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        -- local line_num = unpack(vim.api.nvim_win_get_cursor(0)) -- 1-indexed
        -- local line = vim.api.nvim_get_current_line()
        -- print(line)
        -- if not string.match(line, "^%s*- %[[ x~>-]%].*") then
        --   line = "- [ ]" .. line
        --   vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, { line })
        --   return
        -- end
        --
        return obsidian.util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },

  -- Optional, customize how names/IDs for new notes are created.
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return suffix
  end,

  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    -- vim.fn.jobstart({ "open", url }) -- Mac OS
    vim.fn.jobstart({"xdg-open", url})  -- linux
  end,

  -- Optional, set to true if you use the Obsidian Advanced URI plugin.
  -- https://github.com/Vinzent03/obsidian-advanced-uri
  use_advanced_uri = false,

  -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  open_app_foreground = true,

  -- Optional, by default commands like `:ObsidianSearch` will attempt to use
  -- telescope.nvim, fzf-lua, fzf.vim, or mini.pick (in that order), and use the
  -- first one they find. You can set this option to tell obsidian.nvim to always use this
  -- finder.
  finder = "telescope.nvim",

  -- Optional, configure key mappings for the finder. These are the defaults.
  -- If you don't want to set any mappings this way then set
  finder_mappings = {
    -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
    -- Currently only telescope supports this.
    new = "<C-x>",
  },

  -- Optional, sort search results by "path", "modified", "accessed", or "created".
  -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
  -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
  sort_by = "modified",
  sort_reversed = true,

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "current",

  -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = true,         -- set to false to disable all additional syntax features
    update_debounce = 150, -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },

  -- Specify how to handle attachments.
  attachments = {
    confirm_img_paste = true,
    img_folder = "assets",
    -- A function that determines the text to insert in the note when pasting an image.
    -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
    -- This is the default implementation.
    ---@param client obsidian.Client
    ---@param path Path the absolute path to the image file
    ---@return string
    img_text_func = function(client, path)
      local link_path
      local vault_relative_path = client:vault_relative_path(path)
      if vault_relative_path ~= nil then
        -- Use relative path if the image is saved in the vault dir.
        link_path = vault_relative_path
      else
        -- Otherwise use the absolute path.
        link_path = tostring(path)
      end
      local display_name = vim.fs.basename(link_path)
      return string.format("![%s](%s)", display_name, link_path)
    end,
  },
})

local function new_note_on_dir(data, dir)
  local client = obsidian.get_client()

  local note
  local open_in = obsidian.util.get_open_strategy(client.opts.open_notes_in)


  dir = client.current_workspace.path.filename .. "/" .. dir

  if data ~= nil and data.args:len() > 0 then
    note = client:new_note(data.args, nil, dir)
  else
    local title = vim.fn.input {
      prompt = "Enter title (optional): ",
    }
    if string.len(title) == 0 then
      title = nil
    end
    note = client:new_note(title, nil, dir)
  end
  vim.api.nvim_command(open_in .. tostring(note.path))
end

local function new_inbox(data)
  return new_note_on_dir(data, "notes/inbox")
end

local function git_sync()
  vim.api.nvim_echo({ { 'git sync running', 'Normal' } }, true, {})
  local cmd = string.format("git add -A && git commit -m 'sync' && git push")
  local result = vim.fn.system(cmd)
  vim.api.nvim_echo({ { result, 'Normal' } }, true, {})
end

vim.api.nvim_create_user_command('ObsidianInbox', new_inbox, { nargs = '?' })
vim.api.nvim_create_user_command('ObsidianGitSync', git_sync, { nargs = '?' })

nmap("<leader>oi", vim.cmd.ObsidianInbox, "[O]bsidian [I]nbox")
nmap("<leader>ot", vim.cmd.ObsidianToday, "[O]bsidian [T]oday daily note")
nmap("<leader>oy", vim.cmd.ObsidianYesterday, "[O]bsidian [Y]esterday daily note")
nmap("<leader>og", vim.cmd.ObsidianGitSync, "[O]bsidian [G]it Sync")

-- TODO: Create command to generate weekly notes
