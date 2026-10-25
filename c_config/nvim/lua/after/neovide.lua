-- neovide config
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font:h13"
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.3
  vim.g.neovide_cursor_trail_size = 0.1
  vim.g.neovide_cursor_animation_length = 0.10
  vim.g.neovide_cursor_short_animation_length = 0.05
  vim.g.neovide_scroll_animation_length = 0.1
  vim.cmd([[colorscheme default]])
  -- ZZ save and restart in neovide instead of exiting it
  vim.keymap.set({ "n" }, "ZZ", function()
    vim.cmd("wa")
    vim.notify("  Files saved use :wq to exit Neovide ", vim.log.levels.INFO, {})
  end, { noremap = true, desc = " save files Neovide" })
  local whichkey = require("which-key")
  whichkey.add({
    { "ZZ", icon = { icon = "", hl = "MiniIconsOrange" } },
    { "ZQ", icon = { icon = "", hl = "MiniIconsRed" }, desc = " Quit Neovide" },
  })
end
