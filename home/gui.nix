{ pkgs, config, lib, ... }:
let
  cfg = config.features.gui;
in
{
  options.features.gui = with lib; {
    games = mkEnableOption "enable games";
    misc = mkEnableOption "enable misc gui";
  };

  config = {
    home.packages = with pkgs; (if cfg.misc then [
      libreoffice
      discord
      sidequest
      qbittorrent
    ] else [ ]) ++ (if cfg.games then [
      yuzu-ea
      steam
    ] else [ ]);
  };
}
