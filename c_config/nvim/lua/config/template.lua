local M = {}

-- c/cpp specific template injection
local function c_template_injection()
  local buffername = vim.fn.expand("%:t")
  local header_guard = string.gsub(buffername, "%.", "_")
  header_guard = string.upper(header_guard)
  local header_content = {
    "#ifndef " .. header_guard,
    "#define " .. header_guard,
    "",
    "#endif " .. "// " .. header_guard,
  }
  for i, v in ipairs(header_content) do
    vim.fn.append(i - 1, v)
  end
end

-- other files template injection
local function template_injection(extension)
  local shebang = {}
  if extension == "sh" then
    shebang = { [[#!/usr/bin/env bash]], [[cd "$(dirname "$0")" && echo "[Current dir: $PWD]"]] }
  elseif extension == "bat" then
    shebang = {
      [[@echo off]],
      [[setlocal enabledelayedexpansion]],
      [[cd /D "%~dp0"]],
    }
  elseif extension == "py" then
    shebang = { [[#!/usr/bin/env python]] }
  end
  for i, v in ipairs(shebang) do
    vim.fn.append(i - 1, v)
  end
end

M.c_template_injection = c_template_injection
M.template_injection = template_injection

return M
