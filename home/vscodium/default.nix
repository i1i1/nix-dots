{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./rust.nix
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

      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";

      "editor.fontLigatures" = true;
      "explorer.decorations.badges" = false;
    };
  };
}
