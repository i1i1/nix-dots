{ config, lib, ... }:
let
  cfg = config.features.sound.pipewire;
in
{
  options.features.sound.pipewire.enable = lib.mkEnableOption "enable pipewire";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      socketActivation = true;
      wireplumber.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
  };
}
