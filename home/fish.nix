{ pkgs, ... }: {
  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;
  programs.nix-index.enableFishIntegration = true;
  services.gpg-agent.enableFishIntegration = true;

  home.packages = with pkgs; [
    bat
    exa
    ripgrep
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      ca = "cargo";
      g = "git";
      n = "nv";
      ls = "exa";
      la = "ll -a";
      nv = "nvim";
      cat = "bat";
      grep = "rg";
      nac = "sudo nixos-rebuild switch --flake ~/.dotfiles#";
    };

    plugins =
      let
        fromNix = name: {
          inherit name;
          inherit (pkgs.fishPlugins.${name}) src;
        };
      in
      map fromNix [
        "bass"
        "colored-man-pages"
        "done"
        "fzf-fish"
        "hydro"
        "pisces"
        "sponge"
      ];

    shellInit = ''
      function chvim
          pushd ~/.dotfiles/home/nvim/
          $EDITOR default.nix
          popd
          nac
      end

      function chhm
          pushd ~/.dotfiles/home/
          $EDITOR default.nix
          popd
          nac
      end

      function chnix
          pushd ~/.dotfiles/
          $EDITOR configuration.nix
          popd
          nac
      end

      function update-monorepo-sdk
          set old_hash $(find . -name Cargo.toml | xargs rg 'subspace-farmer-components = \{ git' | head -1 | cut -d= -f4 | tr -d ' \"}')
          find . -name Cargo.toml | xargs sed -i "s/\"$old_hash\"/\"$argv[1]\"/"
      end

      function update-substrate-sdk
          set old_hash $(find . -name Cargo.toml | xargs rg 'frame-support = \{ .*git' | head -1 | cut -d= -f5 | tr -d ' \"}')
          find . -name Cargo.toml | xargs sed -i "s/\"$old_hash\"/\"$argv[1]\"/"
      end

      set -gx CARGO_TARGET_DIR $HOME/.cargo-target
      fish_add_path $HOME/.local/bin

      set -U fish_user_paths $HOME/.local/bin $fish_user_paths
      set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
      set -U fish_user_paths $HOME/.dotfiles $fish_user_paths
    '';
  };
}
