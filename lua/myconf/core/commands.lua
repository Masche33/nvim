-- `Path` command to show the path of the current file
vim.api.nvim_create_user_command("Path", function()
   local filePath = vim.fn.expand("%:p")
   print(filePath)
end, {})

--  `Cpath` command to copy the path of the current file
vim.api.nvim_create_user_command("Cpath", function()
   local path = vim.fn.expand("%:p")
   vim.fn.setreg("+", path)
   vim.notify('Copied "' .. path .. '" to the clipboard')
end, {})

-- 'SM' Set Maximux, sets the max numbers of windows 
vim.api.nvim_create_user_command('SM', function(opts)
  local new_value = opts.args ~= "" and tonumber(opts.args) or vim.g.default_max_windows 
  if new_value and new_value > 0 then
    vim.g.max_windows = new_value
    print("max_windows setted to " .. vim.g.max_windows)
  else
    print("Invalid number, please give a valid number")
  end
end, { nargs = "?" })

-- 'RF' reloads the conf files
vim.api.nvim_create_user_command('RF', function()
  vim.cmd('luafile $MYVIMRC')
  vim.notify('Configuration reloaded')
end, {})
