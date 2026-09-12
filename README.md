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

Install Git and the tools required by Mason (`:checkhealth mason`). Parser
installation additionally requires `tree-sitter` CLI **0.26.1 or newer** (use
your system package manager or an upstream release, not npm), `curl`, `tar`,
and a C compiler on PATH. On Linux, install GCC or Clang; on Windows, use a
working LLVM/MinGW toolchain or launch Neovim from a Visual Studio developer
shell with `cl` available. Mason does not provision these parser prerequisites.
The config assumes these dependencies are installed. Use
`:checkhealth nvim-treesitter` to diagnose build failures.
Highlighting is retried for open buffers when parser installation finishes.

## Plugins

Requires Neovim nightly with `vim.pack` and the `packlockfile` option.
Each modular file in `plugin/` keeps its plugin source next to its configuration.
`pack.gh("owner/repo")` expands GitHub shorthand. Lazy plugins pass one native
spec or an ordered list to `pack.register()` so manual installation and pruning
can see them before they load; eager plugins pass the shorthand directly to
`pack.load()`. The numbered files load the colorscheme, mini.icons compatibility
provider, and Snacks before the remaining UI configuration. The small
`lua/pack.lua` helper installs plugins on first use, defers nonessential
setup with `vim.schedule` (not an idle/render guarantee), shares one-time
initialization, and replaces first-use Lua mappings with their normal actions.
For repeated declarations, the first declaration is used.

| Loading | Plugins |
| --- | --- |
| Startup | Kanagawa, mini.icons, Snacks, Lualine, vim-sleuth, tmux navigator, LSP configuration |
| After startup | Oil, mini.surround, ts-comments, hlslens, which-key |
| Native lightweight entry points | bqf (quickfix ftplugin), Overseer (commands) |
| First file read/new file | Gitsigns, lint, todo-comments, Treesitter context |
| First file read or dashboard restore | Persistence |
| First insert | Blink and friendly-snippets |
| Lua / Markdown filetype | lazydev / render-markdown |
| First mapping or command | DAP and its two extensions |
| First mapping | Conform, Grapple |
| First command (also used by mappings) | Neogit with Plenary and Diffview, Trouble |
| Startup outside Nix | Mason and mason-tool-installer, Treesitter parser installation |

Todo and Treesitter context mappings also work before opening a file.
LSP servers still start only for matching buffers, including unnamed buffers.
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

Run plugin updates and declaration changes from `nix develop`, where the
configuration and lockfile point directly at this writable checkout. Pack
always uses that configured lockfile directly; no temporary copy is created.

Deploying or rolling back the Nix configuration does **not** automatically
switch already-installed plugin revisions. After changing generations, start
the packaged Neovim and run `:PackSync`. Review the changes and
`:write` to restore the locked revisions, then restart Neovim. Unlike
`:packupdate`, this restores the lockfile's revisions instead of selecting new
ones, and includes unloaded plugins. It may fetch missing Git history.
On the tested nightly, restoring against a read-only lockfile applies the
plugin checkouts, then reports a permission error when Neovim tries to write
the lockfile. This final write error is accepted; the original stays unchanged.
Other errors, such as fetch or checkout failures, can still prevent restoration.
Development and
packaged Neovim share the same plugin directory; close other instances before
synchronizing. Run `:PackPrune`
separately if the matching config no longer declares an installed plugin.
