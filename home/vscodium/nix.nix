{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      jnoortheen.nix-ide
    ];
    userSettings = {
      "nix.serverPath" = "nil";
    };
  };
}

