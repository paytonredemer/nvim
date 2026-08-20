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
      self,
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
      mkSystem =
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "copilot-language-server";
          };
          runtimePackages = [
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
          configHome = pkgs.runCommand "payton-nvim-config" { } ''
            mkdir -p "$out"
            ln -s ${self} "$out/nvim"
          '';
        in
        {
          inherit pkgs runtimePackages;
          app = pkgs.writeShellApplication {
            name = "nvim";
            runtimeInputs = runtimePackages;
            text = ''
              run_config="$(mktemp -d)"
              trap 'rm -rf "$run_config"' EXIT
              cp -RL "${configHome}/nvim" "$run_config/nvim"
              chmod -R u+w "$run_config/nvim"

              export XDG_CONFIG_HOME="$run_config"
              export SQLITE3_LIB_PATH="${pkgs.sqlite.out}/lib/libsqlite3.so"
              nvim "$@"
            '';
          };
        };
    in
    {
      packages = forAllSystems (system: {
        default = (mkSystem system).app;
      });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${(mkSystem system).app}/bin/nvim";
        };
      });

      devShells = forAllSystems (
        system:
        let
          env = mkSystem system;
        in
        {
          default = env.pkgs.mkShell {
            packages = env.runtimePackages;

            shellHook = ''
              export NVIM_DEV_XDG="$(mktemp -d)"
              ln -s "$PWD" "$NVIM_DEV_XDG/nvim"
              export XDG_CONFIG_HOME="$NVIM_DEV_XDG"
              export SQLITE3_LIB_PATH="${env.pkgs.sqlite.out}/lib/libsqlite3.so"

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
