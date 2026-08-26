# Neovim Configuration

This is my personal Neovim setup, used for my day job and fun.

I mainly run it on NixOS with **Neovim nightly**.

## Development

Enter the development shell from the repository root:

```sh
nix develop
nvim
```

The shell sets nixCats to load the current working tree directly, so Lua changes
are available after restarting Neovim without rebuilding the package. Lazy
continues to manage plugin specifications and `lazy-lock.json`; nixCats provides
Neovim nightly, Lazy itself, Treesitter grammars, LSP servers, formatters, and
other runtime dependencies.

For the packaged, store-backed configuration:

```sh
nix run
```

The system configuration pins this repository in its `flake.lock`. After
