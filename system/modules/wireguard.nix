{ config, lib, ... }:

let
  cfg = config.features.networking.wireguard;
in
{
  options.features.networking.wireguard = with lib; {
    enable = mkEnableOption "enable wireguard";
    keyCommand = mkOption { type = types.listOf types.str; };
    pubkey = mkOption { type = types.str; };
    endpoint = mkOption { type = types.str; };
  };

  config = lib.mkIf cfg.enable {
    deployment.keys."wireguard-key".keyCommand = cfg.keyCommand;
    networking.wg-quick.interfaces.wg0 = {
      address = [ "10.0.103.2/24" ];
      dns = [ "10.0.103.1" ];
      privateKeyFile = "/run/keys/wireguard-key";

      peers = [{
        inherit (cfg) endpoint;
        publicKey = cfg.pubkey;
        allowedIPs = [ "0.0.0.0/0" ];
        persistentKeepalive = 25;
      }];
    };
  };
}
