# Neovim Configuration

This is my personal Neovim setup, used for my day job and fun.

I mainly run it on NixOS with **Neovim nightly**.

Plugins are installed with Neovim's native `vim.pack` API and pinned in
`nvim-pack-lock.json`. Use `:packupdate` to review updates and `:write` in the
review buffer to apply them.

Plugin sources are declared together in `lua/plugins.lua`; individual files
under `lua/plugins/` contain only setup and mappings when needed.

## Development

Enter the development shell from the repository root:

```sh
nix develop
nvim
```

The shell runs Neovim nightly against the current working tree, so Lua changes
are available immediately. It also provides `lua-language-server`, `nixd`,
`nixfmt`, and `stylua`.

The system configuration pins this repository in its `flake.lock`. After
