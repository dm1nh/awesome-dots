local awful = require("awful")

-- see: https://github.com/rxyhn/yoru/blob/main/config/awesome/helpers/run.lua

local M = {}

--- @param cmd string
function M.run_once_pgrep(cmd)
  local findme = cmd
  local first_space = cmd:find(" ")
  if first_space then
    findme = cmd:sub(0, first_space - 1)
  end
  awful.spawn.easy_async_with_shell(string.format("pgrep -u $USER -x %s > /dev/null || %s", findme, cmd))
end

--- @param findme string
--- @param cmd string
function M.run_once_ps(findme, cmd)
  awful.spawn.easy_async_with_shell(string.format("ps -C %s | wc -l", findme), function(stdout)
    if tonumber(stdout) ~= 2 then
      awful.spawn(cmd, false)
    end
  end)
end

--- @param cmd string
function M.run_once_grep(cmd)
  awful.spawn.easy_async_with_shell(string.format([[ps aux | grep "%s" | grep -v "grep"]], cmd), function(stdout)
    if stdout == "" or stdout == nil then
      awful.spawn(cmd, false)
    end
  end)
end

--- @param cmd string
--- @param running_callback? function
--- @param not_running_callback? function
function M.check_if_running(cmd, running_callback, not_running_callback)
  awful.spawn.easy_async_with_shell(string.format("ps aux | grep '%s' | grep -v 'grep'", cmd), function(stdout)
    if stdout == "" or stdout == nil then
      if not_running_callback ~= nil then
        not_running_callback()
      end
    else
      if running_callback ~= nil then
        running_callback()
      end
    end
  end)
end

return M
