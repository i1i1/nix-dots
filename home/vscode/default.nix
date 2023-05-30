{ pkgs, ... }:

let
  # No telemetry config. Taken from here: https://gist.github.com/hyperupcall/99e355405611be6c4e0a38b6e3e8aad0
  noTelemetrySettings = {
    "clangd.checkUpdates" = false;
    "code-runner.enableAppInsights" = false;
    "docker-explorer.enableTelemetry" = false;
    "extensions.ignoreRecommendations" = true;
    "gitlens.showWelcomeOnInstall" = false;
    "gitlens.showWhatsNewAfterUpgrades" = false;
    "java.help.firstView" = "none";
    "java.help.showReleaseNotes" = false;
    "julia.enableTelemetry" = false;
    "kite.showWelcomeNotificationOnStartup" = false;
    "liveServer.settings.donotShowInfoMsg" = true;
    "Lua.telemetry.enable" = false;
    "material-icon-theme.showWelcomeMessage" = false;
    "pros.showWelcomeOnStartup" = false;
    "pros.useGoogleAnalytics" = false;
    "redhat.telemetry.enabled" = false;
    "rpcServer.showStartupMessage" = false;
    "shellcheck.disableVersionCheck" = true;
    "sonarlint.disableTelemetry" = true;
    "telemetry.enableCrashReporter" = false;
    "telemetry.enableTelemetry" = false;
    "telemetry.telemetryLevel" = "off";
    "terraform.telemetry.enabled" = false;
    "update.showReleaseNotes" = false;
    "vsicons.dontShowNewVersionMessage" = true;
    "workbench.welcomePage.walkthroughs.openOnInstall" = false;
  };
in
{
  imports = [
    ./nix.nix
    ./rust.nix
    ./solidity.nix
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
      tabnine.tabnine-vscode

      # Python
      ms-python.python

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

    userSettings = noTelemetrySettings // {
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
