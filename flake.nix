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
      perSystem =
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ neovim-nightly-overlay.overlays.default ];
            config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "copilot-language-server";
          };
          inherit (pkgs) lib;

          neovimNightly = pkgs.neovim-unwrapped;

          treesitterBundle = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          treesitterFiles = pkgs.symlinkJoin {
            name = "nvim-treesitter-files";
            paths = [ treesitterBundle ] ++ treesitterBundle.dependencies;
          };
          treesitterRuntime = pkgs.runCommand "nvim-treesitter-runtime" { } ''
            mkdir -p "$out"
            ln -s "${treesitterFiles}/parser" "$out/parser"
            ln -s "${treesitterFiles}/queries" "$out/queries"
          '';

          runtimePackages =
            with pkgs;
            [
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

          wrappedNeovim = pkgs.wrapNeovimUnstable neovimNightly {
            luaRcContent = ''
              dofile(vim.fs.joinpath(vim.env.NVIM_CONFIG_DIR, "init.lua"))
            '';
            wrapperArgs = [
              "--suffix"
              "PATH"
              ":"
              (lib.makeBinPath runtimePackages)
              "--set-default"
              "NVIM_APPNAME"
              "payton-nvim"
              "--set-default"
              "NVIM_CONFIG_DIR"
              "${self}"
              "--set"
              "NVIM_NIX_ENV"
              "1"
              "--set"
              "NVIM_TREESITTER_RTP"
              "${treesitterRuntime}"
              "--set"
              "SQLITE3_LIB_PATH"
              "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}"
            ];
          };

          devShell = pkgs.mkShell {
            packages = [ wrappedNeovim ] ++ runtimePackages;

            shellHook = ''
              export NVIM_CONFIG_DIR="$PWD"

              echo "Neovim is using the live config at $NVIM_CONFIG_DIR"
            '';
          };

          checks = {
            formatting =
              pkgs.runCommand "nvim-formatting"
                {
                  nativeBuildInputs = [
                    pkgs.stylua
                    pkgs.nixfmt
                  ];
                }
                ''
                  cd ${self}
                  stylua --check .
                  nixfmt --check flake.nix
                  touch "$out"
                '';

            lua-syntax =
              pkgs.runCommand "nvim-lua-syntax"
                {
                  nativeBuildInputs = [ pkgs.luajit ];
                }
                ''
                  cd ${self}
                  find . -name '*.lua' -print0 | while IFS= read -r -d "" file; do
                    luajit -b "$file" /dev/null
                  done
                  touch "$out"
                '';
          };
        in
        {
          package = wrappedNeovim;
          app = {
            type = "app";
            program = "${wrappedNeovim}/bin/nvim";
            meta.description = "Payton's Neovim configuration";
          };
          inherit devShell checks;
        };

      outputsBySystem = nixpkgs.lib.genAttrs systems perSystem;
    in
    {
      checks = nixpkgs.lib.mapAttrs (_: output: output.checks) outputsBySystem;

      packages = nixpkgs.lib.mapAttrs (_: output: {
        default = output.package;
      }) outputsBySystem;

      apps = nixpkgs.lib.mapAttrs (_: output: {
        default = output.app;
      }) outputsBySystem;

      devShells = nixpkgs.lib.mapAttrs (_: output: {
        default = output.devShell;
      }) outputsBySystem;
    };
}
