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
---@param filename string the filename without the extension
---@param extension string
local function template_injection(filename, extension)
  local shebang = {}
  ---@type string[]
  local clang_config_files = { ".clangd", ".clang-format" }
  ---@type boolean
  local clang_config = vim.tbl_contains(clang_config_files, filename)
  if extension == "sh" or extension == "" and not clang_config then
    shebang = { [[#!/usr/bin/env bash]], [[cd "$(dirname "$0")" && echo "[Current dir: $PWD]"]] }
  elseif extension == "bat" then
    shebang = {
      [[@echo off]],
      [[setlocal enabledelayedexpansion]],
      [[cd /D "%~dp0"]],
    }
  elseif extension == "py" and filename ~= "__init__" and filename ~= "api" then
    shebang = {
      [[#!/usr/bin/env python]],
      [[import ]],
      [[ ]],
      [[def main() -> None:]],
      [[    return None]],
      [[if __name__ == "__main__":]],
      [[    main()]],
    }
  elseif extension == "" and filename == ".clang-format" then
    shebang = {
      [[AccessModifierOffset: -4]],
      [[AlignAfterOpenBracket: Align]],
      [[AlignConsecutiveAssignments: Consecutive]],
      [[AlignConsecutiveDeclarations: Consecutive]],
      [[AlignConsecutiveMacros: Consecutive]],
      [[AlignEscapedNewlines: Left]],
      [[AlignOperands: true]],
      [[AllowShortBlocksOnASingleLine: false]],
      [[AllowShortCaseLabelsOnASingleLine: false]],
      [[AllowShortFunctionsOnASingleLine: None]],
      [[AllowShortIfStatementsOnASingleLine: false]],
      [[AllowShortLoopsOnASingleLine: false]],
      [[BasedOnStyle: LLVM]],
      [[BinPackArguments: true]],
      [[BinPackParameters: true]],
      [[BreakBeforeBraces: Allman]],
      [[ColumnLimit: 80]],
      [[DisableFormat: false]],
      [[IndentWidth: 4]],
      [[PenaltyReturnTypeOnItsOwnLine: 20]],
      [[PointerAlignment: Right]],
      [[ReferenceAlignment: Right]],
      [[ReflowComments: false]],
      [[SortIncludes: false]],
      [[SpaceAfterCStyleCast: false]],
      [[SpaceBeforeAssignmentOperators: true]],
      [[SpaceBeforeCaseColon: false]],
      [[SpacesBeforeTrailingComments: 2]],
      [[SpacesInCStyleCastParentheses: false]],
      [[SpacesInContainerLiterals: false]],
      [[SpacesInParentheses: false]],
    }
  elseif extension == "" and filename == ".clangd" then
    shebang = {
      [[CompileFlags:]],
      [[  Add: []],
      [[    "-std= ",]],
      [[    "-Iinclude",]],
      [[    "-I/opt/homebrew/include",]],
      [==[  ]]==],
      [[]],
      [[Completion:]],
      [[  HeaderInsertion: Never]],
    }
  end
  for i, v in ipairs(shebang) do
    vim.fn.append(i - 1, v)
  end
end

M.c_template_injection = c_template_injection
M.template_injection = template_injection

return M
