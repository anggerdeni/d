local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local nmap = function(keys, func, desc)
  if desc then
    desc = 'Harpoon: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap("<leader>m", mark.add_file, "[M]ark file and add it to harpoon")
nmap("<C-e>", ui.toggle_quick_menu, "Toggle harpoon menu")

nmap("<C-h>", function () ui.nav_file(1) end, "Navigate to harpoon file 1")
nmap("<C-j>", function () ui.nav_file(2) end, "Navigate to harpoon file 2")
nmap("<C-k>", function () ui.nav_file(3) end, "Navigate to harpoon file 3")
nmap("<C-l>", function () ui.nav_file(4) end, "Navigate to harpoon file 4")

