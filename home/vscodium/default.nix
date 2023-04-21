{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./rust.nix
  ];

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;

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
      tabnine.tabnine-vscode

      # Spellcheck
      streetsidesoftware.code-spell-checker

      yzhang.markdown-all-in-one

      redhat.vscode-yaml

      tamasfe.even-better-toml

      ms-azuretools.vscode-docker

      # git and github
      github.vscode-pull-request-github
    ];

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    userSettings = {
      # Spaw ESC and Caps
      "keyboard.dispatch" = "keyCode";
      "workbench.colorTheme" = "Better Solarized Dark";

      "workbench.iconTheme" = "material-icon-theme";
      "material-icon-theme.folders.theme" = "classic";

      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";

      "editor.fontLigatures" = true;
      "explorer.decorations.badges" = false;

      # hide the menu bar unless alt is pressed
      "window.menuBarVisibility" = "toggle";
      # the minimap gets in the way
      "editor.minimap.enabled" = false;
      # scroll with an animation
      "editor.smoothScrolling" = true;
      "workbench.list.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;
      # blink the cursor in terminal
      "terminal.integrated.cursorBlinking" = true;
      # line style cursor in terminal
      "terminal.integrated.cursorStyle" = "line";
      # fix fuzzy text in integrated terminal
      "terminal.integrated.gpuAcceleration" = "on";

      # show vcs changes and staged changes as a tree
      "scm.defaultViewMode" = "tree";

      ## Saving and Formatting ##

      # auto-save when the active editor loses focus
      "files.autoSave" = "onFocusChange";
      # format pasted code if the formatter supports a range
      "editor.formatOnPaste" = true;
      # if the plugin supports range formatting always use that
      "editor.formatOnSaveMode" = "modificationsIfAvailable";
      # insert a newline at the end of a file when saved
      "files.insertFinalNewline" = true;
      # trim whitespace trailing at the ends of lines on save
      "files.trimTrailingWhitespace" = true;

      ## VCS Behavior ##

      # prevent pollute history with whitespace changes
      "diffEditor.ignoreTrimWhitespace" = false;

      ## Navigation Behavior ##

      # scrolling in tab bar switches
      "workbench.editor.scrollToSwitchTabs" = true;
      # name of current scope sticks to top of editor pane
      "editor.stickyScroll.enabled" = true;
      # larger indent
      "workbench.tree.indent" = 16;
    };
  };
}
