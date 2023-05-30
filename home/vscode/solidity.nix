{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      # nomicfoundation.hardhat-solidity
      juanblanco.solidity
    ];
    userSettings = {
      # "redhat.telemetry.enabled" = false;
    };
  };
}
