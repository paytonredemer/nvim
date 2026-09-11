# Neovim Configuration

This is my personal Neovim setup, used for my day job and fun.

I mainly run it on NixOS with **Neovim nightly**.

## Development

Enter the development shell from the repository root:

```sh
nix develop
nvim
```

The shell runs Neovim nightly against the current working tree, so Lua changes
are available immediately. It also provides `lua-language-server`, `nixd`,
`nixfmt`, and `stylua`.

The system configuration pins this repository in its `flake.lock`. Update that
input and rebuild the system to deploy changes.

Outside Nix, install this repository at Neovim's standard configuration path.
No Nix environment variables are required: Neovim keeps its normal runtime
path, uses the lockfile from the configuration directory, and enables Mason and
Treesitter's own parser installation. This applies to Windows and Linux.

## Plugins

Requires Neovim nightly with `vim.pack` and the `packlockfile` option.
Each modular file in `plugin/` keeps its plugin source next to its configuration.
`pack.gh("owner/repo")` expands GitHub shorthand. Lazy plugins pass one native
spec or an ordered list to `pack.register()` so manual installation and pruning
can see them before they load; eager plugins pass the shorthand directly to
`pack.load()`. The numbered files load the colorscheme, mini.icons compatibility
provider, and Snacks before the remaining UI configuration. The small
`lua/pack.lua` helper installs plugins on first use, defers nonessential
setup until after startup, shares one-time initialization, and replaces
first-use Lua mappings with their normal actions.

| Loading | Plugins |
| --- | --- |
| Startup | Kanagawa, mini.icons, Snacks, Lualine, vim-sleuth, tmux navigator |
| After startup | Oil, mini.surround, ts-comments, hlslens, which-key |
| Native lightweight entry points | bqf (quickfix ftplugin), Overseer (commands) |
| First file read/new file | LSP, Gitsigns, lint, todo-comments, Treesitter context |
| First file read or dashboard restore | Persistence |
| First insert | Blink and friendly-snippets |
| Lua / Markdown filetype | lazydev / render-markdown |
| First mapping or command | DAP and its two extensions |
| First mapping | Conform, Grapple |
| First command (also used by mappings) | Neogit with Plenary and Diffview, Trouble |
| Startup outside Nix | Mason and mason-tool-installer, Treesitter parser installation |

Todo and Treesitter context mappings also work before opening a file.
The dashboard uses `:RestoreSession`, which initializes Persistence if needed.
Oil loads early so opening a directory works. Nix supplies parser/query files;
outside Nix, Treesitter installs the configured parsers and updates them on
`PackChanged`. Plenary is loaded explicitly before either consumer.

Commands use native `CmdUndefined` autocmds: Neovim loads the plugin and retries
the original command. Use the full command name on first invocation; command
completion becomes available after loading. Overseer provides its commands
during startup; Oil provides its command immediately afterward. Grapple instead
loads from its mappings and calls its Lua API directly.

`nvim-pack-lock.json` preserves the plugin revisions from the previous setup.
On first launch, native packages are installed from that lockfile, including
packages whose runtime loading is deferred. Update with `:packupdate`, review
the changes, then `:write` to accept. After adding a new lazy plugin source,
either trigger it once or run `:PackInstall` to install and lock every declared
plugin without loading their runtime files. Restart after changing plugin
declarations, then run `:PackPrune` to review and remove plugins no longer in
the config. Inspect packages with `:lua vim.print(vim.pack.get())`. The old
manager's dashboard entry and search mapping have been removed. lazydev is
still used for Lua development; it is independent of the old plugin manager.

Run plugin maintenance from `nix develop`, where the configuration and lockfile
point directly at this writable checkout. The packaged configuration reads the
pinned lockfile from the Nix store and does not create a writable copy.
