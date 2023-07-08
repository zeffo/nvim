

return function(lvim) 
  lvim.opt.relativenumber = true
  lvim.opt.number = true
  lvim.opt.signcolumn = 'auto'
  lvim.g.mapleader = " "
  lvim.g.cmp_enabled = true
  lvim.g.diagnostics_mode = 3
  lvim.g.icons_enabled = true
  lvim.g.ui_notifications_enabled = true
  lvim.g.autoformat_enabled = true

 

  -- We only need this if we're on Windows...

  if vim.loop.os_uname().sysname ~= 'Linux' then
    lvim.opt.shell = "powershell"
    lvim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    lvim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
 		lvim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    lvim.opt.shellquote = ""
    lvim.opt.shellxquote = ""
  end

  return lvim
    
  
end

