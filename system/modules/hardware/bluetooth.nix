{ config, lib, ... }:
let
  cfg = config.features.hardware.bluetooth;
in
{
  options.features.hardware.bluetooth.enable = lib.mkEnableOption "enable bluetooth";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
    services.blueman.enable = true;
  };
}
