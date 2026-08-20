{
  description = "Payton's Neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      neovim-nightly-overlay,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "copilot-language-server";
          };
        in
        {
          default = pkgs.mkShell {
            packages = [
              neovim-nightly-overlay.packages.${system}.default
            ]
            ++ (with pkgs; [
              # General Neovim dependencies
              tree-sitter
              luajitPackages.luarocks
              gcc
              nodejs_22
              ripgrep
              fd
              lua5_1
              luajit
              fzf
              git
              gnumake
              imagemagick
              ghostscript
              tectonic
              sqlite

              # LSP servers
              bash-language-server
              clang-tools
              harper
              lua-language-server
              nixd
              vscode-langservers-extracted
              pyright
              rust-analyzer
              typescript-language-server
              copilot-language-server

              # Linters and formatters
              isort
              black
              codespell
              gitlint
              mypy
              nixfmt
              proselint
              shellcheck
              shfmt
              stylua

              # Debug adapter dependencies
              lldb
            ])
            ++ (
              with pkgs;
              lib.optionals stdenv.hostPlatform.isLinux [
                inotify-tools
                xclip
              ]
            );

            shellHook = ''
              export NVIM_DEV_XDG="$(mktemp -d)"
              ln -s "$PWD" "$NVIM_DEV_XDG/nvim"
              export XDG_CONFIG_HOME="$NVIM_DEV_XDG"
              export SQLITE3_LIB_PATH="${pkgs.sqlite.out}/lib/libsqlite3.so"

              cleanup_nvim_dev() {
                rm -rf "$NVIM_DEV_XDG"
              }
              trap cleanup_nvim_dev EXIT

              echo "Neovim is using the live config at $PWD"
            '';
          };
        }
      );
    };
}
