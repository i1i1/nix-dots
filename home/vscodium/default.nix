{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      # Vim
      vscodevim.vim

      # Visuals
      ginfuru.ginfuru-better-solarized-dark-theme
      pkief.material-icon-theme

      # AI
      zhang-renyang.chat-gpt
      sourcegraph.cody-ai
      sourcegraph.sourcegraph

      # Spellcheck
      streetsidesoftware.code-spell-checker

      yzhang.markdown-all-in-one

      jnoortheen.nix-ide

      # Rust
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      serayuzgur.crates

      redhat.vscode-yaml

      # git and github
      github.vscode-pull-request-github
      eamodio.gitlens
    ];

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    userSettings = {
      # Spaw ESC and Caps
      "keyboard.dispatch" = "keyCode";
      "workbench.colorTheme" = "Better Solarized Dark";

      "nix.serverPath" = "nil";

      "rust-analyzer.server.path" = "/home/i1i1/.rustup/toolchains/nightly-2023-04-02-x86_64-unknown-linux-gnu/bin/rust-analyzer";

      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";

      "editor.fontLigatures" = true;
      "explorer.decorations.badges" = false;
    };
  };
}
