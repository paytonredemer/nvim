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
            config.allowUnfreePredicate =
              pkg: nixpkgs.lib.getName pkg == "copilot-language-server";
          };
          inherit (pkgs) lib;

          neovimNightly =
            neovim-nightly-overlay.packages.${system}.default;

          treesitterBundle =
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          treesitterFiles = pkgs.symlinkJoin {
            name = "nvim-treesitter-files";
            paths = [ treesitterBundle ] ++ treesitterBundle.dependencies;
          };
          treesitterRuntime =
            pkgs.runCommand "nvim-treesitter-runtime" { } ''
              mkdir -p "$out"
              ln -s "${treesitterFiles}/parser" "$out/parser"
              ln -s "${treesitterFiles}/queries" "$out/queries"
            '';

          runtimePackages = with pkgs; [
            fd
            fzf
            gcc
            ghostscript
            git
            gnumake
            imagemagick
            lua5_1
            luajit
            luajitPackages.luarocks
            nodejs_22
            python3
            ripgrep
            sqlite
            tectonic

            bash-language-server
            clang-tools
            copilot-language-server
            harper
            lua-language-server
            nixd
            pyright
            rust-analyzer
            typescript-language-server
            vscode-langservers-extracted

            black
            codespell
            gitlint
            isort
            mypy
            nixfmt
            proselint
            shellcheck
            shfmt
            stylua

            lldb
          ]
          ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
            pkgs.inotify-tools
            pkgs.xclip
          ];

          wrappedNeovim =
            pkgs.wrapNeovimUnstable neovimNightly {
              luaRcContent = ''
                vim.g.packaged_config_dir = "${self}"
                vim.opt.runtimepath:prepend("${self}")
                dofile("${self}/init.lua")
              '';

              wrapperArgs = [
                "--suffix"
                "PATH"
                ":"
                (lib.makeBinPath runtimePackages)
                "--set"
                "NVIM_NIX_ENV"
                "1"
                "--set"
                "NVIM_TREESITTER_RTP"
                "${treesitterRuntime}"
                "--set"
                "SQLITE3_LIB_PATH"
                "${pkgs.sqlite.out}/lib/libsqlite3.so"
              ];
            };

          devNeovim = pkgs.writeShellScriptBin "nvim" ''
            exec "${neovimNightly}/bin/nvim" \
              --cmd "lua vim.g.packaged_config_dir = vim.env.NVIM_DEV_CONFIG" \
              --cmd "set runtimepath^=$NVIM_DEV_CONFIG" \
              -u "$NVIM_DEV_CONFIG/init.lua" \
              "$@"
          '';
        in
        {
          inherit
            pkgs
            runtimePackages
            treesitterRuntime
            wrappedNeovim
            devNeovim
            ;
        };
    in
    {
      packages = forAllSystems (
        system:
        let
          env = mkSystem system;
        in
        {
          default = env.wrappedNeovim;
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${(mkSystem system).wrappedNeovim}/bin/nvim";
        };
      });

      devShells = forAllSystems (
        system:
        let
          env = mkSystem system;
        in
        {
          default = env.pkgs.mkShell {
            packages = [ env.devNeovim ] ++ env.runtimePackages;

            shellHook = ''
              export NVIM_DEV_CONFIG="$PWD"
              export NVIM_NIX_ENV=1
              export NVIM_TREESITTER_RTP="${env.treesitterRuntime}"
              export SQLITE3_LIB_PATH="${env.pkgs.sqlite.out}/lib/libsqlite3.so"

              echo "Neovim is using the live config at $NVIM_DEV_CONFIG"
            '';
          };
        }
      );
    };
}
