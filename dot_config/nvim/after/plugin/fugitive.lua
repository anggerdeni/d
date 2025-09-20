local nmap = function(keys, func, desc)
  if desc then
    desc = 'Fugitive: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

nmap("<leader>gs", vim.cmd.Git, "Git status")
