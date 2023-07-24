{ config, lib, ... }:
let
  cfg = config.features.sound.pulseaudioAndAlsa;
in
{
  options.features.sound.pulseaudioAndAlsa.enable = lib.mkEnableOption "enable pulseaudio and alsa";

  config = lib.mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
