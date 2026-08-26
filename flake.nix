{
  description = "Payton's Neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixCats,
      neovim-nightly-overlay,
      ...
    }:
    let
      inherit (nixCats) utils;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSystem = utils.eachSystem systems;
      luaPath = ./.;

      extra_pkg_config.allowUnfreePredicate =
        pkg: nixpkgs.lib.getName pkg == "copilot-language-server";

      dependencyOverlays = [
        (utils.standardPluginOverlay inputs)
      ];

      categoryDefinitions =
        {
          pkgs,
          ...
        }:
        {
          lspsAndRuntimeDeps.general = with pkgs; [
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
          ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
            pkgs.inotify-tools
            pkgs.xclip
          ];

          startupPlugins.general = with pkgs.vimPlugins; [
            lazy-nvim
            nvim-treesitter.withAllGrammars
          ];

          environmentVariables.general = {
            NVIM_NIX_ENV = "1";
            SQLITE3_LIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3.so";
          };
        };

      packageDefinitions.nvim =
        {
          pkgs,
          ...
        }:
        {
          settings = {
            aliases = [ "vim" ];
            neovim-unwrapped =
              neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
            suffix-path = true;
            wrapRc = "NVIM_DEV_MODE";
            unwrappedCfgPath =
              utils.mkLuaInline "os.getenv('NVIM_DEV_CONFIG')";
          };

          categories.general = true;
        };

      defaultPackageName = "nvim";
    in
    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs {
          inherit system;
          config = extra_pkg_config;
        };
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;

        apps.default = {
          type = "app";
          program = "${defaultPackage}/bin/nvim";
        };

        devShells.default = pkgs.mkShell {
          packages = [ defaultPackage ];
          shellHook = ''
            export NVIM_DEV_MODE=1
            export NVIM_DEV_CONFIG="$PWD"
            echo "Neovim is using the live config at $NVIM_DEV_CONFIG"
          '';
        };
      }
    )
    // {
      overlays = utils.makeOverlays luaPath {
        inherit
          nixpkgs
          dependencyOverlays
          extra_pkg_config
          ;
      } categoryDefinitions packageDefinitions defaultPackageName;
    };
}
