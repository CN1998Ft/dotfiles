# nvim config

This repo contains the nvim configuration.

> [!important]
> The plugins included should not be as exhaustive as the [LazyVim][1].
> But took inspiration from it.

## Minimalistic approach

Only include understanded and necessary plugins.

Additonally, track which plugins are used. And train on this to get better
understanding of neovim/vim.

### Record of plugins

1. Everforest theme.
2. Lualine for bottom status line.
3. nvim-mini, for icons, diff, picker(fuzzy finder), and trailspace.
<!-- add autocmd to trim trailspace, MiniTrialspace.trim_last_lines() -->
4. Write a float terminal.
5. Harpoon for hopping between frequently edited files.


## Neovim 0.12.0
vim.pack, the neovim built-in plugins manager.

Unfortunately, fedora has not yet updated it.
Therefore, finish the minimalistic setup first. And migrate when it is
available.


<!-- reference link -->
[1]: https://www.lazyvim.org/
